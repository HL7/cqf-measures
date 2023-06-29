---
layout: default
title: Changes
---
## Changes

### Version 2.0.0 (STU2)

#### Non-compatible

* [FHIR-26534](https://jira.hl7.org/browse/FHIR-26534) - Use of `text/cql.identifier` media type for CQL expression references
* [FHIR-21994](https://jira.hl7.org/browse/FHIR-21994) - Use of namespaces with CQL libraries
* [FHIR-25285](https://jira.hl7.org/browse/FHIR-25285) - Changed definition term extension to preserve association of term and definition
* [FHIR-21998](https://jira.hl7.org/browse/FHIR-21998) - Disallowed stratification of ratio measures
* [FHIR-21996](https://jira.hl7.org/browse/FHIR-21996) - Required use of `called` clause for included libraries
* [FHIR-27930](https://jira.hl7.org/browse/FHIR-27930) -  Added PI Measure example (no library) 

#### Compatible, Substantive
* Corrections to proportion, ratio, and continuous-variable measure profiles
* Added profile layering for shareable, computable, publishable, and executable capabilities
* Added profiles and guidance for packaging, distribution, and testing
* Clarified risk adjustment conformance requirements
* Added support for identifying packaging, testing, and authoring tooling
* Library and measure resources require narrative and profile declarations
* Added publicationStatus and publicationDate extensions for relatedArtifact
* Clarified calculation flow diagrams for all measure types
* Clarified relationship of FHIR terminology to V3 measure terminology
* Added support for defining and referencing measure programs

#### Non-substantive
* Numerous clarifications and corrections throughout
