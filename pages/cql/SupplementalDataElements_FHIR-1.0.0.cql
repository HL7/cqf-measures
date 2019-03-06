library SupplementalDataElements_FHIR version '1.0.0'

using FHIR version '3.0.0'

include FHIRHelpers version '3.0.0' called FHIRHelpers

valueset "ONC Administrative Sex": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1'
valueset "Race": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.836'
valueset "Ethnicity": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.837'
valueset "Payer": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.3591'

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

