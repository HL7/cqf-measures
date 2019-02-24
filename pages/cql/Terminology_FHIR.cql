library Terminology_FHIR

using FHIR version '3.0.0'

include FHIRHelpers version '3.0.0' called FHIRHelpers

codesystem "SNOMEDCT:2017-09": 'http://snomed.info/sct/731000124108' 
  version 'http://snomed.info/sct/731000124108/version/201709'

valueset "Encounter Inpatient SNOMEDCT Value Set":
   'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.7.307|20160929' 

code "Implantation (procedure)": '71861002' from "SNOMED-CT:2017-09"
code "Introduction - action (qualifier value)":  '129325002' from "SNOMED-CT:2017-09"
code "Venous foot pump, device (physical object)": '442023007' from "SNOMED-CT:2017-09"

parameter "Measurement Period" Interval<DateTime>

define "Inpatient Encounter":
  ["Encounter": type in "Encounter Inpatient SNOMEDCT Value Set"] E
    where E.status = 'finished'

define "Venous Foot Pumps Applied":
  ["Procedure": code in "Implantation(procedure)"] P
    where P.status = 'completed'
      and P.focalDevice.action ~ "Introduction - action (qualifier value)"
      and P.manipulated.resolve().type ~ "Venous foot pump, device (phyiscal object)"
