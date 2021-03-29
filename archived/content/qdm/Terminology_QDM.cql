library TerminologySectionExample

using QDM version '5.0.2'

codesystem "SNOMED-CT": 'urn:oid:2.16.840.1.113883.6.96'
   version 'urn:hl7:version:201609'
valueset "Encounter Inpatient SNOMEDCT Value Set":
   'urn:oid:2.16.840.1.113883.3.666.7.307' version 'urn:hl7:version:20160929'
code "Venous foot pump, device (physical object)": '442023007' from "SNOMED-CT"

parameter "Measurement Period" Interval<DateTime>

define "Inpatient Encounter":
  ["Encounter, Performed": "Encounter Inpatient SNOMEDCT Value Set"]

define "Venous Foot Pumps Applied":
  ["Device, Applied": "Venous foot pump, device (physical object)"]
