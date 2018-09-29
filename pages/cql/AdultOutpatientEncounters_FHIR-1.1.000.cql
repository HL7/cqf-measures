library AdultOutpatientEncountersFHIR version '1.1.000'

using FHIR version '3.0.0'

include FHIRHelpers version '3.0.0' called FHIRHelpers

valueset "Office Visit": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1001'
valueset "Annual Wellness Visit": 'urn:oid:2.16.840.1.113883.3.526.3.1240'
valueset "Preventive Care Services - Established Office Visit, 18 and Up": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1025'
valueset "Preventive Care Services-Initial Office Visit, 18 and Up": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1023'
valueset "Home Healthcare Services": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1016'

context Patient

define function "Qualifying Encounters"(MeasurementPeriod Interval<DateTime>):
	(
	    ( [Encounter: "Office Visit"] E where E.status = 'final' )
		union ( [Encounter: "Annual Wellness Visit"] E where E.status = 'final' )
		union ( [Encounter: "Preventive Care Services - Established Office Visit, 18 and Up"] E where E.status = 'final' )
		union ( [Encounter: "Preventive Care Services-Initial Office Visit, 18 and Up"] E where E.status = 'final' )
		union ( [Encounter: "Home Healthcare Services"] E where E.status = 'final' )
    ) ValidEncounter
		where ValidEncounter.period during day of MeasurementPeriod