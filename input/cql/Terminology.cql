/*
This example is purely for illustration purposes to show how all the elements of a
FHIR-based quality measure are represented. It is intentionally simplified to show
specific aspects of a measure, and is not intended as an example of a clinically
meaningful measure.
*/
library Terminology version '1.0.0'

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1' called FHIRHelpers
include CommonTerminologies version '1.0.000' called Common

// NOTE: Versioning is used in this example to illustrate completely how versioning is applied
// References to specific versions of code systems and value sets should be used only when necessary

valueset "Encounter Inpatient SNOMEDCT Value Set":
   'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.7.307|20160929'

code "Venous foot pump, device (physical object)": '442023007' from Common."SNOMED CT:2017-09"
code "Right foot": '7769000' from Common."SNOMED CT:2017-09"

parameter "Measurement Period" Interval<DateTime>

define "Inpatient Encounter":
  ["Encounter": type in "Encounter Inpatient SNOMEDCT Value Set"] E
    where E.status = 'finished'

// DeviceUseStatement has a known issue with the publication tooling
// so it is removed to allow this IG to publish until that is fixed
//define "Venous Foot Pumps Applied":
//  ["DeviceUseStatement": code in "Venous foot pump, device (physical object)"] D
//    where D.status = 'completed'
//      and D.bodySite ~ ToConcept("Right foot")
