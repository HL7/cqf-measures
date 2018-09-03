library ColorectalCancerScreening version '7.2.000'

// changed to use STU3 FHIR model
using FHIR version '3.0.0'

include Adult_Outpatient_Encounters version '1.1.000' called AdultOutpatientEncounters
include MATGlobalCommonFunctions version '2.0.000' called Global
include Hospice version '1.0.000' called Hospice
// added FHIRHelpers conversion Library
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

// added FlexibleSigmoidoscopy.status = 'completed'
define "Flexible Sigmoidoscopy Performed":
	[Procedure: "Flexible Sigmoidoscopy"] FlexibleSigmoidoscopy
		where FlexibleSigmoidoscopy.status = 'completed'
			and FlexibleSigmoidoscopy.performed ends 5 years or less on or before end of "Measurement Period"

// added Colonography.status = 'completed'
define "CT Colonography Performed":
	[Procedure: "CT Colonography"] Colonography
		where Colonography.status = 'completed'
			and Colonography.performed ends 5 years or less on or before end of "Measurement Period"

// added Colectomy.status = 'completed'
define "Total Colectomy Performed":
	[Procedure: "Total Colectomy"] Colectomy
		where Colectomy.status = 'completed'
			and Colectomy.performed starts on or before end of "Measurement Period"

// added ColorectalCancer.clinicalStatus = 'active'
define "Malignant Neoplasm":
	[Condition: "Malignant Neoplasm of Colon"] ColorectalCancer
		where ColorectalCancer.clinicalStatus = 'active'
			and ColorectalCancer.onset starts on or before end of "Measurement Period"

// added FecalOccultResult.status in {'final', 'amended', 'corrected'}
// commented out the provenance.recorded statement - let's ignore provenance for now...
define "Fecal Occult Blood Test Performed":
	[Observation: "Fecal Occult Blood Test (FOBT)"] FecalOccultResult
		where FecalOccultResult.status in {'final', 'amended', 'corrected'}
			and FecalOccultResult.value is not null
			// and FecalOccultResult.FHIR.provenance.recorded during "Measurement Period"

// added FitDNA.status in {'final', 'amended', 'corrected'}
// commented out the provenance.recorded statement - let's ignore provenance for now...
define "Fecal Immunochemical Test DNA":
	[Observation: "FIT DNA"] FitDNA
		where FitDNA.status in {'final', 'amended', 'corrected'}
			and FitDNA.value is not null
			// and FitDNA.FHIR.provenance.recorded occurs 3 years or less on or before end of "Measurement Period"

// added Colonoscopy.status = 'active'
define "Colonoscopy Performed":
	[Procedure: "Colonoscopy"] Colonoscopy
		where Colonoscopy.status = 'active'
		 	and Colonoscopy.performed ends 10 years or less on or before end of "Measurement Period"

define "Numerator":
	exists "Colonoscopy Performed"
		or exists "Fecal Occult Blood Test Performed"
		or exists "Flexible Sigmoidoscopy Performed"
		or exists "Fecal Immunochemical Test DNA"
		or exists "CT Colonography Performed"

define "Denominator Exclusions":
	Hospice."Has Hospice"
		or exists "Malignant Neoplasm"
		or exists "Total Colectomy Performed"

// see http://www.hl7.org/fhir/us/qicore/IndividualCharacteristic.html for Patient Characteristic mappings
define "Initial Population":
	exists [Patient.birthDate] BirthDate
		where Global."CalendarAgeInYearsAt"(BirthDate.birthDatetime, start of "Measurement Period") in Interval[50, 75)
			and exists AdultOutpatientEncounters."Qualifying Encounters"
