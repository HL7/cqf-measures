library Common_FHIR version '2.0.0'

/*
This example is a work in progress and should not be considered a final specification
or recommendation for guidance. This example will help guide and direct the process
of finding conventions and usage patterns that meet the needs of the various stakeholders
in the measure development community.
*/

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

context Patient

define function
   "Includes Or Starts During"(Condition Condition, Encounter Encounter):
      Interval[Condition.onset, Condition.abatement] includes Encounter.period
         or Condition.onset during Encounter.period
