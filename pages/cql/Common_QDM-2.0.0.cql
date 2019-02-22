library Common_QDM version '2.0.0'

/*
This example is a work in progress and should not be considered a final specification
or recommendation for guidance. This example will help guide and direct the process
of finding conventions and usage patterns that meet the needs of the various stakeholders
in the measure development community.
*/

using QDM version '5.0.2'

context Patient

define function 
   "Includes Or Starts During"(Diagnosis "Diagnosis", Encounter "Encounter, Performed"):
      Diagnosis.prevalencePeriod includes Encounter.relevantPeriod
         or Diagnosis.prevalencePeriod starts during Encounter.relevantPeriod