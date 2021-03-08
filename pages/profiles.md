---
layout: default
title: Profiles
---

---

## 7 Profiles
{: #profiles}

### 7.1 Capability Profiles

To support flexible representation and packaging of measure and library artifacts for different use cases, this implementation guide uses four general categories of profiles, aligned with the [knowledge capabilities](http://build.fhir.org/ig/HL7/cqf-recommendations/CodeSystem-cpg-knowledge-capability.html) established by the [CPG-on-FHIR](http://build.fhir.org/ig/HL7/cqf-recommendations) implementation guide:

<table>
  <tr><th>Artifact</th><th>Shareable</th><th>Computable</th><th>Publishable</th><th>Executable</th></tr>
  <tr><td>CodeSystem</td><td>N/A (use base ShareableCodeSystem)</td><td>N/A (no requirements)</td><td><a href="StructureDefinition-publishable-codesystem-cqfm.html">CQFMPublishableCodeSystem</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>Library</td><td><a href="StructureDefinition-library-cqfm.html">CQFMLibrary</a></td><td><a href="StructureDefinition-computable-library-cqfm.html">CQFMComputableLibrary</a></td><td><a href="StructureDefinition-publishable-library-cqfm.html">CQFMPublishableLibrary</a></td><td><a href="StructureDefinition-executable-library-cqfm.html">CQFMExecutableLibrary</a></td></tr>
  <tr><td>Measure</td><td><a href="StructureDefinition-measure-cqfm.html">CQFMMeasure</a></td><td><a href="StructureDefinition-computable-measure-cqfm.html">CQFMComputableMeasure</a></td><td><a href="StructureDefinition-publishable-measure-cqfm.html">CQFMPublishableMeasure</a></td><td>N/A</td></tr>
  <tr><td>ValueSet</td><td>N/A (use base ShareableValueSet)</td><td><a href="StructureDefinition-computable-valueset-cqfm.html">CQFMComputableValueSet</a></td><td><a href="StructureDefinition-publishable-valueset-cqfm.html">CQFMPublishableValueSet</a></td><td><a href="StructureDefinition-executable-valueset-cqfm.html">CQFMExecutableValueSet</a></td></tr>

</table>

In addition, measures are required to conform to the appropriate measure profile based on their scoring type:

<table>
  <tr><th>Scoring Type</th><th>Profile</th></tr>
  <tr><td>Cohort</td><td><a href="StructureDefinition-cohort-measure-cqfm.html">CQFMCohortMeasure</a></td></tr>
  <tr><td>Proportion</td><td><a href="StructureDefinition-proportion-measure-cqfm.html">CQFMProportionMeasure</a></td></tr>
  <tr><td>Ratio</td><td><a href="StructureDefinition-ratio-measure-cqfm.html">CQFMRatioMeasure</a></td></tr>
  <tr><td>Continuous Variable</td><td><a href="StructureDefinition-cv-measure-cqfm.html">CQFMContinuousVariableMeasure</a></td></tr>
  <tr><td>Composite</td><td><a href="StructureDefinition-composite-measure-cqfm.html">CQFMCompositeMeasure</a></td></tr>
</table>

To support packaging, testing, and distribution of measure and library artifacts, this implementation guide defines the following additional profiles:

<table>
  <tr><th>Profile</th><th>Description</th></tr>
  <tr><td><a href="StructureDefinition-device-softwaresystem-cqfm.html">CQFMDevice</a></td><td>A software device used in the creation, validation, evaluation, packaging, and/or testing of a library or measure artifact.</td></tr>
  <tr><td><a href="StructureDefinition-library-bundle-cqfm.html">CQFMLibraryBundle</a></td><td>A bundle used to package a library artifact for distribution.</td></tr>
  <tr><td><a href="StructureDefinition-measure-bundle-cqfm.html">CQFMLibraryMeasure</a></td><td>A bundle used to package a measure artifact for distribution.</td></tr>
  <tr><td><a href="StructureDefinition-modelinfo-library-cqfm.html">CQFMModelInfoLibrary</a></td><td>A library profile used to distribute model information libraries used in quality measurement.</td></tr>
  <tr><td><a href="StructureDefinition-quality-program-cqfm.html">CQFMQualityProgram</a></td><td>A library profile used to establish a set of related quality improvement artifacts such as a measure program.</td></tr>
  <tr><td><a href="StructureDefinition-testcase-bundle-cqfm.html">CQFMTestCaseBundle</a></td><td>A bundle used to package a test case for distribution.</td></tr>
</table>

### 7.2 Alphabetical Listing

{% include list-simple-profiles.xhtml %}
