library EXM146_FHIR version '4.0.0'

/*
This example is a work in progress and should not be considered a final specification
or recommendation for guidance. This example will help guide and direct the process
of finding conventions and usage patterns that meet the needs of the various stakeholders
in the measure development community.
*/

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include Common_FHIR version '2.0.0' called Common

valueset "Acute Pharyngitis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.102.12.1011'
valueset "Acute Tonsillitis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.102.12.1012'
valueset "Ambulatory/ED Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1061'
valueset "Antibiotic Medications": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.196.12.1001'
valueset "Group A Streptococcus Test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.198.12.1012'

parameter "Measurement Period" Interval<DateTime>

context Patient

// Region: Initial Population

define "Is Between 2 and 17 Years of Age at Start of Measurement Period":
   AgeInYearsAt(start of "Measurement Period") >= 2
      and AgeInYearsAt(start of "Measurement Period") <= 17

define "Antibiotics":
   [MedicationRequest: medication in "Antibiotic Medications"] Prescription
     where Prescription.status = 'active'
       and Prescription.intent = 'order'

define "Pharyngitis":
   ([Condition: code in "Acute Pharyngitis"]
     union [Condition: code in "Acute Tonsillitis"]) Pharyngitis
     where 
       exists
       (
         Pharyngitis.clinicalStatus.coding ClinicalStatusCoding
           where ClinicalStatusCoding.code ~ 'active'
       )
       and exists
       (
         Pharyngitis.verificationStatus.coding VerificationStatusCoding
           where VerificationStatusCoding.code ~ 'confirmed'
       )

define "Measurement Period Encounters":
   [Encounter: "Ambulatory/ED Visit"] Encounter
      where Encounter.period during "Measurement Period"
        and Encounter.status = 'finished'
        and "Is Between 2 and 17 Years of Age at Start of Measurement Period"

define "Pharyngitis Encounters With Antibiotics":
   "Measurement Period Encounters" Encounters
      with "Pharyngitis" Pharyngitis such that
         Common."Includes Or Starts During"(Pharyngitis, Encounters)
      with "Antibiotics" Antibiotics such that Antibiotics.authoredOn
         3 days or less after FHIRHelpers.ToInterval(Encounters.period)

define "Initial Population":
   "Pharyngitis Encounters With Antibiotics"

// EndRegion: Initial Population

// Region: Denominator

// None

// EndRegion: Denominator

// Region: Denominator Exclusions

define "Pharyngitis With Prior Antibiotics":
   "Pharyngitis" Pharyngitis
      with "Antibiotics" Antibiotics such that
         Antibiotics.authoredOn 30 days or less before Pharyngitis.onset

define "Excluded Encounters":
   "Pharyngitis Encounters With Antibiotics" Encounters
      with "Pharyngitis With Prior Antibiotics" Pharyngitis such that
         Common."Includes Or Starts During"(Pharyngitis, Encounters)

define "Denominator Exclusions":
  "Excluded Encounters"

// EndRegion: Denominator Exclusions

// Region: Denominator Exceptions

// None

// EndRegion: Denominator Exceptions

// Region: Numerator

define "Strep Test Encounters":
   "Pharyngitis Encounters With Antibiotics" Encounters
      with [Observation: code in "Group A Streptococcus Test"] Tests
         such that Tests.value is not null
            and Tests.effective starts during
               Interval[start of FHIRHelpers.ToInterval(Encounters.period) - 3 days,
                 end of FHIRHelpers.ToInterval(Encounters.period) + 3 days]

define "Numerator":
   "Strep Test Encounters"

// EndRegion: Numerator

// Region: Numerator Exclusion

// None

// EndRegion: Numerator Exclusion
