library EXM_Aggregate

using FHIR version '4.0.1'

parameter "Measurement Period" Interval<DateTime>

context Location

define "Initial Population":
  [MeasureReport] MR
    where MR.measure.value = 'http://example.org/fhir/Measure/malnutrition-assessment'
      and MR.status.value = 'complete'
      and MR.date.value during "Measurement Period"

define "Measure Population":
  "Initial Population"

/* Continuous variable measure with Sum as the aggregate method */
define function "Measure Observation"(measureReport MeasureReport):
  measureReport.group[0].measureScore.value.value
