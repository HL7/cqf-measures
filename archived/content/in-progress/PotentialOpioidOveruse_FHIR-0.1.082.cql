library PotentialOpioidOveruse_FHIR version '0.1.082'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0'
include MATGlobalCommonFunctions_FHIR version '2.0.000' called Global
include OpioidConversion version '1.21.000' called OpioidConversionLogic
include DayMonthTimings version '0.9.000' called Timing

codesystem "SNOMEDCT:2018-03": 'urn:oid:2.16.840.1.113883.6.96' version 'urn:hl7:version:2018-03'
codesystem "SNOMEDCT": 'urn:oid:2.16.840.1.113883.6.96'

valueset "ONC Administrative Sex": 'urn:oid:2.16.840.1.113762.1.4.1'
valueset "Race": 'urn:oid:2.16.840.1.114222.4.11.836'
valueset "Ethnicity": 'urn:oid:2.16.840.1.114222.4.11.837'
valueset "Payer": 'urn:oid:2.16.840.1.114222.4.11.3591'
valueset "Office Visit": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1001'
valueset "Preventive Care Services - Established Office Visit, 18 and Up": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1025'
valueset "Preventive Care Services-Initial Office Visit, 18 and Up": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1023'
valueset "Preventive Care Services - Other": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1030'
valueset "Face to Face Interaction - No ED": 'urn:oid:2.16.840.1.113762.1.4.1080.2'
valueset "Palliative Care": 'urn:oid:2.16.840.1.113883.3.600.1.1579'
valueset "Hospice Care SNO": 'urn:oid:2.16.840.1.113883.3.3157.1004.20'
valueset "All Cancer": 'urn:oid:2.16.840.1.113883.3.464.1003.108.12.1011'
valueset "Sickle Cell Disease SNOMEDCT": 'urn:oid:2.16.840.1.113762.1.4.1029.33'
valueset "Outpatient Consultation": 'urn:oid:2.16.840.1.113883.3.464.1003.101.12.1008'
valueset "Opioid Medications": 'urn:oid:2.16.840.1.113883.3.3157.1004.26'

code "Every eight hours (qualifier value)": '307469008' from "SNOMEDCT:2018-03" display 'Every eight hours (qualifier value)'
code "Every eight to twelve hours (qualifier value)": '396140003' from "SNOMEDCT" display 'Every eight to twelve hours (qualifier value)'
code "Every forty eight hours (qualifier value)": '396131002' from "SNOMEDCT:2018-03" display 'Every forty eight hours (qualifier value)'
code "Every four hours (qualifier value)": '225756002' from "SNOMEDCT" display 'Every four hours (qualifier value)'
code "Every seventy two hours (qualifier value)": '396143001' from "SNOMEDCT:2018-03" display 'Every seventy two hours (qualifier value)'
code "Every six hours (qualifier value)": '307468000' from "SNOMEDCT:2018-03" display 'Every six hours (qualifier value)'
code "Every six to eight hours (qualifier value)": '396139000' from "SNOMEDCT" display 'Every six to eight hours (qualifier value)'
code "Every thirty six hours (qualifier value)": '396126004' from "SNOMEDCT:2018-03" display 'Every thirty six hours (qualifier value)'
code "Every three to four hours (qualifier value)": '225754004' from "SNOMEDCT" display 'Every three to four hours (qualifier value)'
code "Every three to six hours (qualifier value)": '396127008' from "SNOMEDCT" display 'Every three to six hours (qualifier value)'
code "Every twelve hours (qualifier value)": '307470009' from "SNOMEDCT:2018-03" display 'Every twelve hours (qualifier value)'
code "Every twenty four hours (qualifier value)": '396125000' from "SNOMEDCT:2018-03" display 'Every twenty four hours (qualifier value)'
code "Every two to four hours (qualifier value)": '225752000' from "SNOMEDCT" display 'Every two to four hours (qualifier value)'
code "Four times daily (qualifier value)": '307439001' from "SNOMEDCT:2018-03" display 'Four times daily (qualifier value)'
code "Once daily (qualifier value)": '229797004' from "SNOMEDCT:2018-03" display 'Once daily (qualifier value)'
code "One to four times a day (qualifier value)": '396109005' from "SNOMEDCT" display 'One to four times a day (qualifier value)'
code "One to three times a day (qualifier value)": '396108002' from "SNOMEDCT" display 'One to three times a day (qualifier value)'
code "One to two times a day (qualifier value)": '396107007' from "SNOMEDCT" display 'One to two times a day (qualifier value)'
code "Three times daily (qualifier value)": '229798009' from "SNOMEDCT:2018-03" display 'Three times daily (qualifier value)'
code "Twice a day (qualifier value)": '229799001' from "SNOMEDCT:2018-03" display 'Twice a day (qualifier value)'
code "Two to four times a day (qualifier value)": '396111001' from "SNOMEDCT" display 'Two to four times a day (qualifier value)'

parameter "Measurement Period" Interval<DateTime>

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
	/*Includes all patients in the initial population*/
	"Initial Population"

define "Gaps in Active Opioid Period Greater Than 7 Days":
	/*Assesses for gaps of more than 7 days between opioid medications*/
	"Gaps in Active Opioid Period" Gap
		where duration in days of Gap > 7

define "Active Periods with MMEs 90 or More for 90 or More Days":
	/*Periods with MME’s that are 90 milligrams or more for 90 days or more*/
	"Active Periods with MME Sum Days" Period
		where Count(Period.mmeSumDays MMESum
				where MMESum.totalMME.value >= 90
		)>= 90

define "Opioid Medication Order during Measurement Period":
	/*An active opioid medication order during or overlapping the start of the measurement period*/
	["MedicationRequest": medication in "Opioid Medications"] OpioidMedicationOrder
		where OpioidMedicationOrder.intent = 'order'
		  and Interval[start of FHIRHelpers.ToInterval(OpioidMedicationOrder.dispenseRequest.validityPeriod),
			 	start of FHIRHelpers.ToInterval(OpioidMedicationOrder.dispenseRequest.validityPeriod) + FHIRHelpers.ToQuantity(OpioidMedicationOrder.dispenseRequest.expectedSupplyDuration)] 
				overlaps "Measurement Period"

define "Opioid Medication Periods":
	/*All intervals of opioid medications, associated with the measurement period, and returns a unique set of intervals that covers all time periods for all opioid prescriptions*/
	collapse ( "Opioid Medication Periods in Measurement Period" OpioidPeriod
			return OpioidPeriod.periodInMP
	)

define "Opioid Medication Periods in Measurement Period":
	/*Creates a list that has the medication and the period of the medication in the measurement period*/
	"Opioid Medication Order during Measurement Period" Opioid
		return {
			periodInMP: Interval[start of FHIRHelpers.ToInterval(Opioid.dispenseRequest.validityPeriod), 
					start of FHIRHelpers.ToInterval(Opioid.dispenseRequest.validityPeriod) + FHIRHelpers.ToQuantity(Opioid.dispenseRequest.expectedSupplyDuration)]
				intersect "Measurement Period",
			med: Opioid
		}

define "Overall Active Opioid Period":
	/*The overall period of an active opioid medications from the start of first opioid medication to end of last opioid medication during the measurement period*/
	Interval[start of First("Opioid Medication Periods in Measurement Period" OpioidPeriod
			sort by start of periodInMP
	).periodInMP, 
	end of Last("Opioid Medication Periods in Measurement Period" OpioidPeriod
			sort by 
			end of periodInMP
	).periodInMP]

define "Numerator":
	/*Patients with opioid prescription orders of 90 or more MME*/
	exists "Active Periods with MMEs 90 or More for 90 or More Days"

define "Active Periods with MME Sum Days":
	/*Calculates individual MME for each day in every prescription, and a total daily MME across prescriptions, accounting for overlap*/
	"Active Periods with and without Gaps and Cumulative Medication Duration of 90 or More Days" Period
		let ScriptsMMEDays: "CalculateDailyMMEPerMedication"(Period.meds, Period.period)
		return {
			period: Period.period,
			meds: Period.meds,
			cmd: Period.cmd,
			mmeDays: ScriptsMMEDays,
			mmeSumDays: "CalculatesTotalMMESumDays"(ScriptsMMEDays)
		}

define "Gaps in Active Opioid Period":
	/*Creates a list of the opioid medications and its start and end dates within the measurement period*/
	"Opioid Medication Periods" Period
		let NextIndex: IndexOf("Opioid Medication Periods", Period)+ 1
		where NextIndex < Length("Opioid Medication Periods")
		return Interval ( 
		end of Period, start of "Opioid Medication Periods"[NextIndex])

define "Encounters during Measurement Period":
	/*Determines if qualifying encounters were performed during the Measurement Period*/
	( ["Encounter": "Face to Face Interaction - No ED"]
		union ["Encounter": "Office Visit"]
		union ["Encounter": "Preventive Care Services - Established Office Visit, 18 and Up"]
		union ["Encounter": "Preventive Care Services-Initial Office Visit, 18 and Up"]
		union ["Encounter": "Outpatient Consultation"]
		union ["Encounter": "Preventive Care Services - Other"] ) Encounter
		where Encounter.status in { 'in-progress', 'finished' }
		  and Encounter.period during "Measurement Period"

define "Active Periods with Allowed Gaps":
	/*Creates a list of periods with gaps that are 7 days or less*/
	if Length("Gaps in Active Opioid Period Greater Than 7 Days")< 1
	/*If there are no gaps, use the overall period 
	                                                                     */ then { "Overall Active Opioid Period" } 
		else 
	/*First interval from start of overall period to first gap
	                                                                       */ { Interval[start of "Overall Active Opioid Period", start of "Gaps in Active Opioid Period Greater Than 7 Days"[0]) }
		union 
	/*Rest of intervals. For each: start at end of current gap, end at end of next gap or end of overall period
	*/ "Gaps in Active Opioid Period Greater Than 7 Days" Gap
			let NextGapIndex: IndexOf("Gaps in Active Opioid Period Greater Than 7 Days", Gap)+ 1
			return if NextGapIndex < Length("Gaps in Active Opioid Period Greater Than 7 Days")then Interval ( 
			end of Gap, start of "Gaps in Active Opioid Period Greater Than 7 Days"[NextGapIndex]) 
				else Interval ( 
			end of Gap, 
			end of "Overall Active Opioid Period"]

define "Active Periods with Allowed Gaps with Meds and Durations":
	/*Provides a list of each period with allowed gaps with the opioid medications that are within the same 90 or more day period*/
	"Active Periods with Allowed Gaps" Period
		let Meds: ( "Opioid Medication Periods in Measurement Period" Opioid
				where Opioid.periodInMP during Period
		)
		return {
			period: Period,
			meds: Meds Med
				return Med.med,
			cmd: "CumulativeDuration"(Meds Med
					return Med.periodInMP
			)
		}

define "Active Periods with and without Gaps and Cumulative Medication Duration of 90 or More Days":
	/*Creates a list of periods where Cumulative Medication Duration greater than or equal to 90 days. The logic filters the result of “Periods with Allowed Gaps with Meds and Durations” result to only include the periods with a CMD greater or equal to 90. If there are any periods after the filter, and the patient has an encounter during the MP then they are in the Initial Population*/
	"Active Periods with Allowed Gaps with Meds and Durations" Period
		where Period.cmd >= 90

define "Initial Population":
	/*Patients age 18 and older who have an encounter during the measurement period, are prescribed opioids for 90 days or more and have 7 days or less between opioid prescriptions*/
	Global.CalendarAgeInYearsAt(ToDateTime(Patient.birthDate), start of "Measurement Period")>= 18
		and exists ( "Encounters during Measurement Period" )
		and exists ( "Active Periods with and without Gaps and Cumulative Medication Duration of 90 or More Days" )

define "Denominator Exclusion":
	/*Measure excludes patients receiving palliative or hospice treatment during the measurement period. Or patients who have a diagnosis of cancer (could occur up to 1 yr prior) or sickle cell disease during the measurement period*/
	exists ( "Encounters during Measurement Period" QualifyingEncounter
			with ["ProcedureRequest": "Palliative Care"] PalliativeCareOrder
				such that PalliativeCareOrder.intent = 'order'
				  and PalliativeCareOrder.authoredOn during QualifyingEncounter.period
	)
		or exists ( "Encounters during Measurement Period" QualifyingEncounter
				with ["Procedure": "Palliative Care"] PalliativeCareIntervention
					such that PalliativeCareIntervention.performed overlaps QualifyingEncounter.period
		)
		or exists ( "Encounters during Measurement Period" QualifyingEncounter
				with ( ["ProcedureRequest": "Hospice Care SNO"]
					union ["Procedure": "Hospice Care SNO"]
					union ["ProcedureRequest": "Hospice Care SNO"] ) Hospice
					such that Hospice.authoredOn during "Measurement Period"
					  or Hospice.performed during "Measurement Period" // TODO: Note the mapping for Procedure here was actually to Provenance...
		)
		or exists ( "Encounters during Measurement Period" QualifyingEncounter
				with ["Condition": "All Cancer"] Cancer
					such that Cancer.clinicalStatus = 'active'
					  and Cancer.verificationStatus = 'confirmed'
						and Min({ Cancer.assertedDate, Cancer.onset}) in Interval[start of "Measurement Period" - 1 year, end of "Measurement Period"]
		)
		or exists ( "Encounters during Measurement Period" QualifyingEncounter
				with ["Condition": "Sickle Cell Disease SNOMEDCT"] SickleCell
					such that SickleCell.clinicalStatus = 'actcive'
					  and SickleCell.verificationStatus = 'confirmed'
						and Interval[SickleCell.onset, SickleCell.abatement] overlaps "Measurement Period"
		)

define function "DosesPerDay"(frequency Code):
	/*Calculates the cumulative dose per day for each prescription*/
	case
		when frequency ~ "Once daily (qualifier value)" then 1.0
		when frequency ~ "Twice a day (qualifier value)" then 2.0
		when frequency ~ "Three times daily (qualifier value)" then 3.0
		when frequency ~ "Four times daily (qualifier value)" then 4.0
		when frequency ~ "Every twenty four hours (qualifier value)" then 1.0
		when frequency ~ "Every twelve hours (qualifier value)" then 2.0
		when frequency ~ "Every thirty six hours (qualifier value)" then 0.67
		when frequency ~ "Every eight hours (qualifier value)" then 3.0
		when frequency ~ "Every four hours (qualifier value)" then 6.0
		when frequency ~ "Every six hours (qualifier value)" then 4.0
		when frequency ~ "Every seventy two hours (qualifier value)" then 0.34
		when frequency ~ "Every forty eight hours (qualifier value)" then 0.5
		when frequency ~ "Every eight to twelve hours (qualifier value)" then 2.0
		when frequency ~ "Every six to eight hours (qualifier value)" then 3.0
		when frequency ~ "Every three to four hours (qualifier value)" then 6.0
		when frequency ~ "Every three to six hours (qualifier value)" then 4.0
		when frequency ~ "Every two to four hours (qualifier value)" then 6.0
		when frequency ~ "One to four times a day (qualifier value)" then 4.0
		when frequency ~ "One to three times a day (qualifier value)" then 3.0
		when frequency ~ "One to two times a day (qualifier value)" then 2.0
		when frequency ~ "Two to four times a day (qualifier value)" then 4.0 
		else null 
	end
	
define function DosesPerDay(frequency Integer, period System.Quantity):
  case period.unit
    when 'h' then frequency * (24.0 / period.value)
    when 'min' then frequency * (24.0 / period.value) * 60
    when 's' then frequency * (24.0 / period.value) * 60 * 60
    when 'd' then frequency * (24.0 / period.value) / 24
    when 'wk' then frequency * (24.0 / period.value) / (24 * 7)
    when 'mo' then frequency * (24.0 / period.value) / (24 * 30) // assuming 30 days in month
    when 'a' then frequency * (24.0 / period.value) / (24 * 365) // assuming 365 days in year
    else null
  end

define function "CumulativeDuration"(Periods List<Interval<DateTime>>):
	/*Adds the total number of days of opioid prescription(s)*/
	Sum((collapse(Periods))Period
			return all duration in days of Period
	)

define function "CalculatesTotalMMESumDays"(scriptsMMEDays List<Tuple {
	rxNormCode Code,
	authortime DateTime,
	effectivePeriod Interval<DateTime>,
	conversionFactor Decimal,
	daysInPeriod List<DateTime>,
	mme System.Quantity
}>):
	/*Calculates the total MME for each day across multiple opioid prescriptions*/
	( distinct(flatten(scriptsMMEDays MMEDays
				return all MMEDays.daysInPeriod
		)
	)) Day
		let totalMME: Sum(scriptsMMEDays ScriptMMEDays
				where Day in ScriptMMEDays.daysInPeriod
				return all ScriptMMEDays.mme
		)
		return {
			Day: Day,
			totalMME: totalMME
		}

define function "CalculateDailyMMEPerMedication"(medications List<"MedicationRequest">, period Interval<DateTime>):
	/*Calculates the daily MME by multiplying the single administration dosage by the frequency (number of times the dose is administered per day)*/
	medications OpioidMed
		let 
		  dosageInstruction: OpioidMed.dosageInstruction[0],
			repeat: dosageInstruction.timing.repeat,
			frequency: Coalesce(repeat.frequencyMax.value, repeat.frequency.value),
			frequencyPeriod: System.Quantity { value: repeat.period.value, unit: repeat.periodUnit.value },
		  dosesPerDay: "DosesPerDay"(frequency, frequencyPeriod),
		MME: singleton from ( OpioidConversionLogic."CalculateMorphineMilligramEquivalents"({ {
					rxNormCode: FHIRHelpers.ToCode((OpioidMed.medication as FHIR.CodeableConcept).coding[0]),
					doseQuantity: if dosageInstruction.dose is FHIR.Range
					  then FHIRHelpers.ToQuantity(dosageInstruction.dose.high)
						else FHIRHelpers.ToQuantity(dosageInstruction.dose),
					dosesPerDay: dosesPerDay
				} }
			)
		),
		medPeriod: Interval[start of FHIRHelpers.ToInterval(OpioidMed.dispenseRequest.validityPeriod), 
				start of FHIRHelpers.ToInterval(OpioidMed.dispenseRequest.validityPeriod) + FHIRHelpers.ToQuantity(OpioidMed.dispenseRequest.expectedSupplyDuration)]
			intersect period
		return {
			rxNormCode: FHIRHelpers.ToCode((OpioidMed.medication as FHIR.CodeableConcept).coding[0]),
			authortime: FHIRHelpers.ToDateTime(OpioidMed.authoredOn),
			effectivePeriod: medPeriod,
			conversionFactor: MME.conversionFactor,
			daysInPeriod: Timing."DaysInPeriod"(medPeriod),
			mme: MME.MME
		}
