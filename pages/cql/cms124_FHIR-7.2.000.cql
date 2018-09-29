library CervicalCancerScreening version '7.2.000'

using FHIR version '3.0.0'

include MATGlobalCommonFunctionsFHIR version '2.0.000' called Global
include AdultOutpatientEncountersFHIR version '1.1.000' called AdultOutpatientEncounters
include HospiceFHIR version '1.0.000' called Hospice
include FHIRHelpers version '3.0.0' called FHIRHelpers

codesystem "SNOMEDCT:2017-09": 'http://snomed.info/sct' version 'urn:hl7:version:2017-09'

valueset "ONC Administrative Sex": 'urn:oid:2.16.840.1.113762.1.4.1'
valueset "Race": 'urn:oid:2.16.840.1.114222.4.11.836'
valueset "Ethnicity": 'urn:oid:2.16.840.1.114222.4.11.837'
valueset "Payer": 'urn:oid:2.16.840.1.114222.4.11.3591'
valueset "Female": 'urn:oid:2.16.840.1.113883.3.560.100.2'
valueset "Home Healthcare Services": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1016'
valueset "Hysterectomy with No Residual Cervix": 'urn:oid:2.16.840.1.113883.3.464.1003.198.12.1014'
valueset "Office Visit": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1001'
valueset "Pap Test": 'urn:oid:2.16.840.1.113883.3.464.1003.108.12.1017'
valueset "Preventive Care Services - Established Office Visit, 18 and Up": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1025'
valueset "Preventive Care Services-Initial Office Visit, 18 and Up": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1023'
valueset "HPV Test": 'urn:oid:2.16.840.1.113883.3.464.1003.110.12.1059'

code "Congenital absence of cervix (disorder)": '37687000' from "SNOMEDCT:2017-09" display 'Congenital absence of cervix (disorder)'

parameter "Measurement Period" Interval<DateTime>

context Patient

define "Ethnicity Categories":
		flatten (
        (
            Patient.extension Extensions
                where Extensions.url = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity'
        ) EthnicityExtensions
            where EthnicityExtensions.extension.url = 'ombCategory'
        return EthnicityExtensions.extension
		)

define "SDE Ethnicity":
		"Ethnicity Categories" EthnicityExt
				where FHIRHelpers.ToCode(EthnicityExt.value as FHIR.Coding) in "Ethnicity"
		return FHIRHelpers.ToCode(EthnicityExt.value as FHIR.Coding).display

define "SDE Payer":
    [Coverage: type in "Payer"] Payer
      return {
        code: Payer.type,
        period: Payer.period
      }


define "Race Categories":
		flatten (
        (
            Patient.extension Extensions
                where Extensions.url = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-race'
        ) RaceExtensions
            where RaceExtensions.extension.url = 'ombCategory'
        return RaceExtensions.extension
    )

define "SDE Race":
		"Race Categories" RaceExt
				where FHIRHelpers.ToCode(RaceExt.value as FHIR.Coding) in "Race"
		return FHIRHelpers.ToCode(RaceExt.value as FHIR.Coding).display

define "SDE Sex":
		[Patient: gender in "ONC Administrative Sex"] P
			return P.gender

define "Numerator":
	exists "Pap Test Within 3 Years"
		or exists "Pap Test With HPV Within 5 Years"

define "Denominator":
	"Initial Population"

define "Pap Test with Results":
	[Observation: "Pap Test"] PapTest
		where PapTest.value is not null
			and PapTest.status in { 'final', 'amended', 'corrected' }

define "Pap Test Within 3 Years":
	"Pap Test with Results" PapTest
		where PapTest.effective 3 years or less before end of "Measurement Period"

define "PapTest Within 5 Years":
	( "Pap Test with Results" PapTestOver30YearsOld
			where Global."CalendarAgeInYearsAt"(FHIRHelpers.ToDate(Patient.birthDate), start of Global."Get Choice Interval - dateTime or Period"(PapTestOver30YearsOld.effective))>= 30
				and PapTestOver30YearsOld.effective 5 years or less before end of "Measurement Period"
	)

define "Pap Test With HPV Within 5 Years":
	"PapTest Within 5 Years" PapTestOver30YearsOld
		with [Observation: "HPV Test"] HPVTest
			such that HPVTest.value is not null
				and (
					HPVTest.effective starts 1 day or less before or on day of start of Global."Get Choice Interval - dateTime or Period"(PapTestOver30YearsOld.effective)
						or HPVTest.effective starts less than 1 day after or on day of start of Global."Get Choice Interval - dateTime or Period"(PapTestOver30YearsOld.effective)
				)
				and HPVTest.status in { 'final', 'amended', 'corrected' }

define "Denominator Exclusion":
	Hospice."Has Hospice"("Measurement Period")
		or exists "Surgical Absence of Cervix"
		or exists "Absence of Cervix"

define "Absence of Cervix":
	[Condition : "Congenital absence of cervix (disorder)"] NoCervixBirth
		where NoCervixBirth.onset starts before end "Measurement Period"
			and NoCervixBirth.clinicalStatus = 'active'

define "Surgical Absence of Cervix":
	[Procedure: "Hysterectomy with No Residual Cervix"] NoCervixHysterectomy
		where NoCervixHysterectomy.performed ends before end "Measurement Period"
			and NoCervixHysterectomy.status = 'completed'

define "Initial Population":
	Patient.gender = 'female'
		and Global."CalendarAgeInYearsAt"(FHIRHelpers.ToDate(Patient.birthDate), start of "Measurement Period") in Interval[23, 64]
		and exists AdultOutpatientEncounters."Qualifying Encounters"("Measurement Period")
