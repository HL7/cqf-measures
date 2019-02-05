library CMS105 version '7'

using FHIR version '3.0.0'

include FHIRHelpers version '3.0.0'
include TJC_Overall version '1.4.000' called TJC

// TODO: Use the VSAC canonical URL for these valuesets
valueset "ONC Administrative Sex": 'urn:oid:2.16.840.1.113762.1.4.1'
valueset "Race": 'urn:oid:2.16.840.1.114222.4.11.836'
valueset "Ethnicity": 'urn:oid:2.16.840.1.114222.4.11.837'
valueset "Payer": 'urn:oid:2.16.840.1.114222.4.11.3591'
valueset "LDL-c": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.215'
valueset "Medical Reason": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.473'
valueset "Patient Refusal": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.93'
valueset "Statin Allergen": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.423'
valueset "Statin Grouper": 'urn:oid:2.16.840.1.113762.1.4.1110.19'

code "Medication-dischargeMedication": '8654-6' from "LOINC:2.46" display 'Hospital Discharge medications'

context Patient

define "Statin Allergy":
	["AllergyIntolerance": "Statin Allergen"]

define "Statin at Discharge":
	["MedicationRequest": "Statin Grouper"] M
    where M.intent in { 'order', 'instance-order' }
      and M.category = 'community' // represents on the discharge medication list

// TODO: Log a tracker in QI-Core to add "request-doNotPerform" to the MedicationRequest profile
// TODO: Add a request-doNotPerform-reason extension and use it in MedicationRequest
// TODO: Update this to use those extensions (or the first-class elements in QUICK)
define "Statin Not Given at Discharge":
	["MedicationStatement": "Statin Grouper"] NoStatinDischarge
		where NoStatinDischarge.reasonCode in "Medical Reason"
			or NoStatinDischarge.reasonCode in "Patient Refusal"

define "Denominator":
	"Initial Population"

define "Initial Population":
	TJC."Encounter with Principal Diagnosis and Age"

define "Numerator":
	TJC."Ischemic Stroke Encounter" IschemicStrokeEncounter
		with "Statin at Discharge" DischargeStatin
			such that DischargeStatin.authoredOn during IschemicStrokeEncounter.period //Not sure is authoredOn is correct http://hl7.org/fhir/us/qicore/Medication.html#Medication.2C_Discharge

define "Encounter with Max LDL less than 70 mg per dL":
	TJC."Ischemic Stroke Encounter" IschemicStrokeEncounter
		where Max(["Observation": "LDL-c"] Ldl
				where Ldl.isseud during Interval[Global."ToDate"(start of IschemicStrokeEncounter.relevantPeriod - 30 days), end of IschemicStrokeEncounter.relevantPeriod]
				return Ldl.valueQuantity.value
		)< 70 //'mg/dL' //need to make sure valueQuantity.unit is correct

define "Denominator Exclusions":
	TJC."Ischemic Stroke Encounters with Discharge Status"
		union TJC."Comfort Measures during Hospitalization"

define "Denominator Exceptions":
	( TJC."Ischemic Stroke Encounter" IschemicStrokeEncounter
			with "Statin Not Given at Discharge" NoDischargeStatin
				such that NoDischargeStatin.authoredOn during IschemicStrokeEncounter.period
	)
		union ( TJC."Ischemic Stroke Encounter" IschemicStrokeEncounter
				with "Statin Allergy" StatinAllergy
					such that StatinAllergy.onsetDateTime on or before end of IschemicStrokeEncounter.period
		)
		union "Encounter with Max LDL less than 70 mg per dL"

//define "SDE Ethnicity":
//	["Patient Characteristic Ethnicity": "Ethnicity"]

//define "SDE Payer":
//	["Patient Characteristic Payer": "Payer"]

//define "SDE Race":
//	["Patient Characteristic Race": "Race"]

//define "SDE Sex":
//	["Patient Characteristic Sex": "ONC Administrative Sex"]
