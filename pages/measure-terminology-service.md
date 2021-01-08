---
layout: default
title: Measure Terminology Service
---

# Overview
This page describes documents the use cases and conformance expectations of a terminology service to support authoring, distribution, and evaluation of FHIR-based quality measure specifications as described in this implementation guide.

## Code Systems

1. Represent basic CodeSystem information, as specified by the [ShareableCodeSystem](http://hl7.org/fhir/shareablecodesystem.html) profile, which includes url, version, name, status, experimental, publisher, description, caseSensitive, content, and concept.

2. For published CodeSystems, represent publishable CodeSystem information, as specified by the [CQFMPublishableCodeSystem](StructureDefinition-publishable-codesystem-cqfm.html) profile.

3. Support CodeSystem read by the server-defined id for the CodeSystem

4. Support CodeSystem searches by:
    1. url: Returning all versions of the codesystem matching that url
    2. version: Returning the codesystem matching that version (can appear only in combination with a url search)
    3. identifier: Returning any codesystem matching the identifier
    4. name: Returning any codesystem matching the name, according to the string-matching semantics in FHIR
    5. title: Returning any codesystem matching the title, according to the string-matching semantics in FHIR
    6. status: Returning codesystems that match the given status
    7. description: Returning any codesystem matching the search description, according to string-matching semantics in FHIR
    8. code: Returning any codesystem with the given code

5. Support CodeSystem/$lookup

6. Support CodeSystem/$validate-code

## Value Sets

1. Represent basic ValueSet information, as specified by the [ShareableValueSet](http://hl7.org/fhir/shareablevalueset.html) profile, which includes url, version, name, status, experimental, publisher, and description.

2. Represent computable ValueSet information, as specified by the [CQFMComputableValueSet](StructureDefinition-computable-valueset-cqfm.html) profile, which specifies the definition of a value set using established extensions, or with the `compose` element, including in particular the ability to use the `inactive` element of the `include` to indicate that a specific code is inactive in the code system but should still be included in the expansion.

3. Represent executable ValueSet information, as specified by the [CQFMExecutableValueSet](StructureDefinition-executable-valueset-cqfm.html) profile, which specifies the complete content of a value set using the `expansion` element, including inactive codes specified in the compose.

4. For published ValueSets, represent publishable ValueSet information, as specified by the [CQFMPublishableValueSet](StructureDefinition-publishable-valueset-cqfm.html) profile.

5. Support ValueSet read, by the server-defined id for the ValueSet

6. Support ValueSet searches by:
    1. url: Returning all versions of the valueset matching that url
    2. version: Returning the valueset matching that version (can appear only in combination with a url search)
    3. identifier: Returning any valueset matching the identifier
    4. name: Returning any valueset matching the name, according to the string-matching semantics in FHIR
    5. title: Returning any valueset matching the title, according to the string-matching semantics in FHIR
    6. status: Returning valuesets that match the given status
    7. description: Returning any valueset matching the search description, according to string-matching semantics in FHIR
    8. code: Returning any valueset with the given code

7. Support ValueSet/$validate-code
    1. Support the url parameter
    2. Support the valueSetVersion parameter
    3. Support the code parameter
    4. Support the system parameter
    5. Support the systemVersion parameter
    6. Support the coding parameter
    7. Support the codeableConcept parameter

8. Support ValueSet/$expand
    1. Support the url parameter
    2. Support the valueSetVersion parameter
    3. Support the system-version parameter
    4. Support the check-system-version parameter
    5. Support the force-system-version parameter

## Quality Programs (Binding Parameters Specification)

1. Represent basic quality program information, as specified by the [CQFMQualityProgram](StructureDefinition-quality-program-cqfm.html) profile, which includes identifier, title, type, date, useContext, effectivePeriod, measure, and terminology references

2. For published quality programs, represent publishable quality program information as specified by the [CQFMPublishableLibrary](StructureDefinition-publishable-library-cqfm.html) profile.

3. Support Quality Program (Library) read, by the server-defined id for the quality program library

4. Support Quality Program (Library) searches by:
    1. url: Returning all versions of the quality program matching that url
    2. version: Returning the quality program matching that version (can appear only in combination with a url search)
    3. identifier: Returning any quality program matching the identifier
    4. name: Returning any quality program matching the name, according to the string-matching semantics in FHIR
    5. title: Returning any quality program matching the title, according to the string-matching semantics in FHIR
    6. status: Returning quality programs that match the given status
    7. description: Returning any quality programs matching the search description, according to string-matching semantics in FHIR
    8. composed-of: Returning any quality program that includes the given measure canonical
    9. depends-on: Returning any quality program that references the given code system or value set canonical

5. Support quality program value set packaging: [Library/$get-valueset-expansions](OperationDefinition-library-get-valueset-expansions.html) operation
    1. url
    2. version
    3. offset
    4. count
    5. system-version
    6. check-system-version
    7. force-system-version
