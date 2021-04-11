library MultiRateExample

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'

valueset "Bed Device Types": 'http://example.org/fhir/ValueSet/TBD'
valueset "Screening Procedure Types": 'http://example.org/fhir/ValueSet/TBD'

context Location

// Number of patients
define "Patients":
  [Patient]

// Number of practitioners
define "Practitioners":
  [PractitionerRole]

// Number of beds
define "Beds":
  [Device: "Bed Device Types"]

// Number of screening procedures
define "Screening Procedures":
  [Procedure: "Screening Procedure Types"]

// Percentage of patients who received screening
define "Initial Population":
  "Patients"

define "Denominator":
  "Patients" P
    where P.gender = 'female'

define "Numerator":
  "Patients" P
    with "Screening Procedures" SP
      such that P.id = Last(Split(SP.subject.reference, '/'))

define function ToNumber(patient Patient):
  if patient is not null then 1 else 0

define function ToNumber(practitionerRole PractitionerRole):
  if practitionerRole is not null then 1 else 0

define function ToNumber(device Device):
  if device is not null then 1 else 0
