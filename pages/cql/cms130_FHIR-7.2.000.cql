library ColorectalCancerScreening version '7.2.000'

// changed to use STU3 FHIR model
using FHIR version '3.0.0'

include AdultOutpatientEncountersFHIR version '1.1.000' called AdultOutpatientEncounters
include MATGlobalCommonFunctionsFHIR version '2.0.000' called Global
include HospiceFHIR version '1.0.000' called Hospice
include FHIRHelpers version '3.0.0' called FHIRHelpers

valueset "ONC Administrative Sex": 'urn:oid:2.16.840.1.113762.1.4.1'
valueset "Race": 'urn:oid:2.16.840.1.114222.4.11.836'
valueset "Ethnicity": 'urn:oid:2.16.840.1.114222.4.11.837'
valueset "Payer": 'urn:oid:2.16.840.1.114222.4.11.3591'
valueset "Colonoscopy": 'urn:oid:2.16.840.1.113883.3.464.1003.108.12.1020'
valueset "Fecal Occult Blood Test (FOBT)": 'urn:oid:2.16.840.1.113883.3.464.1003.198.12.1011'
valueset "Flexible Sigmoidoscopy": 'urn:oid:2.16.840.1.113883.3.464.1003.198.12.1010'
valueset "Malignant Neoplasm of Colon": 'urn:oid:2.16.840.1.113883.3.464.1003.108.12.1001'
valueset "Total Colectomy": 'urn:oid:2.16.840.1.113883.3.464.1003.198.12.1019'
valueset "FIT DNA": 'urn:oid:2.16.840.1.113883.3.464.1003.108.12.1039'
valueset "CT Colonography": 'urn:oid:2.16.840.1.113883.3.464.1003.108.12.1038'

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
	[Patient] P where P.gender in {'male', 'female'}
	  return P.gender

define "Denominator":
	"Initial Population"

define "Flexible Sigmoidoscopy Performed":
	[Procedure: "Flexible Sigmoidoscopy"] FlexibleSigmoidoscopy
		where FlexibleSigmoidoscopy.status = 'completed'
			and FlexibleSigmoidoscopy.performed ends 5 years or less on or before end of "Measurement Period"

define "CT Colonography Performed":
	[Procedure: "CT Colonography"] Colonography
		where Colonography.status = 'completed'
			and Colonography.performed ends 5 years or less on or before end of "Measurement Period"

define "Total Colectomy Performed":
	[Procedure: "Total Colectomy"] Colectomy
		where Colectomy.status = 'completed'
			and Colectomy.performed starts on or before end of "Measurement Period"

define "Malignant Neoplasm":
	[Condition: "Malignant Neoplasm of Colon"] ColorectalCancer
		where ColorectalCancer.clinicalStatus = 'active'
			and ColorectalCancer.onset starts on or before end of "Measurement Period"

define "Fecal Occult Blood Test Performed":
	[Observation: "Fecal Occult Blood Test (FOBT)"] FecalOccultResult
		where FecalOccultResult.status in {'final', 'amended', 'corrected', ’preliminary’}
			and FecalOccultResult.value is not null
			and FecalOccultResult.performed during day of "Measurement Period"
			// and FecalOccultResult.FHIR.provenance.recorded during "Measurement Period"

define "Fecal Immunochemical Test DNA":
	[Observation: "FIT DNA"] FitDNA
		where FitDNA.status in {'final', 'amended', 'corrected'}
			and FitDNA.value is not null
			and FitDNA.effective occurs 3 years or less on or before day of end of "Measurement Period
			// and FitDNA.FHIR.provenance.recorded occurs 3 years or less on or before end of "Measurement Period"

define "Colonoscopy Performed":
	[Procedure: "Colonoscopy"] Colonoscopy
		where Colonoscopy.status = 'completed'
		 	and Colonoscopy.performed ends 10 years or less on or before end of "Measurement Period"

define "Numerator":
	exists "Colonoscopy Performed"
		or exists "Fecal Occult Blood Test Performed"
		or exists "Flexible Sigmoidoscopy Performed"
		or exists "Fecal Immunochemical Test DNA"
		or exists "CT Colonography Performed"

define "Denominator Exclusions":
	Hospice."Has Hospice"("Measurement Period")
		or exists "Malignant Neoplasm"
		or exists "Total Colectomy Performed"

define "Initial Population":
	Global."CalendarAgeInYearsAt"(FHIRHelpers.ToDate(Patient.birthDate), start of "Measurement Period") in Interval[50, 75]
			and exists AdultOutpatientEncounters."Qualifying Encounters"("Measurement Period")
