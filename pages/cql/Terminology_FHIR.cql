library Terminology_FHIR

using FHIR version '3.0.0'

include FHIRHelpers version '3.0.0' called FHIRHelpers

// NOTE: Versioning is used in this example to illustrate completely how versioning is applied
// References to specific versions of code systems and value sets should be used only when necessary

codesystem "SNOMED-CT:2017-09": 'http://snomed.info/sct/731000124108' 
  version 'http://snomed.info/sct/731000124108/version/201709'

valueset "Encounter Inpatient SNOMEDCT Value Set":
   'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.7.307|20160929' 

code "Venous foot pump, device (physical object)": '442023007' from "SNOMED-CT:2017-09"
code "Right foot": '7769000' from "SNOMED-CT:2017-09"

parameter "Measurement Period" Interval<DateTime>

define "Inpatient Encounter":
  ["Encounter": type in "Encounter Inpatient SNOMEDCT Value Set"] E
    where E.status = 'finished'
    
define "Venous Foot Pumps Applied":
  ["DeviceUseStatement": code in "Venous foot pump, device (physical object)"] D
    where D.status = 'completed'
      and D.bodySite ~ ToConcept("Right foot")

