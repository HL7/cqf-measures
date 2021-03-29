library VenousThromboembolismProphylaxis version '7.4.000'

using QDM version '5.3'

include MATGlobalCommonFunctions version '2.0.000' called Global
include VTEICU version '2.4.000' called VTEICU

codesystem "LOINC:2.63": 'urn:oid:2.16.840.1.113883.6.1' version 'urn:hl7:version:2.63'

valueset "ONC Administrative Sex": 'urn:oid:2.16.840.1.113762.1.4.1'
valueset "Race": 'urn:oid:2.16.840.1.114222.4.11.836'
valueset "Ethnicity": 'urn:oid:2.16.840.1.114222.4.11.837'
valueset "Payer": 'urn:oid:2.16.840.1.114222.4.11.3591'
valueset "Atrial Fibrillation/Flutter": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.202'
valueset "Comfort Measures": 'urn:oid:1.3.6.1.4.1.33895.1.3.0.45'
valueset "Direct Thrombin Inhibitor": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.205'
valueset "Emergency Department Visit": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.292'
valueset "General or Neuraxial Anesthesia": 'urn:oid:2.16.840.1.113883.3.666.5.1743'
valueset "General Surgery": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.255'
valueset "Glycoprotein IIb/IIIa Inhibitors": 'urn:oid:2.16.840.1.113762.1.4.1045.41'
valueset "Graduated compression stockings (GCS)": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.256'
valueset "Gynecological Surgery": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.257'
valueset "Hemorrhagic Stroke": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.212'
valueset "Hip Fracture Surgery": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.258'
valueset "Hip Replacement Surgery": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.259'
valueset "Injectable Factor Xa Inhibitor for VTE Prophylaxis": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.211'
valueset "INR": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.213'
valueset "Intermittent pneumatic compression devices (IPC)": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.214'
valueset "Intracranial Neurosurgery": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.260'
valueset "Intravenous route": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.222'
valueset "Ischemic Stroke": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.247'
valueset "Knee Replacement Surgery": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.261'
valueset "Low Dose Unfractionated Heparin for VTE Prophylaxis": 'urn:oid:2.16.840.1.113762.1.4.1045.39'
valueset "Low Molecular Weight Heparin for VTE Prophylaxis": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.219'
valueset "Low Risk": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.400'
valueset "Medical Reason": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.473'
valueset "Mental Health Diagnoses": 'urn:oid:2.16.840.1.113883.3.464.1003.105.12.1004'
valueset "Obstetrics": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.263'
valueset "Obstetrics VTE": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.264'
valueset "Oral Factor Xa Inhibitor for VTE Prophylaxis or VTE Treatment": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.134'
valueset "Patient Refusal": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.93'
valueset "Principal": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.14'
valueset "Subcutaneous route": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.223'
valueset "Unfractionated Heparin": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.218'
valueset "Urological Surgery": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.272'
valueset "Venous foot pumps (VFP)": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.230'
valueset "Venous Thromboembolism": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.279'
valueset "Warfarin": 'urn:oid:2.16.840.1.113883.3.117.1.7.1.232'
valueset "Intensive Care Unit": 'urn:oid:2.16.840.1.113762.1.4.1110.23'

code "Risk for venous thromboembolism": '72136-5' from "LOINC:2.63" display 'Risk for venous thromboembolism'

context Patient

define "SDE Ethnicity":
	["Patient Characteristic Ethnicity": "Ethnicity"]

define "SDE Payer":
	["Patient Characteristic Payer": "Payer"]

define "SDE Race":
	["Patient Characteristic Race": "Race"]

define "SDE Sex":
	["Patient Characteristic Sex": "ONC Administrative Sex"]

define "Denominator":
	"Initial Population"

define "ED Visit":
	["Encounter, Performed": "Emergency Department Visit"]

define "Initial Population":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions"

define "No VTE Prophylaxis Device Applied or Ordered":
	["Device, Not Applied": "Intermittent pneumatic compression devices (IPC)"]
		union ["Device, Not Applied": "Venous foot pumps (VFP)"]
		union ["Device, Not Applied": "Graduated compression stockings (GCS)"]
		union ["Device, Not Ordered": "Intermittent pneumatic compression devices (IPC)"]
		union ["Device, Not Ordered": "Venous foot pumps (VFP)"]
		union ["Device, Not Ordered": "Graduated compression stockings (GCS)"]

define "No VTE Prophylaxis Device Due to Medical Reason During ED Visit":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		"ED Visit" EDVisit,
		"No VTE Prophylaxis Device Applied or Ordered" NoVTEDevice
		where EDVisit.relevantPeriod ends 1 hour or less on or before start of QualifyingEncounter.relevantPeriod
			and NoVTEDevice.negationRationale in "Medical Reason"
			and NoVTEDevice.authorDatetime during EDVisit.relevantPeriod
		return QualifyingEncounter

define "No VTE Prophylaxis Device Due to Medical Reason on Day of or Day After Admission":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		"No VTE Prophylaxis Device Applied or Ordered" NoVTEDevice
		where NoVTEDevice.negationRationale in "Medical Reason"
			and NoVTEDevice.authorDatetime during VTEICU."CalendarDayOfOrDayAfter"(start of QualifyingEncounter.relevantPeriod)
		return QualifyingEncounter

define "No VTE Prophylaxis Medication Administered or Ordered":
	["Medication, Not Administered": "Low Dose Unfractionated Heparin for VTE Prophylaxis"]
		union ["Medication, Not Administered": "Low Molecular Weight Heparin for VTE Prophylaxis"]
		union ["Medication, Not Administered": "Injectable Factor Xa Inhibitor for VTE Prophylaxis"]
		union ["Medication, Not Administered": "Warfarin"]
		union ["Medication, Not Ordered": "Low Dose Unfractionated Heparin for VTE Prophylaxis"]
		union ["Medication, Not Ordered": "Low Molecular Weight Heparin for VTE Prophylaxis"]
		union ["Medication, Not Ordered": "Injectable Factor Xa Inhibitor for VTE Prophylaxis"]
		union ["Medication, Not Ordered": "Warfarin"]

define "No VTE Prophylaxis Medication Due to Medical Reason During ED Visit":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		"ED Visit" EDVisit,
		"No VTE Prophylaxis Medication Administered or Ordered" NoVTEMedication
		where EDVisit.relevantPeriod ends 1 hour or less on or before start of QualifyingEncounter.relevantPeriod
			and NoVTEMedication.negationRationale in "Medical Reason"
			and NoVTEMedication.authorDatetime during EDVisit.relevantPeriod
		return QualifyingEncounter

define "No VTE Prophylaxis Medication Due to Medical Reason on Day of or Day After Admission":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		"No VTE Prophylaxis Medication Administered or Ordered" NoVTEMedication
		where NoVTEMedication.negationRationale in "Medical Reason"
			and NoVTEMedication.authorDatetime during VTEICU."CalendarDayOfOrDayAfter"(start of QualifyingEncounter.relevantPeriod)
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

define "Admission Without VTE or Obstetrical Conditions":
	( Global."Inpatient Encounter" InpatientEncounter
			where not ( exists ( InpatientEncounter.diagnoses EncounterDiagnoses
						where ( EncounterDiagnoses in "Obstetrics"
								or EncounterDiagnoses in "Venous Thromboembolism"
								or EncounterDiagnoses in "Obstetrics VTE"
						)
				)
			)
	)
		intersect ( Global."Inpatient Encounter" InpatientEncounter
				without ( ["Diagnosis": "Obstetrics"]
					union ["Diagnosis": "Venous Thromboembolism"]
					union ["Diagnosis": "Obstetrics VTE"] ) Diagnosis
					such that Diagnosis.prevalencePeriod starts during Global."Hospitalization"(InpatientEncounter)
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

define "Encounter Less Than 2 Days":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		where Global."LengthInDays"(QualifyingEncounter.relevantPeriod)< 2

define "SCIP VTE Selected Surgery":
	["Procedure, Performed": "General Surgery"]
		union ["Procedure, Performed": "Gynecological Surgery"]
		union ["Procedure, Performed": "Hip Fracture Surgery"]
		union ["Procedure, Performed": "Hip Replacement Surgery"]
		union ["Procedure, Performed": "Intracranial Neurosurgery"]
		union ["Procedure, Performed": "Knee Replacement Surgery"]
		union ["Procedure, Performed": "Urological Surgery"]

define "Intervention Comfort Measures":
	["Intervention, Order": "Comfort Measures"]
		union ["Intervention, Performed": "Comfort Measures"]

define "Intervention Comfort Measures on Day of or Day After Start of Hospitalization":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
		with "Intervention Comfort Measures" ComfortMeasures
			such that Coalesce(start of ComfortMeasures.relevantPeriod, ComfortMeasures.authorDatetime)1 day or less on or after day of start of Global."Hospitalization"(QualifyingEncounter)

define "Intervention Comfort Measures on Day of or Day After Procedure":
	from
		"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter,
		["Procedure, Performed": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
		"Intervention Comfort Measures" ComfortMeasures
		where AnesthesiaProcedure.relevantPeriod ends 1 day after day of start of QualifyingEncounter.relevantPeriod
			and Coalesce(start of ComfortMeasures.relevantPeriod, ComfortMeasures.authorDatetime)1 day or less on or after day of end of AnesthesiaProcedure.relevantPeriod
		return QualifyingEncounter

define "VTE Prophylaxis by Medication Administered or Device Applied":
	( ["Medication, Administered": "Low Dose Unfractionated Heparin for VTE Prophylaxis"] VTEMedication
			where VTEMedication.route in "Subcutaneous route"
	)
		union ["Medication, Administered": "Low Molecular Weight Heparin for VTE Prophylaxis"]
		union ["Medication, Administered": "Injectable Factor Xa Inhibitor for VTE Prophylaxis"]
		union ["Medication, Administered": "Warfarin"]
		union ["Device, Applied": "Intermittent pneumatic compression devices (IPC)"]
		union ["Device, Applied": "Venous foot pumps (VFP)"]
		union ["Device, Applied": "Graduated compression stockings (GCS)"]

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

define "Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions":
	( Global."Inpatient Encounter" InpatientEncounter
			with ["Patient Characteristic Birthdate"] BirthDate
				such that Global."CalendarAgeInYearsAt"(BirthDate.birthDatetime, start of InpatientEncounter.relevantPeriod)>= 18
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

define "Is In Low Risk for VTE or On Anticoagulant":
	( ["Assessment, Performed": "Risk for venous thromboembolism"] VTERiskAssessment
			where VTERiskAssessment.result in "Low Risk"
	)
		union ( ["Laboratory Test, Performed": "INR"] INRLabTest
				where INRLabTest.result > 3.0
				return "Assessment, Performed" { id: INRLabTest.id, authorDatetime: INRLabTest.resultDatetime }
		)
		union ( ( ["Medication, Administered": "Unfractionated Heparin"] UnfractionatedHeparin
					where UnfractionatedHeparin.route in "Intravenous route"
			)
				union ["Medication, Administered": "Direct Thrombin Inhibitor"]
				union ["Medication, Administered": "Glycoprotein IIb/IIIa Inhibitors"] AnticoagulantMedication
					return "Assessment, Performed" { id: AnticoagulantMedication.id, authorDatetime: start of AnticoagulantMedication.relevantPeriod }
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
