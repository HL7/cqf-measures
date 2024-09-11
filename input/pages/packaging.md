{:toc}

{: #measure-packaging}

To facilitate publishing and distribution of quality measures, this Implementation Guide provides guidance on how to package quality measures, either independently, or as part of a collection of related measures.

Measure packages are a special case of the more general [Artifact Packaging]({{site.data.fhir.ver.crmi}}/packaging.html) capability described in the Canonical Resource Management Infrastructure (CRMI) implementation guide. Measures may be packaged using that approach, with additional considerations as discussed in the following topics.

### Packaging Libraries
{: #packaging-libraries}

To support usage of a logic library, the library package contains the following general components:

* Structured representation of the library and associated metadata (the Library resource)
* Human readable description of the library contents (the Narrative of the Library resource)
* Machine readable description of the population criteria (in the Library resource as additional attachments containing the Expression Logical Model (ELM) content for the CQL)
* Optionally, all the required libraries referenced by the library, recursively (included as Library resources)
* Optionally, all the required terminologies referenced by the library, or any required libraries (included as CodeSystem and/or ValueSet resources)

The following are conformance requirements when packaging a Library:

**Conformance Requirement 6.1 (Library Packaging):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-6-1)
{: #conformance-requirement-6-1}

  1. The first entry in a Library bundle SHALL be a Library resource conforming
  2. Library bundles MAY include any libraries referenced by the primary library
  3. Library bundles MAY include any code systems and value sets referenced by the primary library or any required libraries.
  4. For CQL Library resources
      1. If the target environment supports the use of CQL directly, Library resources SHOULD conform to the [CQLLibrary]({{site.data.fhir.ver.cql}}/StructureDefinition-cql-library.html) profile.
      2. If the target environment supports the use of ELM directly, Library resources SHOULD conform to one (or both) of the [ELMXMLLibrary]({{site.data.fhir.ver.cql}}/StructureDefinition-elm-xml-library.html) or [ELMJSONLibrary]({{site.data.fhir.ver.cql}}/StructureDefinition-elm-json-library.html) profiles.

### Packaging Measures
{: #packaging-measures}

To support usage of a quality measure, the quality measure package contains the following
general components:

* Structured representation of the quality measure and associated metadata (the Measure resource)
* Human readable description of the quality measure and population criteria (the Narrative of the Measure resource)
* The primary logic library for the quality measure (the Library resource containing at least the Clinical Quality Language (CQL) source)
* Machine readable description of the population criteria (in the Library resource as additional attachment elements containing the Expression Logical Model (ELM) content for the CQL)
* Optionally, all the required libraries referenced by the primary library of the quality measure, recursively (included as Library resources)
* Optionally, all the required terminologies referenced by the primary library or any required libraries (included as CodeSystem and/or ValueSet resources)
* Optionally, any test cases defined for the quality measure

The following are conformance requirements when packaging a Measure:

**Conformance Requirement 6.2 (Measure Packaging):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-6-2)
{: #conformance-requirement-6-2}

  1. The first entry in a Measure bundle SHALL be a Measure resource
  2. The second entry in a Measure bundle SHALL be the primary Library resource for the measure
  3. Measure bundles MAY include any libraries referenced by the primary library
  4. Measure bundles MAY include any code systems and value sets referenced by the primary library or any required libraries.
  5. Measure bundles MAY include any test case bundles defined for the measure
  6. If the capabilities parameter of the package request includes `computable`:
      a. The Measure resource SHALL conform to the [CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html) profile.
      b. The Library resource(s) SHALL conform to the [CRMIComputableLibrary]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-computablelibrary.html) profile.
      b. For Measures using CQL:
          i. The Measure resource SHALL conform to the [CQLMeasure](StructureDefinition-cql-measure-cqfm.html) profile.
          ii. The Library resource(s) SHALL conform to the [CQLLibrary]({{site.data.fhir.ver.cql}}/StructureDefinition-cql-library.html)
  7. If the capabilities parameter of the package request includes `executable`: 
      a. The Measure resource SHALL conform to the [CQFMExecutableMeasure](StructureDefinition-executable-measure-cqfm.html) profile.
      b. The Library resource(s) SHALL conform to the [CRMIExecutableLibrary](StructureDefinition-crmi-executablelibrary.html) profile.
      a. For Measures using CQL
          i. The Measure resource SHALL conform to the [ELMMeasure](StructureDefinition-elm-measure-cqfm.html) profile.
          ii. The Library resource(s) SHALL conform to one (or both) of the [ELMXMLLibrary]({{site.data.fhir.ver.cql}}/StructureDefinition-elm-xml-library.html) or [ELMJSONLibrary]({{site.data.fhir.ver.cql}}/StructureDefinition-elm-json-library.html) profiles.

### Packaging Terminology
{: #packaging-terminology}

* What terminology components need to be included in a measure package is dependent on the expected terminology capabilities of the target environment. The "terminologyCapabilities" parameter of the $package operation provides the expected capabilities, and the resulting measure package will include terminology resources consistent with those capabilities.

### Packaging Test Cases
{: #packaging-test-cases}

Basic testing of measure logic should involve at least one positive and negative test of each of the population criteria. A test case is represented as a set of test resources, together with a MeasureReport that conforms to the [CQFMTestCase](StructureDefinition-test-case-cqfm.html) profile to define the expected results. The test case bundle can then be used to package and distribute the test case.

**Conformance Requirement 6.3 (Test Case Packaging):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-6-3)
{: #conformance-requirement-6-3}

  1. The first entry in a TestCase bundle SHALL be a MeasureReport resource representing the expected outcome of evaluating the measure, given the test data provided as part of the test case
  2. TestCase bundles SHALL include any resource data required to evaluate the test case
