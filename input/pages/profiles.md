{: #profiles}

## Capability Profiles
{: #capability-profiles}

To support flexible representation and packaging of measure and library artifacts for different use cases, this implementation guide uses four general categories of profiles, aligned with the [knowledge capabilities](http://hl7.org/fhir/uv/cpg/CodeSystem-cpg-knowledge-capability.html) established by the [CPG-on-FHIR](http://hl7.org/fhir/uv/cpg) implementation guide:

### Measure Profiles
{: #measure-profiles}

Measure profiles supported in this IG are defined to allow for use independently or in combination with each other to support a wide range of use cases. The diagram below is to demonstrate the variety of combinations and example use cases. 

<b>Figure 7-1: Measure Profiles Venn Diagram</b>

{% include img.html img="QM_IG_Profile_Diagram.jpg" %}

| **Legend** | **Public Conformance** | **Example Use Cases** |
|----|----|----|
| S | [CRMIShareableMeasure]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablemeasure.html)  |   | 
| C | [CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html)    |   | 
| P | [CQFMPublishableMeasure](StructureDefinition-publishable-measure-cqfm.html)  |   | 
| E | [CQFMExecutableMeasure](StructureDefinition-executable-measure-cqfm.html)  |   | 
| SC | [CRMIShareableMeasure]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablemeasure.html) <br>[CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html)  |   | 
| CP | [CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html) <br>[CQFMPublishableMeasure](StructureDefinition-publishable-measure-cqfm.html)  |   | 
| CE | [CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html) <br>[CQFMExecutableMeasure](StructureDefinition-executable-measure-cqfm.html)  |   | 
| PE | [CQFMPublishableMeasure](StructureDefinition-publishable-measure-cqfm.html) <br>[CQFMExecutableMeasure](StructureDefinition-executable-measure-cqfm.html)  |   | 
| SCE | [CRMIShareableMeasure]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablemeasure.html) <br>[CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html) <br>[CQFMExecutableMeasure](StructureDefinition-executable-measure-cqfm.html) |   | 
| SCP | [CRMIShareableMeasure]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablemeasure.html) <br>[CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html)  <br>[CQFMPublishableMeasure](StructureDefinition-publishable-measure-cqfm.html) |   | 
| CPE | [CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html)  <br>[CQFMPublishableMeasure](StructureDefinition-publishable-measure-cqfm.html)  <br>[CQFMExecutableMeasure](StructureDefinition-executable-measure-cqfm.html)  |   | 
| SEP | [CRMIShareableMeasure]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablemeasure.html) <br>[CQFMExecutableMeasure](StructureDefinition-executable-measure-cqfm.html)  <br>[CQFMPublishableMeasure](StructureDefinition-publishable-measure-cqfm.html) |   | 
| SCPE | [CRMIShareableMeasure]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablemeasure.html) <br>[CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html)  <br>[CQFMPublishableMeasure](StructureDefinition-publishable-measure-cqfm.html)  <br>[CQFMExecutableMeasure](StructureDefinition-executable-measure-cqfm.html)  |   | 
{: .grid }

In addition to conforming to profiles to support appropriate function or representation, measures are required to conform to the appropriate measure profile based on their scoring type:

<table class="grid">
  <tr><th>Scoring Type</th><th>Profile</th></tr>
  <tr><td>Cohort</td><td><a href="StructureDefinition-cohort-measure-cqfm.html">CQFMCohortMeasure</a></td></tr>
  <tr><td>Proportion</td><td><a href="StructureDefinition-proportion-measure-cqfm.html">CQFMProportionMeasure</a></td></tr>
  <tr><td>Ratio</td><td><a href="StructureDefinition-ratio-measure-cqfm.html">CQFMRatioMeasure</a></td></tr>
  <tr><td>Continuous Variable</td><td><a href="StructureDefinition-cv-measure-cqfm.html">CQFMContinuousVariableMeasure</a></td></tr>
  <tr><td>Composite</td><td><a href="StructureDefinition-composite-measure-cqfm.html">CQFMCompositeMeasure</a></td></tr>
</table>

### Library Profile Usage
{: #library-profile-usage}

| **Shareable** | **Computable** | **Publishable** | **Executable** |
|----|----|----|----|
| [CRMIShareableMeasure]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablemeasure.html) | [CQLLibrary]({{site.data.fhir.ver.cql}}/StructureDefinition-cql-library) | [CRMIPublishableMeasure]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-publishablemeasure.html) | [ELMLibrary]({{site.data.fhir.ver.cql}}/StructureDefinition-elm-library.html)  |
{: .grid }

* CQFMComputableMeasure **SHALL** use CQLLibrary 
* CQFMExecutableMeasure **SHALL** use ELMLibrary
* CQFMPublishableMeasure **SHOULD** use CRMIPublishableLibrary  
 
### Terminology Profile Usage
{: #terminology-profile-usage}

| **Artifact** | **Shareable** | **Computable** | **Publishable** | **Executable** |
|----|----|----|----|----|
| CodeSystem | [CRMIShareableCodeSystem]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablecodesystem.html) | N/A (no requirements) | [CRMIPublishableCodeSytems]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-publishablecodesystem.html) | N/A (no requirements) |
| ValueSet | [CRMIShareableValueSet]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablevalueset.html) | [CRMISComputableValueSet]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-computablevalueset.html) | [CRMIPublishableValueSet]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-publishablevalueset.html) | [CRMISExecutableValueSet]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-executablevalueset.html) |
{: .grid }

* Due to varying code system capabilities, measure profiles are not restricted to use corresponding terminology profiles. 

### Additional Profiles
{: #additional-profiles}

To support packaging, testing, and distribution of measure and library artifacts, this implementation guide defines the following additional profiles: 

| **Profile** | **Description** | 
|----|----|
| CQFMCapabilityStatement | A system capability statement that can express which version of CQL is supported  |
| CQFMDevice | A software device used in the creation, validation, evaluation, packaging, and/or testing of a library or measure artifact.  |
| CQFMModelInfoLibrary | A library profile used to distribute model information libraries used in quality measurement.  |
| CQFMModuleDefinitionLibrary | A library profile used to define and exchange effective data requirements and usage information for an artifact (or collection of artifacts) used in quality measurement.   |
| CQFMTestCase | A measure report profile that allows definition and exchange of test cases for a measure.  |
{: .grid }



## Alphabetical Listing

- [Capability Statement](StructureDefinition-capability-statement-cqfm.html)
- [Cohort Measure](StructureDefinition-cohort-measure-cqfm.html)
- [Composite Measure](StructureDefinition-composite-measure-cqfm.html)
- [Computable Measure](StructureDefinition-computable-measure-cqfm.html)
- [Continuous Variable Measure](StructureDefinition-cv-measure-cqfm.html)
- [Device](StructureDefinition-device-softwaresystem-cqfm.html)
- [Measure Test Case](StructureDefinition-test-case-cqfm.html)
- [Model Info Library](StructureDefinition-modelinfo-library-cqfm.html)
- [Module Definition Library](StructureDefinition-module-definition-library-cqfm.html)
- [Proportion Measure](StructureDefinition-proportion-measure-cqfm.html)
- [Publishable Measure](StructureDefinition-publishable-measure-cqfm.html)
- [Ratio Measure](StructureDefinition-ratio-measure-cqfm.html)



