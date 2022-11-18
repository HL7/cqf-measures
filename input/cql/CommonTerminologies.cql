/*
This example is purely for illustration purposes to show how all the elements of a
FHIR-based quality measure are represented. It is intentionally simplified to show
specific aspects of a measure, and is not intended as an example of a clinically
meaningful measure.
*/
library CommonTerminologies version '1.0.0'

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1' called FHIRHelpers

// NOTE: Versioning is used in this example to illustrate completely how versioning is applied
// References to specific versions of code systems and value sets should be used only when necessary

codesystem "SNOMED CT:2017-09": 'http://snomed.info/sct'
  version 'http://snomed.info/sct/731000124108/version/201709'
