{: #capabilities}

The following sequence diagram depicts overall processing for quality improvement data use scenarios. The roles depicted are:

* Data Repository - The clinical data repository for the submitting system. This is typically a FHIR server endpoint for the submitting system's electronic health record (EHR) or system of record, but could also be an HIE or other aggregated data source, depending on the particular submission and reporting requirements.
* Submitting System - This would be either a hospital, physician practice, or any organization that wants to submit the relevant QM data to a receiving system
* Knowledge Repository - This would be a FHIR server that has the QMs loaded and is the source of truth for those QMs and can provide the required data elements for each measure
* Terminology Service - This can be any valid FHIR terminology service that has the appropriate valuesets used in the QMs and can provide the expansion of those valuesets
* Receiving System - This would be the system that will receive all of the relevant clinical data for a given QM and be able to perform the evaluation of that measure

There are 5 workflows depicted using the swimlanes.

1. Setup - The setup workflow is used by the submitting system to identify what data elements are required for a given measure by calling to the Knowledge Repository to get the data requirements and then getting the appropriate valuesets for the measure from the Terminology Service
2. Attribution/Selection - This workflow determines the attribution for the measure and determines the patients that would be in the initial population that will need to be submitted to the Receiving System
3. Submission - This workflow submits the required data elements per patient for the given measure to the Receiving System. Note that this could also potentially be done using a bulk data operation rather than individual submission calls for each element
4. Evaluation (individual/group) - This workflow represents the actual evaluation of the measure by the Receiving System after it has all the required data elements for the patients and generates the measure report back to the Submitting System
5. Care Gaps - This workflow is the generation of the gaps in care document from the Receiving System back to the Submitting System based on the results of the measure evaluation

The Quality Measure IG is focused on the Setup workflow for quality measurement, while the Data Exchange for Quality Measures IG is focused on the Attribution/Selection, Submission, Evaluation, and Care Gaps workflows for quality measurement, reporting, and management.

Note that although the processing depicted here is focused on quality measurement, the steps and processes involved apply generally to any data analytics use case including decision support, case and registry reporting, and population health management.

{% include img.html img="Data_Element_Submission_Scenario.png" %}

## Capability Statements

This implementation guide defines capability statements, use cases, and conformance requirements for:

* [**Measure Terminology Service**](measure-terminology-service.html)
* [**Measure Repository**](measure-repository-service.html)

In addition, the following example capability statement illustrates the use of the [cqfm-supportedCqlVersion](StructureDefinition-cqfm-supportedCqlVersion.html) extension to support advertising the version of CQL supported by the service:

* [**Example Measure Calculation Service**](CapabilityStatement-measure-calculation-service-example.html)

See the capability statements defined in the [Data Exchange for Quality Measures](https://hl7.org/fhir/us/davinci-deqm/) implementation guide for the Submitting and Receiving System roles.
