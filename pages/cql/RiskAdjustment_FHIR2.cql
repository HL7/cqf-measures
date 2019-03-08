library RiskAdjustment_FHIR2 version '0.0.001'

using FHIR version '1.0.2'

include FHIRHelpers version '1.0.2' called FHIRHelpers
include SupplementalDataElements_FHIR2 version '1.0.0' called SDE

valueset "Serum Albumin": '2.16.840.1.113762.1.4.1029.60'
valueset "Cirrhosis or other liver disease": '2.16.840.1.113762.1.4.1029.63'
valueset "Encounter Inpatient": '2.16.840.1.113883.3.666.5.307'
valueset "CABG_Open and Endoscopic": '2.16.840.1.113762.1.4.1029.39'
valueset "Bilirubin": '2.16.840.1.113883.3.666.5.2400'

parameter "Measurement Period" Interval<DateTime>

context Patient

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"

define "Encounter Inpatient 365": ["Encounter": "Encounter Inpatient"] E
    where FHIRHelpers.ToQuantity(E.length) <= 365 days // Shouldn't need the ToQuantity, need a FHIR.Duration conversion
      and E.period ends during "Measurement Period"
			and E.status.value in {'finished'}

define "CABG_Open and Endoscopic During Encounter": ["Procedure": "CABG_Open and Endoscopic"] P
    with "Encounter Inpatient 365" E
      such that P.performedPeriod starts during E.period
				and P.status.value in {'completed'}

define "Hepatic Failure":
    exists ("Cirrhosis Dx")
    and exists ("Bilirubin Test")
    and exists ("Serum Albumin Test")

define "Cirrhosis Dx": ["Condition": "Cirrhosis or other liver disease"] D
    with "CABG_Open and Endoscopic During Encounter" C
			such that D.onsetDateTime.value before start of C.performedPeriod
//      such that Coalesce (D.onsetDateTime.value, start of ToInterval(D.onsetPeriod)) before start of ToInterval(C.performedPeriod)

define "Bilirubin Test":
["Observation": "Bilirubin"] L
    with "CABG_Open and Endoscopic During Encounter" C
      such that L.effectiveDateTime.value before start of C.performedPeriod
//				such that Coalesce (L.effectiveDateTime.value, start of ToInterval(L.effectivePeriod)) starts before start of ToInterval(C.performedPeriod)
    with "Encounter Inpatient 365" E
      such that L.effectiveDateTime.value during E.period
    where L.valueQuantity > 2 'mg/dL'
      and L.status.value in {'final', 'amended', 'corrected', 'appended'}

define "Serum Albumin Test":
["Observation": "Serum Albumin"] L
    with "CABG_Open and Endoscopic During Encounter" C
      such that L.effectiveDateTime.value before start of C.performedPeriod
    with "Encounter Inpatient 365" E
      such that L.effectiveDateTime.value during E.period
    where L.valueQuantity < 3.5 'g/dL'
      and L.status.value in {'final', 'amended', 'corrected', 'appended'}

define "Initial Population": "Encounter Inpatient 365"

define "Denominator": "Initial Population"

define "Numerator": "CABG_Open and Endoscopic During Encounter"
