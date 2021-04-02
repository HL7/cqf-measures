library BreastCancerScreening version '7.2.000'

using QDM version '5.3'

include MATGlobalCommonFunctions_QDM version '2.0.000' called Global
include AdultOutpatientEncounters_QDM version '1.1.000' called AdultOutpatientEncounters
include Hospice_QDM version '1.0.000' called Hospice

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

/* define "SDE Ethnicity":
	["Patient Characteristic Ethnicity": "Ethnicity"]

define "SDE Payer":
	["Patient Characteristic Payer": "Payer"]

define "SDE Race":
	["Patient Characteristic Race": "Race"]

define "SDE Sex":
	["Patient Characteristic Sex": "ONC Administrative Sex"] */

define "Denominator":
	true

/* define "Unilateral Mastectomy Procedure":
	["Procedure, Performed": "Unilateral Mastectomy"] UnilateralMastectomyProcedure
		where UnilateralMastectomyProcedure.relevantPeriod ends before end of "Measurement Period" */

define "Unilateral Mastectomy Procedure":
	["Procedure, Performed": "Unilateral Mastectomy"] UnilateralMastectomyProcedure
		where UnilateralMastectomyProcedure.relevantPeriod ends before day of end of "Measurement Period"

/* define "Right Mastectomy":
	( ["Diagnosis": "Status Post Right Mastectomy"]
		union ( ["Diagnosis": "Unilateral Mastectomy, Unspecified Laterality"] UnilateralMastectomyDiagnosis
				where UnilateralMastectomyDiagnosis.anatomicalLocationSite in "Right"
		) ) RightMastectomy
		where RightMastectomy.prevalencePeriod starts before end of "Measurement Period" */

define "Right Mastectomy":
	( ["Diagnosis": "Status Post Right Mastectomy"]
		union ( ["Diagnosis": "Unilateral Mastectomy, Unspecified Laterality"] UnilateralMastectomyDiagnosis
				where UnilateralMastectomyDiagnosis.anatomicalLocationSite in "Right"
		) ) RightMastectomy
		where RightMastectomy.prevalencePeriod starts before day of end of "Measurement Period"

/* define "Left Mastectomy":
	( ["Diagnosis": "Status Post Left Mastectomy"]
		union ( ["Diagnosis": "Unilateral Mastectomy, Unspecified Laterality"] UnilateralMastectomyDiagnosis
				where UnilateralMastectomyDiagnosis.anatomicalLocationSite in "Left"
		) ) LeftMastectomy
		where LeftMastectomy.prevalencePeriod starts before end of "Measurement Period" */

define "Left Mastectomy":
	( ["Diagnosis": "Status Post Left Mastectomy"]
		union ( ["Diagnosis": "Unilateral Mastectomy, Unspecified Laterality"] UnilateralMastectomyDiagnosis
				where UnilateralMastectomyDiagnosis.anatomicalLocationSite in "Left"
		) ) LeftMastectomy
		where LeftMastectomy.prevalencePeriod starts before day of end of "Measurement Period"

/* define "History Bilateral Mastectomy":
	["Diagnosis": "History of bilateral mastectomy"] BilateralMastectomyHistory
		where BilateralMastectomyHistory.prevalencePeriod starts before end of "Measurement Period" */

define "History Bilateral Mastectomy":
	["Diagnosis": "History of bilateral mastectomy"] BilateralMastectomyHistory
		where BilateralMastectomyHistory.prevalencePeriod starts before day of end of "Measurement Period"

/* define "Bilateral Mastectomy Procedure":
	["Procedure, Performed": "Bilateral Mastectomy"] BilateralMastectomyPerformed
		where BilateralMastectomyPerformed.relevantPeriod ends before end of "Measurement Period" */

define "Bilateral Mastectomy Procedure":
	["Procedure, Performed": "Bilateral Mastectomy"] BilateralMastectomyPerformed
		where BilateralMastectomyPerformed.relevantPeriod ends before day of end of "Measurement Period"

define "Numerator":
	exists ( ["Diagnostic Study, Performed": "Mammography"] Mammogram
			where ( Mammogram.relevantPeriod ends 27 months or less before day of end "Measurement Period" )
	)

define "Denominator Exclusions":
	Hospice."Has Hospice"
		or ( Count("Unilateral Mastectomy Procedure") = 2 )
		or ( exists "Right Mastectomy"
				and exists "Left Mastectomy"
		)
		or exists "History Bilateral Mastectomy"
		or exists "Bilateral Mastectomy Procedure"

define "Initial Population":
	exists ( ["Patient Characteristic Sex": "Female"] )
		and exists ["Patient Characteristic Birthdate"] BirthDate
			where Global."CalendarAgeInYearsAt"(BirthDate.birthDatetime, start of "Measurement Period") in Interval[51, 74]
				and exists AdultOutpatientEncounters."Qualifying Encounters"
