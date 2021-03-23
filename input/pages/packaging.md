---
layout: default
title: Packaging
---

---

<!-- TOC  the css styling for this is \pages\assets\css\project.css under 'markdown-toc'-->

* Do not remove this line (it will not be displayed)
{:toc}

## 6 Measure Packaging
{: #measure-packaging}

To facilitate publishing and distribution of quality measures, this Implementation Guide
provides guidance on how to package quality measures, either independently, or as part of a collection of related measures.

### 6.1 Packaging Artifacts
{: #packaging-artifacts}

In general, artifacts such as libraries, measures, and test cases are packaged as a Bundle
of type `transaction`. They may span multiple bundles in a given delivery, thus the bundle should be processed as a unit.

An artifact bundle contains the artifact as the first entry in the bundle, and optionally the
dependencies and associated artifacts as subsequent entries as follows:

1. **Artifact**: The main artifact resource for the package (such as a Measure or Library)
2. **Library Dependencies**: Any libraries required for the artifact
3. **Terminology Dependencies**: Any CodeSystem or ValueSet resources required for the artifact
4. **Test Cases**: Any test cases defined for the artifact

*Note that if an artifact package is large enough to require segmentation in multiple bundles, use of `transaction` bundles may not be feasible.

### 6.2 Packaging Libraries
{: #packaging-libraries}

To support usage of a logic library, the library package contains the following general components:

* Structured representation of the library and associated metadata (the Library resource)
* Human readable description of the library contents (the Narrative of the Library resource)
* Machine readable description of the population criteria (in the Library resource as additional attachments containing the Expression Logical Model (ELM) content for the CQL)
* Optionally, all the required libraries referenced by the library, recursively (included as Library resources)
* Optionally, all the required terminologies referenced by the library, or any required libraries (included as CodeSystem and/or ValueSet resources)

The following are conformance requirements when packaging a Library:

**Conformance Requirement 6.1 (Library Packaging):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-6-1)
{: #conformance-requirement-6-1}

  1. The first entry in a Library bundle SHALL be a Library resource conforming
  2. Library bundles MAY include any libraries referenced by the primary library
  3. Library bundles MAY include any code systems and value sets referenced by the primary library or any required libraries.

### 6.3 Packaging Measures
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

**Conformance Requirement 6.2 (Measure Packaging):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-6-2)
{: #conformance-requirement-6-2}

  1. The first entry in a Measure bundle SHALL be a Measure resource
  2. The second entry in a Measure bundle SHALL be the primary Library resource for the measure
  3. Measures bundles MAY include any libraries referenced by the primary library
  4. Library bundles MAY include any code systems and value sets referenced by the primary library or any required libraries.
  5. Library bundles MAY include any test case bundles defined for the measure

### 6.4 Packaging Test Cases
{: #packaging-test-cases}

Basic testing of measure logic should involve at least one positive and negative test of each of the population criteria. A test case is represented as a set of test resources, together with a MeasureReport that conforms to the [CQFMTestCase](StructureDefinition-test-case-cqfm.html) profile to define the expected results. The test case bundle can then be used to package and distribute the test case.

**Conformance Requirement 6.3 (Test Case Packaging):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-6-3)
{: #conformance-requirement-6-3}

  1. The first entry in a TestCase bundle SHALL be a MeasureReport resource representing the expected outcome of evaluating the measure, given the test data provided as part of the test case
  2. TestCase bundles SHALL include any resource data required to evaluate the test case

### 6.5 Intellectual Property of Packaging
  {: #intellectual-property-packaging}

**Conformance Requirement 6.4 (Intellectual Property Considerations):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-6-4)
  {: #conformance-requirement-6-4}
  1. Artifacts distributed in this way SHALL carry the appropriate copyright and intellectual property declarations.

**Conformance Requirement 6.5 (Quality Program):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-6-5)
{: #conformance-requirement-6-5}

This implementation guide includes a profile for describing a quality program as a collection of quality measures. This profile is a Library of type `asset-collection` that uses the `relatedArtifact` element to indicate which measures are part of the quality program. In addition, measures and libraries can use the `useContext` element to specify a quality program.

1. Artifacts SHOULD use the `useContext` element with the `program` context type to specify a quality program
2. Quality program descriptions SHALL use the [CQFQualityProgram](StructureDefinition-quality-program-cqfm.html) profile
