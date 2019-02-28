library VenousThromboembolismProphylaxis version '7.4.000'

using FHIR version '3.0.0'

include FHIRHelpers version '3.0.0' called FHIRHelpers
include MATGlobalCommonFunctions_FHIR version '2.0.000' called Global
include VTEICU_FHIR version '2.4.000' called VTEICU

codesystem "LOINC:2.63": 'http://loinc.org' version 'urn:hl7:version:2.63'

valueset "ONC Administrative Sex": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1'
valueset "Race": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.836'
valueset "Ethnicity": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.837'
valueset "Payer": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.3591'
valueset "Atrial Fibrillation/Flutter": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.202'
valueset "Comfort Measures": 'https://cts.nlm.nih.gov/fhir/ValueSet/1.3.6.1.4.1.33895.1.3.0.45'
valueset "Direct Thrombin Inhibitor": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.205'
valueset "Emergency Department Visit": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.292'
valueset "General or Neuraxial Anesthesia": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.5.1743'
valueset "General Surgery": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.255'
valueset "Glycoprotein IIb/IIIa Inhibitors": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.41'
valueset "Graduated compression stockings (GCS)": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.256'
valueset "Gynecological Surgery": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.257'
valueset "Hemorrhagic Stroke": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.212'
valueset "Hip Fracture Surgery": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.258'
valueset "Hip Replacement Surgery": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.259'
valueset "Injectable Factor Xa Inhibitor for VTE Prophylaxis": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.211'
valueset "INR": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.213'
valueset "Intermittent pneumatic compression devices (IPC)": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.214'
valueset "Intracranial Neurosurgery": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.260'
valueset "Intravenous route": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.222'
valueset "Ischemic Stroke": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.247'
valueset "Knee Replacement Surgery": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.261'
valueset "Low Dose Unfractionated Heparin for VTE Prophylaxis": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.39'
valueset "Low Molecular Weight Heparin for VTE Prophylaxis": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.219'
valueset "Low Risk": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.400'
valueset "Medical Reason": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.473'
valueset "Mental Health Diagnoses": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.105.12.1004'
valueset "Obstetrics": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.263'
valueset "Obstetrics VTE": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.264'
valueset "Oral Factor Xa Inhibitor for VTE Prophylaxis or VTE Treatment": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.134'
valueset "Patient Refusal": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.93'
valueset "Principal": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.14'
valueset "Subcutaneous route": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.223'
valueset "Unfractionated Heparin": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.218'
valueset "Urological Surgery": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.272'
valueset "Venous foot pumps (VFP)": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.230'
valueset "Venous Thromboembolism": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.279'
valueset "Warfarin": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.232'
valueset "Intensive Care Unit": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.23'

code "Risk for venous thromboembolism": '72136-5' from "LOINC:2.63" display 'Risk for venous thromboembolism'

context Patient

/*
define "SDE Ethnicity":
	["Patient Characteristic Ethnicity": "Ethnicity"]

define "SDE Payer":
	["Patient Characteristic Payer": "Payer"]

define "SDE Race":
	["Patient Characteristic Race": "Race"]

define "SDE Sex":
	["Patient Characteristic Sex": "ONC Administrative Sex"]
*/

define "Denominator":
	"Initial Population"

define "ED Visit":
	["Encounter": type in "Emergency Department Visit"] EDVisit
    where EDVisit.status in { 'finished' }

define "Initial Population":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions"

//QA
define "No VTE Prophylaxis Device Applied or Ordered":
  // TODO: Tracker and discussion with DeviceUseStatement owning WG to determine appropriate representation
		(	["Procedure": focalDevice in "Intermittent pneumatic compression devices (IPC)"] DeviceProcedureIPC
		// TODO: Should actually be focalDevice.manipulated.resolve().code
			where DeviceProcedureIPC.notDone is true )
		union
		(	["Procedure": focalDevice in "Venous foot pumps (VFP)"] DeviceProcedureVFP
			where DeviceProcedureVFP.notDone is true)
		union
		(	["Procedure": focalDevice in "Graduated compression stockings (GCS)"]DeviceProcedureGCS
			// TODO: Should actually be focalDevice.manipulated.resolve().code
			where DeviceProcedureGCS.notDone is true )

		union
		 // TODO: Tracker on DeviceRequest for DoNotPerform?
		(
			( ["ProcedureRequest": "Intermittent pneumatic compression devices (IPC)"] DeviceRequestIPC
			where DeviceRequestIPC.intent in { 'order' }
				and DeviceRequestIPC.doNotPerform is true )
		 union
		( ["ProcedureRequest": "Venous foot pumps (VFP)"] DeviceRequestVFP
			where DeviceRequestVFP.intent in { 'order' }
				and DeviceRequestIPC.doNotPerform is true )
		 union
		( ["ProcedureRequest": "Graduated compression stockings (GCS)"] DeviceRequestVFP
 			where DeviceRequestVFP.intent in { 'order' }
 				and DeviceRequestIPC.doNotPerform is true )
		)	NoDeviceRequest
		return "Procedure" {identifier: NoDeviceRequest.identifier, FHIR.provenance.recorded:NoDeviceRequest.authoredOn}
/*option 2 -
(["Procedure": focalDevice in "Intermittent pneumatic compression devices (IPC)"]
Union
["Procedure": focalDevice in "Venous foot pumps (VFP)"] DeviceProcedureVFP]
Union
["Procedure": focalDevice in "Graduated compression stockings (GCS)"]DeviceProcedureGCS]) DeviceProcedure
Where DeviceProcedureGCS.notDone is true
...
Option 3 -
[“Procedure”] DeviceProcdure
	Where (DeviceProcedure.focalDevice in "Intermittent pneumatic compression devices (IPC)"
	   or DeviceProcedure. focalDevice in " Venous foot pumps (VFP)"
 	  or DeviceProcedure. focalDevice in " Graduated compression stockings (GCS)")
	and DeviceProcedure.notDOne is true
	...
*/

// TODO: Add doNotPerform to QICore, suggest support in base Resource
// TODO: Tracker for Device, Not Ordered, ability to represent focalDevice
define "Venous Foot Pumps Applied":
  (["DeviceUseStatement": device.code in "Venous foot pumps(VFP)"]
    union ["DeviceUseStatement": device.code in "Intermittent pneumatic compression devices (IPC)"]
    union ["DeviceUseStatement": device.code in "Graduated compression stockings (GCS)"]
  ) D
    where D.extension['http://example.org/fhir/extensions/notDone'].value is true
    //where D.notDone is true // Needs a QI-Core extension to support
  union (
    ["DeviceRequest": code in "Venous foot pumps(VFP)"]
      union ["DeviceRequest": device.code in "Intermittent pneumatic compression devices (IPC)"]
      union ["DeviceRequest": device.code in "Graduated compression stockings (GCS)"]
  ) D
    where D.intent = 'order'
      and D.extension['http://example.org/fhir/extensions/doNotPerform'].value is true
    //where D.doNotPerform is true // Needs a QI-Core extension to support

//QA
define "No VTE Prophylaxis Device Due to Medical Reason During ED Visit":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		"ED Visit" EDVisit,
		"No VTE Prophylaxis Device Applied or Ordered" NoVTEDevice
		where FHIRHelpers.ToInterval(EDVisit.period) ends 1 hour or less on or before start of FHIRHelpers.ToInterval(QualifyingEncounter.period)
			and (singleton from NoVTEDevice.reasonCode in "Medical Reason")
			and Coalesce(NoVTEDevice.authoredOn, NoVTEDevice.recordedOn) during FHIRHelpers.ToInterval(EDVisit.period)

//QA
define "No VTE Prophylaxis Device Due to Medical Reason on Day of or Day After Admission":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		"No VTE Prophylaxis Device Applied or Ordered" NoVTEDevice
		where (singleton from NoVTEDevice.reasonCode in "Medical Reason")
			and NoVTEDevice.FHIR.provenance.recorded during VTEICU."CalendarDayOfOrDayAfter"(start of FHIRHelpers.ToInterval(QualifyingEncounter.period)) // Update to use authoredOn/recordedOn
		return QualifyingEncounter

//QA
define "No VTE Prophylaxis Medication Administered or Ordered":
	(	["MedicationAdministration"] MedicationAdm
		where ( MedicationAdm.medication as CodeableConcept in "Low Dose Unfractionated Heparin for VTE Prophylaxis"
				or MedicationAdm.medication as CodeableConcept in "Low Molecular Weight Heparin for VTE Prophylaxis"
				or MedicationAdm.medication as CodeableConcept in "Injectable Factor Xa Inhibitor for VTE Prophylaxis"
				or MedicationAdm.medication as CodeableConcept in "Warfarin" )
			and MedicationAdm.notGiven is true
	)
	union
	(	["MedicationRequest": medication in "Low Dose Unfractionated Heparin for VTE Prophylaxes"] NoMedicationOrder // Update to use medication in...
  // TODO: Tracker for QI-core to add doNotPerform extension for MedicationRequest and suggest to the base Resource
	// Use the same pattern for "doNotPerform" above for device
		where ( NoMedicationOrder.medication as CodeableConcept in "Low Dose Unfractionated Heparin for VTE Prophylaxis"
				or NoMedicationOrder.medication as CodeableConcept in "Low Molecular Weight Heparin for VTE Prophylaxis"
				or NoMedicationOrder.medication as CodeableConcept in "Injectable Factor Xa Inhibitor for VTE Prophylaxis"
				or NoMedicationOrder.medication as CodeableConcept in "Warfarin" )
			and NoMedicationOrder.intent in {'order'}
			and NoMedicationOrder.notGiven is true
	) NoMedicationRequest
  // TODO: Profile of MedicationRequest to ensure effective is a Period
	return "MedicationOrder" { id: NoMedicationRequest.id, notGiven: true, authoredOn: Coalesce(NoMedicationRequest.authoredOn, start of NoMedicationRequest.effective) }

//QA
define "No VTE Prophylaxis Medication Due to Medical Reason During ED Visit":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		"ED Visit" EDVisit,
		"No VTE Prophylaxis Medication Administered or Ordered" NoVTEMedication
		where FHIRHelpers.ToInterval(EDVisit.period) ends 1 hour or less on or before start of FHIRHelpers.ToInterval(QualifyingEncounter.period)
			and (singleton from NoVTEMedication.reasonCode in "Medical Reason")
			and NoVTEMedication.FHIR.provenance.recorded during EDVisit.period
		return QualifyingEncounter

//QA
define "No VTE Prophylaxis Medication Due to Medical Reason on Day of or Day After Admission":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		"No VTE Prophylaxis Medication Administered or Ordered" NoVTEMedication
		where (singleton from NoVTEMedication.reasonCode in "Medical Reason")
			and NoVTEMedication.FHIR.provenance.recorded during VTEICU."CalendarDayOfOrDayAfter"(start of FHIRHelpers.ToInterval(QualifyingEncounter.period))
		return QualifyingEncounter

define "No VTE Prophylaxis Device Due to Medical Reason on Day of or Day After Procedure":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		["Procedure, Performed": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
		"No VTE Prophylaxis Device Applied or Ordered" NoVTEDevice
		where NoVTEDevice.negationRationale in "Medical Reason"
			and AnesthesiaProcedure.relevantPeriod ends 1 day after day of start of QualifyingEncounter.relevantPeriod
			and NoVTEDevice.authorDatetime during VTEICU."CalendarDayOfOrDayAfter"(end of AnesthesiaProcedure.relevantPeriod)
		return QualifyingEncounter

//QA
define "Admission Without VTE or Obstetrical Conditions":
		Global."InpatientEncounter" InpatientEncounter
		where not exists (EncounterDiagnosis(InpatientEncounter).code in "Obstetrics"
											or EncounterDiagnosis(InpatientEncounter).code in "Venous Thromboembolism"
											or EncounterDiagnosis(InpatientEncounter).code in "Obstetrics VTE"
											)


		intersect (Global."InpatientEncounter" InpatientEncounter
				without ( ["Condition": code in "Obstetrics"] // Update for all
									union ["Condition": "Venous Thromboembolism"]
									union ["Condition": "Obstetrics VTE"])	Diagnosis
				such that Diagnosis.clinicalStatus = 'active'
        		and Diagnosis..verificationStatus = 'confirmed'
						and Global."Normalize Onset"(Diagnosis.onset) during Global."Hospitalization"(InpatientEncounter)
						)


define "No VTE Prophylaxis Medication Due to Medical Reason on Day of or Day After Procedure":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		["Procedure, Performed": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
		"No VTE Prophylaxis Medication Administered or Ordered" NoVTEMedication
		where NoVTEMedication.negationRationale in "Medical Reason"
			and AnesthesiaProcedure.relevantPeriod ends 1 day after day of start of QualifyingEncounter.relevantPeriod
			and NoVTEMedication.authorDatetime during VTEICU."CalendarDayOfOrDayAfter"(end of AnesthesiaProcedure.relevantPeriod)
		return QualifyingEncounter

//QA
define "Encounter Less Than 2 Days":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		where Global."LengthInDays"(FHIRHelpers.ToInterval(QualifyingEncounter.period))< 2


//QA
define "SCIP VTE Selected Surgery":
		["Procedure": "General Surgery"]
		union ["Procedure": "Gynecological Surgery"]
		union ["Procedure": "Hip Fracture Surgery"]
		union ["Procedure": "Hip Replacement Surgery"]
		union ["Procedure": "Intracranial Neurosurgery"]
		union ["Procedure": "Knee Replacement Surgery"]
		union ["Procedure": "Urological Surgery"]
		//TJC - is it better to apply "procedure.status in {'completed'} here than being in the calling defintion?
    //BTR -> Yes, because the "status = 'completed'" is really part of the "Procedure, Performed", so it makes sense
    // to include here because that's what the QDM version of the expression would have returned

//QA
define "Intervention Comfort Measures":
	(["ProcedureRequest": "Comfort Measures"] P
		where P.intent = 'order')
		union
		(["Procedure": "Comfort Measures"] Proc
	return "ProcedureRequest" {identifier: Proc.identifier, authoredOn: P.FHIR.provenance.recorded}


//QA
define "Intervention Comfort Measures on Day of or Day After Start of Hospitalization":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		with "Intervention Comfort Measures" ComfortMeasures
			such that ComfortMeasure.authoredOn 1 day or less on or after day of star of "Hospitalization"(QualifyingEncounter)

//QA
define "Intervention Comfort Measures on Day of or Day After Procedure":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		["Procedure": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
		"Intervention Comfort Measures" ComfortMeasures
		where  AnesthesiaProcedure.status in {'completed'}
				and FHIRHelpers.ToInterval(AnesthesiaProcedure.performed[performedPeriod] ends 1 day after day of start of FHIRHelpers.ToInterval(QualifyingEncounter.period)
				and ComfortMeasure.authoredOn 1 day or less on or after day of end of FHIRHelpers.ToInterval(AnesthesiaProcedure.performed[period] //TJC - how to apply Procedure.performed[x]
          // BTR -> Just leave off the [period], the FHIRHelpers.ToInterval() expects a FHIR period and so the translator will automatically choose that type
          // This is another case where we will want to profile the Procedure to only use Periods for performed though.
		return QualifyingEncounter

//QA
define "VTE Prophylaxis by Medication Administered or Device Applied":
	( ["MedicationAdministered": "Low Dose Unfractionated Heparin for VTE Prophylaxis"] VTEMedication
			where VTEMedication.status in {'completed'}
						and VTEMedication.dosage.route as CodeableConcept in {'Subcutaneous route'} // TJC - Is "as CodeableConcept" is necessary here?
            // BTR -> It shouldn't be, leave it off and we'll add it back in if we need to when we start to verify the measure with the CQL-to-ELM translator
	)
		union ["MedicationAdministered": "Low Molecular Weight Heparin for VTE Prophylaxis"]
		union ["MedicationAdministered": "Injectable Factor Xa Inhibitor for VTE Prophylaxis"]
		union ["MedicationAdministered": "Warfarin"]
		union
			((["Procedure": "Intermittent pneumatic compression devices (IPC)"]
			union ["Procedure": "Venous foot pumps (VFP)"]
			union ["Procedure": "Graduated compression stockings (GCS)"] ) DeviceApplied
			return "MedicationAdministered" {identifier: DeviceApplied.identifier, FHIRHelpers.ToInterval(effective[Period]): DeviceApplied.performed[period]}
				)  //TJC - how to apply MedicationAdministration.effective[x]?

define "VTE Prophylaxis Received on Day of or Day After Admission or Procedure":
	( from
			"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
			"VTE Prophylaxis by Medication Administered or Device Applied" HasVTEProphylaxis
			where HasVTEProphylaxis.relevantPeriod starts during VTEICU."CalendarDayOfOrDayAfter"(start of QualifyingEncounter.relevantPeriod)
			return QualifyingEncounter
	)
		union ( from
				"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
				["Procedure, Performed": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
				"VTE Prophylaxis by Medication Administered or Device Applied" HasVTEProphylaxis
				where AnesthesiaProcedure.relevantPeriod ends 1 day after day of start of QualifyingEncounter.relevantPeriod
					and HasVTEProphylaxis.relevantPeriod starts during VTEICU."CalendarDayOfOrDayAfter"(end of AnesthesiaProcedure.relevantPeriod)
				return QualifyingEncounter
		)

define "Medication Oral Factor Xa Inhibitor Administered on Day of or Day After Admission or Procedure":
	( from
			"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
			["Medication, Administered": "Oral Factor Xa Inhibitor for VTE Prophylaxis or VTE Treatment"] FactorXaMedication
			where FactorXaMedication.relevantPeriod starts during VTEICU."CalendarDayOfOrDayAfter"(start of QualifyingEncounter.relevantPeriod)
			return QualifyingEncounter
	)
		union ( from
				"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
				["Procedure, Performed": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
				["Medication, Administered": "Oral Factor Xa Inhibitor for VTE Prophylaxis or VTE Treatment"] FactorXaMedication
				where AnesthesiaProcedure.relevantPeriod ends 1 day after day of start of QualifyingEncounter.relevantPeriod
					and FactorXaMedication.relevantPeriod starts during VTEICU."CalendarDayOfOrDayAfter"(end of AnesthesiaProcedure.relevantPeriod)
				return QualifyingEncounter
		)

define "Encounter With Prior or Present Diagnosis of Atrial Fibrillation or VTE":
	( "Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
			with ["Diagnosis": "Atrial Fibrillation/Flutter"] AtrialFibrillation
				such that AtrialFibrillation.prevalencePeriod starts on or before end of QualifyingEncounter.relevantPeriod
	)
		union ( "Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
				where exists ( QualifyingEncounter.diagnoses EncounterDiagnosis
						where EncounterDiagnosis in "Atrial Fibrillation/Flutter"
				)
		)
		union ( "Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
				with ["Diagnosis": "Venous Thromboembolism"] VTEDiagnosis
					such that VTEDiagnosis.prevalencePeriod starts before start of QualifyingEncounter.relevantPeriod
		)

define "Encounter With ICU Location Stay 1 Day or More":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		where exists ( QualifyingEncounter.facilityLocations Location
				where Location.code in "Intensive Care Unit"
					and Global."LengthInDays"(Location.locationPeriod)>= 1
					and Location.locationPeriod starts during VTEICU."CalendarDayOfOrDayAfter"(start of QualifyingEncounter.relevantPeriod)
		)

define "Encounter With Principal Diagnosis of Mental Disorder or Stroke":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		where QualifyingEncounter.principalDiagnosis in "Mental Health Diagnoses"
			or QualifyingEncounter.principalDiagnosis in "Hemorrhagic Stroke"
			or QualifyingEncounter.principalDiagnosis in "Ischemic Stroke"

define "Encounter With Principal Procedure of SCIP VTE Selected Surgery":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		with ( "SCIP VTE Selected Surgery" Procedure
			where Procedure.ordinality in "Principal" ) SelectedProcedure
			such that SelectedProcedure.relevantPeriod during QualifyingEncounter.relevantPeriod

define "Denominator Exclusions":
	"Encounter Less Than 2 Days"
		union "Encounter With ICU Location Stay 1 Day or More"
		union "Encounter With Principal Diagnosis of Mental Disorder or Stroke"
		union "Encounter With Principal Procedure of SCIP VTE Selected Surgery"
		union "Intervention Comfort Measures on Day of or Day After Start of Hospitalization"
		union "Intervention Comfort Measures on Day of or Day After Procedure"

//QA
define "Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions":
	( Global."Inpatient Encounter" InpatientEncounter
			with ["Patient"] BirthDate
				such that Global."CalendarAgeInYearsAt"(BirthDate.birthDate, start of FHIRHelpers.ToInterval(InpatientEncounter.period)>= 18
	)
		intersect "Admission Without VTE or Obstetrical Conditions"

define "Encounter With Prior or Present Procedure of Hip or Knee Replacement Surgery":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		with ( ["Procedure, Performed": "Hip Replacement Surgery"]
			union ["Procedure, Performed": "Knee Replacement Surgery"] ) HipKneeProcedure
			such that HipKneeProcedure.relevantPeriod starts on or before end of QualifyingEncounter.relevantPeriod

define "Low Risk for VTE or Anticoagulant Administered":
	"Low Risk for VTE or Anticoagulant Administered During ED Visit"
		union "Low Risk for VTE or Anticoagulant Administered on Day of or Day After Admission"
		union "Low Risk for VTE or Anticoagulant Administered on Day of or Day After Procedure"

define "No VTE Prophylaxis Due to Medical Reason":
	( "No VTE Prophylaxis Medication Due to Medical Reason During ED Visit"
			intersect "No VTE Prophylaxis Device Due to Medical Reason During ED Visit"
	)
		union ( "No VTE Prophylaxis Medication Due to Medical Reason on Day of or Day After Admission"
				intersect "No VTE Prophylaxis Device Due to Medical Reason on Day of or Day After Admission"
		)
		union ( "No VTE Prophylaxis Medication Due to Medical Reason on Day of or Day After Procedure"
				intersect "No VTE Prophylaxis Device Due to Medical Reason on Day of or Day After Procedure"
		)

define "No VTE Prophylaxis Due to Patient Refusal During ED Visit":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		"ED Visit" EDVisit,
		"No VTE Prophylaxis Medication or Device Due to Patient Refusal" PatientRefusal
		where EDVisit.relevantPeriod ends 1 hour or less on or before start of QualifyingEncounter.relevantPeriod
			and PatientRefusal.authorDatetime during EDVisit.relevantPeriod
		return QualifyingEncounter

define "No VTE Prophylaxis Due to Patient Refusal on Day of or Day After Admission":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		"No VTE Prophylaxis Medication or Device Due to Patient Refusal" PatientRefusal
		where PatientRefusal.authorDatetime during VTEICU."CalendarDayOfOrDayAfter"(start of QualifyingEncounter.relevantPeriod)
		return QualifyingEncounter

define "No VTE Prophylaxis Due to Patient Refusal on Day of or Day After Procedure":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		["Procedure, Performed": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
		"No VTE Prophylaxis Medication or Device Due to Patient Refusal" PatientRefusal
		where AnesthesiaProcedure.relevantPeriod ends 1 day after day of start of QualifyingEncounter.relevantPeriod
			and PatientRefusal.authorDatetime during VTEICU."CalendarDayOfOrDayAfter"(end of AnesthesiaProcedure.relevantPeriod)
		return QualifyingEncounter

define "No VTE Prophylaxis Medication or Device Due to Patient Refusal":
	( "No VTE Prophylaxis Medication Administered or Ordered"
		union "No VTE Prophylaxis Device Applied or Ordered" ) NoVTEProphylaxis
		where NoVTEProphylaxis.negationRationale in "Patient Refusal"

define "No VTE Prophylaxis Due to Patient Refusal":
	"No VTE Prophylaxis Due to Patient Refusal During ED Visit"
		union "No VTE Prophylaxis Due to Patient Refusal on Day of or Day After Admission"
		union "No VTE Prophylaxis Due to Patient Refusal on Day of or Day After Procedure"

define "Numerator":
	"VTE Prophylaxis Received on Day of or Day After Admission or Procedure"
		union ( "Medication Oral Factor Xa Inhibitor Administered on Day of or Day After Admission or Procedure"
				intersect ( "Encounter With Prior or Present Diagnosis of Atrial Fibrillation or VTE"
						union "Encounter With Prior or Present Procedure of Hip or Knee Replacement Surgery"
				)
		)
		union "Low Risk for VTE or Anticoagulant Administered"
		union "No VTE Prophylaxis Due to Medical Reason"
		union "No VTE Prophylaxis Due to Patient Refusal"

//QA
define "Is In Low Risk for VTE or On Anticoagulant":
	( ["Observation": "Risk for venous thromboembolism"] VTERiskAssessment
			where VTERiskAssessment.value as CodeableConcept in "Low Risk"
	)
		union ( ["Observation": "INR"] INRLabTest
				where INRLabTest.value as Quantity > 3.0
				return "Observation" { identifier: INRLabTest.identifier, FHIR.provenance.recorded: INRLabTest.issued }
		)
		union ((( ["MedicationAdministered": "Unfractionated Heparin"] UnfractionatedHeparin
					where UnfractionatedHeparin.dosage.route as CodeableConcept in "Intravenous route"
						)
				union ["MedicationAdministered": "Direct Thrombin Inhibitor"]
				union ["MedicationAdministered": "Glycoprotein IIb/IIIa Inhibitors"] ) AnticoagulantMedication
					return "Observation" { identifier: AnticoagulantMedication.identifier, FHIR.provenance.recorded: start of FHIRHelpers.ToInterval(effective[period])}
		)

define "Low Risk for VTE or Anticoagulant Administered During ED Visit":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		"ED Visit" EDVisit,
		"Is In Low Risk for VTE or On Anticoagulant" VTERiskAssessment
		where EDVisit.relevantPeriod ends 1 hour or less on or before start of QualifyingEncounter.relevantPeriod
			and VTERiskAssessment.authorDatetime during EDVisit.relevantPeriod
		return QualifyingEncounter

define "Low Risk for VTE or Anticoagulant Administered on Day of or Day After Admission":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		with "Is In Low Risk for VTE or On Anticoagulant" VTERiskAssessment
			such that VTERiskAssessment.authorDatetime during VTEICU."CalendarDayOfOrDayAfter"(start of QualifyingEncounter.relevantPeriod)

define "Low Risk for VTE or Anticoagulant Administered on Day of or Day After Procedure":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		["Procedure, Performed": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
		"Is In Low Risk for VTE or On Anticoagulant" VTERiskAssessment
		where AnesthesiaProcedure.relevantPeriod ends 1 day after day of start of QualifyingEncounter.relevantPeriod
			and VTERiskAssessment.authorDatetime during VTEICU."CalendarDayOfOrDayAfter"(end of AnesthesiaProcedure.relevantPeriod)
		return QualifyingEncounter
