library BreastCancerScreening version '7.2.000'

using QDM version '5.3'

include MATGlobalCommonFunctions version '2.0.000' called Global
include Adult_Outpatient_Encounters version '1.1.000' called AdultOutpatientEncounters
include Hospice version '1.0.000' called Hospice

valueset "ONC Administrative Sex": 'urn:oid:2.16.840.1.113762.1.4.1'
valueset "Race": 'urn:oid:2.16.840.1.114222.4.11.836'
valueset "Ethnicity": 'urn:oid:2.16.840.1.114222.4.11.837'
valueset "Payer": 'urn:oid:2.16.840.1.114222.4.11.3591'
valueset "Bilateral Mastectomy": 'urn:oid:2.16.840.1.113883.3.464.1003.198.12.1005'
valueset "Female": 'urn:oid:2.16.840.1.113883.3.560.100.2'
valueset "Mammography": 'urn:oid:2.16.840.1.113883.3.464.1003.108.12.1018'
valueset "Unilateral Mastectomy": 'urn:oid:2.16.840.1.113883.3.464.1003.198.12.1020'
valueset "History of bilateral mastectomy": 'urn:oid:2.16.840.1.113883.3.464.1003.198.12.1068'
valueset "Status Post Left Mastectomy": 'urn:oid:2.16.840.1.113883.3.464.1003.198.12.1069'
valueset "Status Post Right Mastectomy": 'urn:oid:2.16.840.1.113883.3.464.1003.198.12.1070'
valueset "Left": 'urn:oid:2.16.840.1.113883.3.464.1003.122.12.1036'
valueset "Right": 'urn:oid:2.16.840.1.113883.3.464.1003.122.12.1035'
valueset "Unilateral Mastectomy, Unspecified Laterality": 'urn:oid:2.16.840.1.113883.3.464.1003.198.12.1071'

parameter "Measurement Period" Interval<DateTime>

context Patient

define "SDE Ethnicity":
	[Patient: extension.ombCategory in "Ethnicity"]

// DT: Not addressed in QI Core / FHIR
define "SDE Payer":
	["Patient Characteristic Payer": "Payer"]

define "SDE Race":
	[Patient: extension.ombCategory in "Race"] 

define "SDE Sex":
	[Patient] P where P.gender in {'female'} 
	  return P.gender

define "Denominator":
	"Initial Population"

define "Unilateral Mastectomy Procedure":
	[Procedure: "Unilateral Mastectomy"] UnilateralMastectomyProcedure
		where UnilateralMastectomyProcedure.performed ends before end of "Measurement Period"
			and UnilateralMastectomyProcedure..status = 'completed'

define "Right Mastectomy":
	( [Condition: "Status Post Right Mastectomy"]
		union ( [Condition: "Unilateral Mastectomy, Unspecified Laterality"] UnilateralMastectomyDiagnosis
				where UnilateralMastectomyDiagnosis.bodySite in "Right"
					and UnilateralMastectomyDiagnosis.clinicalStatus = 'active'
		) ) RightMastectomy
		where RightMastectomy.onset starts before end of "Measurement Period"

define "Left Mastectomy":
	( [Condition: "Status Post Left Mastectomy"]
		union ( [Condition: "Unilateral Mastectomy, Unspecified Laterality"] UnilateralMastectomyDiagnosis
				where UnilateralMastectomyDiagnosis.bodySite in "Left"
		) ) LeftMastectomy
		where LeftMastectomy.onset starts before end of "Measurement Period"

define "History Bilateral Mastectomy":
	[Condition: "History of bilateral mastectomy"] BilateralMastectomyHistory
		where BilateralMastectomyHistory.onset starts before end of "Measurement Period"

define "Bilateral Mastectomy Procedure":
	[Procedure: "Bilateral Mastectomy"] BilateralMastectomyPerformed
		where BilateralMastectomyPerformed.performed ends before end of "Measurement Period"

define "Numerator":
	exists ( [DiagnosticReport: "Mammography"] Mammogram
			where ( Mammogram.effective ends 27 months or less before day of end "Measurement Period" )
	)

define "Denominator Exclusions":
	Hospice."Has Hospice"
		or ( Count("Unilateral Mastectomy Procedure")= 2 )
		or ( exists "Right Mastectomy"
				and exists "Left Mastectomy"
		)
		or exists "History Bilateral Mastectomy"
		or exists "Bilateral Mastectomy Procedure"

define "Qualifying Encounters":
    [Encounter: "Office Visit"] visit
	  union [Encounter."Annual Wellness Visit"]
	  union [Encounter."Preventive Care Services - Established Office Visit, 18 and Up"]
	  union [Encounter."Preventive Care Services-Initial Office Visit, 18 and Up"]
	  union [Encounter."Home Healthcare Services"] ) ValidEncounter
	    where ValidEncounter.relevantPeriod during "Measurement Period"

define "Hospice.Has Hospice":
	exists (Encounter."Encounter Inpatient"] DischargeHospice
		where ( DischargeHospice.hospitalization.dischargeDisposition as Code ~ "Discharge to home for hospice care (procedure)"
				or DischargeHospice.hospitalization.dischargeDisposition as Code ~ "Discharge to healthcare facility for hospice care (procedure)"
		)
			and DischargeHospice.period ends during "Measurement Period"
)
	or exists ( task."Hospice care ambulatory"] HospiceOrder
			where HospiceOrder.AuthoredOn during "Measurement Period"
	)
	or exists ( task."Hospice care ambulatory"] HospicePerformed
			where HospicePerformed.period overlaps "Measurement Period"
	)

define "Initial Population":
	exists ( [Patient.gender] Sex )
		and exists [Patient.birthDate] BirthDate
			where Global."CalendarAgeInYearsAt"(BirthDate.birthDatetime, start of "Measurement Period")in Interval[51, 74 )
				and exists AdultOutpatientEncounters."Qualifying Encounters"
