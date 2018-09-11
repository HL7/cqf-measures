library Common version '1.0'

using FHIR version '3.0.0'

include FHIRHelpers version '3.0.0' called FHIRHelpers

codesystem "LOINC:2.46": 'urn:oid:2.16.840.1.113883.6.1' version 'urn:hl7:version:2.46'
codesystem "SNOMEDCT:2016-03": 'urn:oid:2.16.840.1.113883.6.96' version 'urn:hl7:version:2016-03'
codesystem "SNOMEDCT:2017-03": 'urn:oid:2.16.840.1.113883.6.96' version 'urn:hl7:version:2017-03'
codesystem "SNOMEDCT:2017-09": 'urn:oid:2.16.840.1.113883.6.96' version 'urn:hl7:version:2017-09'
codesystem "RoleCode": 'http://hl7.org/fhir/v3/RoleCode'

valueset "Office Visit": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1001'
valueset "Annual Wellness Visit": 'urn:oid:2.16.840.1.113883.3.526.3.1240'
valueset "Preventive Care Services - Established Office Visit, 18 and Up": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1025'
valueset "Preventive Care Services-Initial Office Visit, 18 and Up": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1023'
valueset "Home Healthcare Services": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1016'

valueset "Encounter Inpatient": 'urn:oid:2.16.840.1.113883.3.666.5.307'
valueset "Hospice care ambulatory": 'urn:oid:2.16.840.1.113762.1.4.1108.15'

valueset "Emergency Department Visit": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.292'

code "Birthdate": '21112-8' from "LOINC:2.46" display 'Birth date'
code "Dead": '419099009' from "SNOMEDCT:2016-03" display 'Dead'
code "Discharge to healthcare facility for hospice care (procedure)": '428371000124100' from "SNOMEDCT:2017-09" display 'Discharge to healthcare facility for hospice care (procedure)'
code "Discharge to home for hospice care (procedure)": '428361000124107' from "SNOMEDCT:2017-09" display 'Discharge to home for hospice care (procedure)'
code "ER": 'ER' from "RoleCode" display 'Emergency room'
code "ICU": 'ICU' from "RoleCode" display 'Intensive care unit'

context Patient

/*
*
*    From Adult_Outpatient_Encounters library
*
*/

define function "Qualifying Encounters"(MeasurementPeriod Interval<DateTime>):
	(
	    ( [Encounter: "Office Visit"] E where E.status = 'final' )
		union ( [Encounter: "Annual Wellness Visit"] E where E.status = 'final' )
		union ( [Encounter: "Preventive Care Services - Established Office Visit, 18 and Up"] E where E.status = 'final' )
		union ( [Encounter: "Preventive Care Services-Initial Office Visit, 18 and Up"] E where E.status = 'final' )
		union ( [Encounter: "Home Healthcare Services"] E where E.status = 'final' )
    ) ValidEncounter
		where ValidEncounter.period during day of MeasurementPeriod

/*
*
*    From Hospice library
*
*/

define function "Has Hospice"(MeasurementPeriod Interval<DateTime>):
	exists (
	    [Encounter: "Encounter Inpatient"] DischargeHospice
			where DischargeHospice.status = 'final'
			    and (
			        DischargeHospice.hospitalization.dischargeDisposition as Code ~ "Discharge to home for hospice care (procedure)"
					    or DischargeHospice.hospitalization.dischargeDisposition as Code ~ "Discharge to healthcare facility for hospice care (procedure)"
			    )
				and DischargeHospice.period ends during day of MeasurementPeriod
	)
    or exists (
        [ProcedureRequest: "Hospice care ambulatory"] HospiceOrder
            where HospiceOrder.intent = 'order'
                and HospiceOrder.authoredOn in day of MeasurementPeriod
    )
    or exists (
        [Procedure: "Hospice care ambulatory"] HospicePerformed
            where HospicePerformed.status = 'completed'
                and HospicePerformed.performed overlaps MeasurementPeriod
    )

/*
*
*    From MATGlobalCommonFunctions library
*
*/

define "Encounter":
	[Encounter: "Emergency Department Visit"] E
	    where E.status = 'finished'

define function "Inpatient Encounter"(MeasurementPeriod Interval<DateTime>):
	[Encounter: "Encounter Inpatient"] EncounterInpatient
		where EncounterInpatient.status = 'finished'
		    and "LengthInDays"(EncounterInpatient.period) <= 120
			and EncounterInpatient.period ends during MeasurementPeriod

define function "ToDate"(Value DateTime):
	DateTime(year from Value, month from Value, day from Value, 0, 0, 0, 0, timezone from Value)

define function "CalendarAgeInDaysAt"(BirthDateTime DateTime, AsOf DateTime):
	days between ToDate(BirthDateTime)and ToDate(AsOf)

define function "CalendarAgeInDays"(BirthDateTime DateTime):
	CalendarAgeInDaysAt(BirthDateTime, Today())

define function "CalendarAgeInMonthsAt"(BirthDateTime DateTime, AsOf DateTime):
	months between ToDate(BirthDateTime)and ToDate(AsOf)

define function "CalendarAgeInMonths"(BirthDateTime DateTime):
	CalendarAgeInMonthsAt(BirthDateTime, Today())

define function "CalendarAgeInYearsAt"(BirthDateTime DateTime, AsOf DateTime):
	years between ToDate(BirthDateTime)and ToDate(AsOf)

define function "CalendarAgeInYears"(BirthDateTime DateTime):
	CalendarAgeInYearsAt(BirthDateTime, Today())

define function "LengthInDays"(Value Interval<DateTime>):
	difference in days between start of Value and end of Value

define function "ED Visit"(TheEncounter FHIR.Encounter):
    singleton from (
        [Encounter: "Emergency Department Visit"] EDVisit
            where EDVisit.status = 'finished'
                and EDVisit.period ends 1 hour or less on or before start of TheEncounter.period
    )

define function "Hospitalization"(TheEncounter FHIR.Encounter):
	( "ED Visit"(TheEncounter) ) X
    return
        if X is null then TheEncounter.period
        else Interval[start of X.period, end of TheEncounter.period]

define function "Hospitalization Locations"(TheEncounter FHIR.Encounter):
	( "ED Visit"(TheEncounter) ) EDEncounter
    return
        if EDEncounter is null then TheEncounter.location
        else flatten { EDEncounter.location, TheEncounter.location }

define function "Hospitalization Length of Stay"(TheEncounter FHIR.Encounter):
	LengthInDays("Hospitalization"(TheEncounter))

define function "Hospital Admission Time"(TheEncounter FHIR.Encounter):
	start of "Hospitalization"(TheEncounter)

define function "Hospital Discharge Time"(TheEncounter FHIR.Encounter):
	end of TheEncounter.period

define function "Hospital Arrival Time"(TheEncounter FHIR.Encounter):
	start of First(
	    ( "Hospitalization Locations"(TheEncounter) ) HospitalLocation
			sort by start of period
	).period

define function "Hospital Departure Time"(TheEncounter FHIR.Encounter):
	end of Last(
	    ( "Hospitalization Locations"(TheEncounter) ) HospitalLocation
			sort by start of period
	).period

define function "Emergency Department Arrival Time"(TheEncounter FHIR.Encounter):
	start of (
	    singleton from (
	        ( "Hospitalization Locations"(TheEncounter) ) HospitalLocation
				where HospitalLocation.type ~ "ER"
		)
	).period

define function "First Inpatient Intensive Care Unit"(TheEncounter FHIR.Encounter):
	First(
	    ( TheEncounter.location ) HospitalLocation
			where HospitalLocation.type ~ "ICU"
				and HospitalLocation.period during TheEncounter.period
			sort by start of period
	)

/*
*
*    CQFMeasures Common Logic
*
*/

define function "Normalize Onset"(onset Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
    if onset is FHIR.dateTime then Interval[onset.value, onset.value]
	else if onset is FHIR.Period then FHIRHelpers.ToInterval(onset as FHIR.Period)
	else null