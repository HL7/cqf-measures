library TestRiskAdj version '0.0.001'

//using QDM version '5.0.2'
using FHIR version '1.0.2'

valueset "Race": '2.16.840.1.114222.4.11.836'

valueset "ONC Administrative Sex": '2.16.840.1.113762.1.4.1'

valueset "Ethnicity": '2.16.840.1.114222.4.11.837'

valueset "Payer": '2.16.840.1.114222.4.11.3591'

valueset "Serum Albumin": '2.16.840.1.113762.1.4.1029.60'

valueset "Cirrhosis or other liver disease": '2.16.840.1.113762.1.4.1029.63'

valueset "Encounter Inpatient": '2.16.840.1.113883.3.666.5.307'

valueset "CABG_Open and Endoscopic": '2.16.840.1.113762.1.4.1029.39'

valueset "Bilirubin": '2.16.840.1.113883.3.666.5.2400'

define function ToInterval(period FHIR.Period):
	Interval[period."start".value, period."end".value]

define function ToQuantity(quantity FHIR.Quantity):
  System.Quantity { value: quantity.value.value, unit: quantity.unit.value }

//parameter "Measurement Period" Interval<DateTime>
define "Measurement Period":
  Interval[@2018-01-01T00:00:00.0, @2019-01-01T00:00:00.0)

context Patient

//define "SDE Ethnicity": ["Patient Characteristic Ethnicity": "Ethnicity"]

//define "SDE Payer": ["Patient Characteristic Payer": "Payer"]

//define "SDE Race": ["Patient Characteristic Race": "Race"]

//define "SDE Sex": ["Patient Characteristic Sex": "ONC Administrative Sex"]
define "SDE Sex" :
	[Patient] P
		where P.gender.value in {'male', 'female'}

define "Encounter Inpatient 365": ["Encounter": "Encounter Inpatient"] E
    where ToQuantity(E.length) <= 365 days
      and ToInterval(E.period) ends during "Measurement Period"
			and E.status.value in {'finished'}

define "CABG_Open and Endoscopic During Encounter": ["Procedure": "CABG_Open and Endoscopic"] P
    with "Encounter Inpatient 365" E
      such that ToInterval(P.performedPeriod) starts during ToInterval(E.period)
				and P.status.value in {'completed'}

define "Hepatic Failure":
    exists ("Cirrhosis Dx")
    and exists ("Bilirubin Test")
    and exists ("Serum Albumin Test")

define "Cirrhosis Dx": ["Condition": "Cirrhosis or other liver disease"] D
    with "CABG_Open and Endoscopic During Encounter" C
			such that D.onsetDateTime.value before start of ToInterval(C.performedPeriod)
//      such that Coalesce (D.onsetDateTime.value, start of ToInterval(D.onsetPeriod)) before start of ToInterval(C.performedPeriod)

define "Bilirubin Test":
["Observation": "Bilirubin"] L
    with "CABG_Open and Endoscopic During Encounter" C
      such that L.effectiveDateTime.value before start of ToInterval(C.performedPeriod)
//				such that Coalesce (L.effectiveDateTime.value, start of ToInterval(L.effectivePeriod)) starts before start of ToInterval(C.performedPeriod)
    with "Encounter Inpatient 365" E
      such that L.effectiveDateTime.value during ToInterval(E.period)
    where ToQuantity(L.valueQuantity) > 2 'mg/dL'
      and L.status.value in {'final', 'amended', 'corrected', 'appended'}

define "Serum Albumin Test":
["Observation": "Serum Albumin"] L
    with "CABG_Open and Endoscopic During Encounter" C
      such that L.effectiveDateTime.value before start of ToInterval(C.performedPeriod)
    with "Encounter Inpatient 365" E
      such that L.effectiveDateTime.value during ToInterval(E.period)
    where ToQuantity(L.valueQuantity) < 3.5 'g/dL'
      and L.status.value in {'final', 'amended', 'corrected', 'appended'}

define "Initial Population": "Encounter Inpatient 365"

define "Denominator": "Initial Population"

define "Numerator": "CABG_Open and Endoscopic During Encounter"
