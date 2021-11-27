{: #capabilities}

The following sequence diagram depicts a data element submission scenario. The roles depicted are:

* Submitting System - This would be either a hospital, physician practice, or any organization that wants to submit the relevant eCQM data to a receiving system
* Knowledge Repository - This would be a FHIR server that has the eCQMs loaded and is the source of truth for those eCQMS and can provide the required data elements for each measure
* Terminology Service - This can be any valid FHIR terminology service that has the appropriate valuesets used in the eCQMs and can provide the expansion of those valuesets
* Receiving System - This would be the system that will receive all of the relevant clinical data for a given eCQM and be able to perform the evaluation of that measure

There are 5 workflows depicted using the swimlanes.

1. Setup - The setup workflow is used by the submitting system to identify what data elements are required for a given measure by calling to the Knowledge Repository to get the data requirements and then getting the appropriate valuesets for the measure from the Terminology Service
2. Attribution/Selection - This workflow determines the attribution for the measure and determines the patients that would be in the initial population that will need to be submitted to the Receiving System
3. Submission - This workflow submits the required data elements per patient for the given measure to the Receiving System. Note that this could also potentially be done using a bulk data operation rather than individual submission calls for each element
4. Evaluation (individual/group) - This workflow represents the actual evaluation of the measure by the Receiving System after it has all the required data elements for the patients and generates the measure report back to the Submitting System
5. Care Gaps - This workflow is the generation of the gaps in care document from the Receiving System back to the Submitting System based on the results of the measure evaluation

{% include img.html img="Data_Element_Submission_Scenario.png" %}

## Capability Statements

This implementation guide defines capability statements, use cases, and conformance requirements for:

* [**Measure Terminology Service**](measure-terminology-service.html)
* [**Measure Repository**](measure-repository-service.html)

## Operations

* [**Library/$package**](OperationDefinition-Library-package.html)
* [**Library/$data-requirements**](OperationDefinition-Library-data-requirements.html)
* [**Measure/$package**](OperationDefinition-Measure-package.html)
* [**Measure/$data-requirements**](OperationDefinition-Measure-data-requirements.html)
* [**MeasureReport/$package**](OperationDefinition-MeasureReport-package.html)
* [**ValueSet/$expand**](OperationDefinition-ValueSet-expand.html)
