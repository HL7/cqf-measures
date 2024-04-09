<div class="new-content" markdown="1">

{: #profiles}

## Capability Profiles
{: #capability-profiles}

To support flexible representation and packaging of measure and library artifacts for different use cases, this implementation guide uses four general categories of profiles, aligned with the [knowledge capabilities](http://hl7.org/fhir/uv/cpg/CodeSystem-cpg-knowledge-capability.html) established by the [CPG-on-FHIR](http://hl7.org/fhir/uv/cpg) implementation guide:

### Measure Profiles
{: #measure-profiles}

Measure profiles supported in this IG are defined to allow for use independently or in combination with each other to support a wide range of use cases. The diagram below is to demonstrate the variety of combinations and example use cases. 

<b>Figure 7-1: Measure Profiles Venn Diagram</b>

{% include img.html img="QM_IG_Profile_Diagram.jpg" %}

| **Legend** | **Profile Conformance** | **Example Use Cases** |
|----|----|----|
| SCPE | [CRMIShareableMeasure]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablemeasure.html) <br>[CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html)  <br>[CQFMPublishableMeasure](StructureDefinition-publishable-measure-cqfm.html)  <br>[CQFMExecutableMeasure](StructureDefinition-executable-measure-cqfm.html)  |  Shareable, computable, executable and publishable measures would be fully published measures to support environments that are able to compile CQL or process ELM.    | 
| SEP | [CRMIShareableMeasure]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablemeasure.html) <br>[CQFMExecutableMeasure](StructureDefinition-executable-measure-cqfm.html)  <br>[CQFMPublishableMeasure](StructureDefinition-publishable-measure-cqfm.html) | Shareable, executable and publishable measures might be fully published measures expected to be used in environments that can process ELM.   |
| SCP | [CRMIShareableMeasure]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablemeasure.html) <br>[CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html)  <br>[CQFMPublishableMeasure](StructureDefinition-publishable-measure-cqfm.html) | Shareable, computable and publishable measures might be fully published measures expected to be used in environments that can compile CQL.     | 
| SCE | [CRMIShareableMeasure]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablemeasure.html) <br>[CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html) <br>[CQFMExecutableMeasure](StructureDefinition-executable-measure-cqfm.html) |  Shareable, computable and executable measures might be draft measures shared to environments that can either compile CQL or process ELM for testing and providing feedback on its use.   | 
| CE | [CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html) <br>[CQFMExecutableMeasure](StructureDefinition-executable-measure-cqfm.html)  | Measures that conform to computable measure and executable measure are generally intended to support measure content in contained environments that can either compile CQL or process ELM. Conforming to these two profiles supports both types of environments.  | 
| Shareable | [CRMIShareableMeasure]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablemeasure.html)  |  The shareable measure profile is generally intended to support a draft measure concept that does not have all associated meta data defined but can be shared for comment.  | 
| Computable | [CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html)    |  The computable measure profile is generally intended to support measure content in a contained environment that is able to compile CQL but cannot process ELM.   |
| Executable | [CQFMExecutableMeasure](StructureDefinition-executable-measure-cqfm.html)  | The executable measure profile is generally intended to support measure content in a contained environment that is capable of processing ELM but cannot compile CQL.    | 
| Publishable | [CQFMPublishableMeasure](StructureDefinition-publishable-measure-cqfm.html)  |  The publishable measure profile is generally intended to be used in combination with other profiles, most notably shareable measure. It is used to support the addition of elements necessary for formal publication of a specification.   | 
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
| [CRMIShareableLibrary]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablelibrary.html) | [CQLLibrary](http://hl7.org/fhir/uv/cql/StructureDefinition/cql-library) | [CRMIPublishableLibrary]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-publishablelibrary.html) | [ELM JSON Library]({{site.data.fhir.ver.cql}}/StructureDefinition-elm-json-library.html) <br> [ELM XML Library]({{site.data.fhir.ver.cql}}/StructureDefinition-elm-xml-library.html)  |
{: .grid }

* CQFMComputableMeasure  **SHALL** use CQLLibrary 
* CQFMExecutableMeasure  **SHALL** use either ELM JSON Library and/or ELM XML Library
* CQFMPublishableMeasure **SHOULD** use CRMIPublishableLibrary
* CQFMShareableMeasure   **SHOULD** use CRMIShareableLibrary   
 
### Terminology Profile Usage
{: #terminology-profile-usage}

| **Artifact** | **Shareable** | **Computable** | **Publishable** | **Executable** |
|----|----|----|----|----|
| CodeSystem | [CRMIShareableCodeSystem]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablecodesystem.html) | N/A (no requirements) | [CRMIPublishableCodeSytems]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-publishablecodesystem.html) | N/A (no requirements) |
| ValueSet | [CRMIShareableValueSet]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablevalueset.html) | [CRMIComputableValueSet]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-computablevalueset.html) | [CRMIPublishableValueSet]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-publishablevalueset.html) | [CRMIExpandedValueSet](http://hl7.org/fhir/uv/crmi/StructureDefinition-crmi-expandedvalueset.html) |
{: .grid }

* Due to varying code system capabilities, measure profiles are not restricted to use corresponding terminology profiles. 

### Additional Profiles
{: #additional-profiles}

To support packaging, testing, and distribution of measure and library artifacts, this implementation guide defines the following additional profiles: 

| **Profile** | **Description** | 
|----|----|
| CQFMDevice | A software device used in the creation, validation, evaluation, packaging, and/or testing of a library or measure artifact.  |
| CQFMTestCase | A measure report profile that allows definition and exchange of test cases for a measure.  |
{: .grid }



## Alphabetical Listing

- [Cohort Measure](StructureDefinition-cohort-measure-cqfm.html)
- [Composite Measure](StructureDefinition-composite-measure-cqfm.html)
- [Computable Measure](StructureDefinition-computable-measure-cqfm.html)
- [Continuous Variable Measure](StructureDefinition-cv-measure-cqfm.html)
- [Device](StructureDefinition-device-softwaresystem-cqfm.html)
- [Measure Test Case](StructureDefinition-test-case-cqfm.html)
- [Proportion Measure](StructureDefinition-proportion-measure-cqfm.html)
- [Publishable Measure](StructureDefinition-publishable-measure-cqfm.html)
- [Ratio Measure](StructureDefinition-ratio-measure-cqfm.html)

</div>

