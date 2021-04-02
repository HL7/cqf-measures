library EXM_IA

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'

valueset "Attestation Question": 'TBD'

context Practitioner

define "Measure Population":
  Practitioner

define function "Measure Observation"(Practitioner Practitioner):
  [Observation: "Attestation Question"] O
    where O.value = 1
      and O.extension[O.extension.indexOf('http://hl7.org/fhir/StructureDefinition/request-notDone')].value
      and O.notDone
    return FHIRHelpers.ToBoolean(O.value)
