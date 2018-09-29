library BreastCancerScreening version '7.2.000'

using FHIR version '3.0.0'

include MATGlobalCommonFunctionsFHIR version '2.0.000' called Global
include AdultOutpatientEncountersFHIR version '1.1.000' called AdultOutpatientEncounters
include HospiceFHIR version '1.0.000' called Hospice
include FHIRHelpers version '3.0.0' called FHIRHelpers

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

define "Denominator":
		"Initial Population"

define "Unilateral Mastectomy Procedure":
		[Procedure: "Unilateral Mastectomy"] UnilateralMastectomyProcedure
				where UnilateralMastectomyProcedure.performed ends before day of end of "Measurement Period"
						and UnilateralMastectomyProcedure.status = 'completed'

define "Right Mastectomy":
		(
				( [Condition: "Status Post Right Mastectomy"] C where C.clinicalStatus = 'active' )
				union (
						[Condition: "Unilateral Mastectomy, Unspecified Laterality"] UnilateralMastectomyDiagnosis
								where UnilateralMastectomyDiagnosis.bodySite in "Right"
										and UnilateralMastectomyDiagnosis.clinicalStatus = 'active'
				)
		) RightMastectomy
				where Global."Normalize Onset"(RightMastectomy.onset) starts before day of end of "Measurement Period"

define "Left Mastectomy":
		(
		    ( [Condition: "Status Post Left Mastectomy"] C where C.clinicalStatus = 'active' )
				union (
						[Condition: "Unilateral Mastectomy, Unspecified Laterality"] UnilateralMastectomyDiagnosis
								where UnilateralMastectomyDiagnosis.bodySite in "Left"
										and UnilateralMastectomyDiagnosis.clinicalStatus = 'active'
				)
		) LeftMastectomy
				where Global."Normalize Onset"(LeftMastectomy.onset) starts before day of end of "Measurement Period"

define "History Bilateral Mastectomy":
		[Condition: "History of bilateral mastectomy"] BilateralMastectomyHistory
				where Global."Normalize Onset"(BilateralMastectomyHistory.onset) starts before day of end of "Measurement Period"
						and BilateralMastectomyHistory.clinicalStatus = 'active'

define "Bilateral Mastectomy Procedure":
		[Procedure: "Bilateral Mastectomy"] BilateralMastectomyPerformed
				where BilateralMastectomyPerformed.performed ends before day of end of "Measurement Period"
						and BilateralMastectomyPerformed.status = 'completed'

define "Numerator":
		exists (
				[DiagnosticReport: "Mammography"] Mammogram
						where ( Mammogram.effective ends 27 months or less before day of end of "Measurement Period" )
								and Mammogram.status in { 'final', 'amended', 'corrected', 'appended' }
		)

define "Denominator Exclusion":
		Hospice."Has Hospice"("Measurement Period")
				or ( Count("Unilateral Mastectomy Procedure") = 2 )
				or ( exists "Right Mastectomy" and exists "Left Mastectomy" )
				or exists "History Bilateral Mastectomy"
				or exists "Bilateral Mastectomy Procedure"

define "Initial Population":
		Patient.gender = 'female'
				and Global."CalendarAgeInYearsAt"(FHIRHelpers.ToDate(Patient.birthDate), start of "Measurement Period") in Interval[51, 74]
				and exists AdultOutpatientEncounters."Qualifying Encounters"("Measurement Period")
