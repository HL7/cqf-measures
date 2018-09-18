library ColorectalCancerScreening version '7.2.000'

// changed to use STU3 FHIR model
using FHIR version '3.0.0'

include Adult_Outpatient_Encounters version '1.1.000' called AdultOutpatientEncounters
include MATGlobalCommonFunctions version '2.0.000' called Global
include Hospice version '1.0.000' called Hospice
// added FHIRHelpers conversion Library
include FHIRHelpers version '3.0.0' called FHIRHelpers

valueset "Annual Wellness Visit" using "2.16.840.1.113883.3.526.3.1240"
valueset "Diabetes" using "2.16.840.1.113883.3.464.1003.103.12.1001"
valueset "Encounter Inpatient" using "2.16.840.1.113883.3.666.5.307"
valueset "Ethnicity" using "2.16.840.1.114222.4.11.837"
valueset "HbA1c Laboratory Test" using "2.16.840.1.113883.3.464.1003.198.12.1013"
valueset "Home Healthcare Services" using "2.16.840.1.113883.3.464.1003.101.12.1016"
valueset "Hospice care ambulatory" using "2.16.840.1.113762.1.4.1108.15"
valueset "Office Visit" using "2.16.840.1.113883.3.464.1003.101.12.1001"
valueset "ONC Administrative Sex" using "2.16.840.1.113762.1.4.1"
valueset "Payer" using "2.16.840.1.114222.4.11.3591"
valueset "Preventive Care Services - Established Office Visit, 18 and Up" using "2.16.840.1.113883.3.464.1003.101.12.1025"
valueset "Preventive Care Services-Initial Office Visit, 18 and Up" using "2.16.840.1.113883.3.464.1003.101.12.1023"
valueset "Race" using "2.16.840.1.114222.4.11.836"

parameter "Measurement Period" Interval<DateTime>

context Patient

// see http://www.hl7.org/fhir/us/qicore/IndividualCharacteristic.html for Patient Characteristic mappings
define "SDE Ethnicity":
	[Patient: extension.ombCategory in "Ethnicity"] 

// DT: Not addressed in QI Core / FHIR
define "SDE Payer":
	["Patient Characteristic Payer": "Payer"]

define "SDE Race":
	[Patient: extension.ombCategory in "Race"] 

define "SDE Sex":
	[Patient] P where P.gender in {'male', 'female'} 
	  return P.gender



define "Denominator":
	"Initial Population"



	 
Define Has Most Recent Elevated Hba1c
Last([Observation: "HbA1c Laboratory Test"] HighHbA1c
		where HighHbA1c.effective during "Measurement Period"
			and HighHbA1c.value is not null
			and HighHbA1c.status  in {'final', 'amended', 'corrected'}
		sort by HighHbA1c.issued
).value > 9 '%'

Define Has Most Recent HbA1c Without Result
Last([Observation: "HbA1c Laboratory Test"] HbA1cNoResult
		where HbA1cNoResult.effective during "Measurement Period"
		sort by HbA1cNoResult.issued
).result is null


Define Has No Record Of HbA1c
not exists [Observation: "HbA1c Laboratory Test"] NoHbA1c
	where NoHbA1c.effective during "Measurement Period"


Define Numerator
"Has Most Recent Elevated Hba1c"
	or "Has Most Recent HbA1c Without Result"
	or "Has No Record Of HbA1c"

Define Denominator Exclusions
Hospice."Has Hospice"

Define Initial Population
exists ( ["Patient Characteristic Birthdate"] Birthdate
		where Global."CalendarAgeInYearsAt"(Patient.birthDate, start of "Measurement Period")in Interval[18, 75]
)
	and exists ( AdultOutpatientEncounters."Qualifying Encounters" )
	and exists ( ["Diagnosis": "Diabetes"] Diabetes
			where Diabetes.prevalencePeriod overlaps "Measurement Period"
	)
 

Define AdultOutpatientEncounters.Qualifying Encounters
( [Encounter: "Office Visit"]
	union [Encounter: "Annual Wellness Visit"]
	union [Encounter: "Preventive Care Services - Established Office Visit, 18 and Up"]
	union [Encounter: "Preventive Care Services-Initial Office Visit, 18 and Up"]
	union [Encounter: "Home Healthcare Services"] ) ValidEncounter
	where ValidEncounter.performed during "Measurement Period"

 
 Define Hospice.Has Hospice
exists ( [Encounter: "Encounter Inpatient"] DischargeHospice
		where ( DischargeHospice.hospitalization.dischargeDisposition as Code ~ "Discharge to home for hospice care (procedure)"
				or DischargeHospice.hospitalization.dischargeDisposition as Code ~ "Discharge to healthcare facility for hospice care (procedure)"
		)
			and DischargeHospice.period ends during "Measurement Period"
)
	or exists ( [Procedure: "Hospice care ambulatory"] HospiceOrder
			where HospiceOrder.AuthoredOn during "Measurement Period"
	)
	or exists ( [Procedure: "Hospice care ambulatory"] HospicePerformed
			where HospicePerformed.performed overlaps "Measurement Period"
	)
