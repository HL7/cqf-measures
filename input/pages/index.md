

{:toc}

{:.stu-note}
> This STU 5.0.0-ballot is currently dependent on the QI-Core STU 6.0.0-ballot, but will update to QI-Core STU6 once published

Where possible, new and updated content are highlighted with green text and background
{: .new-content}

<div class="note-to-balloters" markdown="1">
#### Note To Balloters

1. We are seeking examples of non-patient subject composite measures for inclusion as examples in this implementation guide.

2. We are requesting additional guidance on MeasureImprovementNotation:

    Reviewers: CQI will be adding the code:

    `Reference range` with definition of score within a defined interval (or a “passing score” over or under a certain threshold) indicates better quality to the improvement notation value set. Please provide comments on this additional code and if there are other codes needed in this value set.

    If an additional code is added to the improvement notation (like normative reference range as suggested), where is guidance about the reference range best included in the specification for implementer use?  Some suggestions include: the guidance field, the rate aggregation field or adding an extension to improvementNotation to add text.

    [valueset: MeasureImprovementNotation](https://terminology.hl7.org/5.2.0/ValueSet-measure-improvement-notation.html)

</div>

<div markdown="1" class="bg-info">

{{ site.data.package-list.list[0].desc }}

</div>



## Quality Measure Implementation Guide
{: #quality-measure-implementation-guide}

### Summary
{: #summary}

The Fast Healthcare Interoperability Resource (FHIR) Quality Measure Implementation Guide (QM IG), describes an approach to representing Quality Measures (QMs) using the FHIR Clinical Reasoning Module and Clinical Quality Language (CQL) in the US Realm. However, this Implementation Guide can be usable for multiple use cases across domains, and much of the content is likely to be relevant outside the US Realm.

This IG is built upon on [FHIR Version R4](http://hl7.org/fhir/R4/index.html) and accounts for content in previous generations of QM standards, the HL7 V3-based Health Quality Measure Format (HQMF) and accompanying implementation guides using FHIR. As an HL7 FHIR Implementation Guide, changes to this specification are managed by the sponsoring Clinical Quality Information Work Group and are incorporated as part of the standard balloting process.

#### Examples
{: #examples}

Refer to the [QI-Core implementation guide](http://hl7.org/fhir/us/qicore) for examples of how to represent data involved in calculation of quality measures.

### How to read this Guide
{: #how-to-read-this-guide}

This Guide is divided into several pages which are listed at the top of each
page in the menu bar:

-  **[Home](index.html)**: The home page provides the summary and background information for the FHIR Quality Measure Implementation Guide.
-  **[Introduction](introduction.html)**: The introduction provides a more detailed overview of quality measurement and the background for this guide.
-  **[QMs](measure-conformance.html)**: This page describes measure representation and conformance requirements for QMs.
-  **[Using CQL](using-cql.html)**: This page covers using Clinical Quality Language to author QMs.
-  **[Composites](composite-measures.html)**: This page covers composite measure representation and conformance requirements.
-  **[Packaging](packaging.html)**: This page describes measure packaging and distribution requirements for QMs.
Measures IG

- **FHIR Artifacts**
  - **[Profiles](profiles.html)**: This page lists the set of profiles defined for use by QMs
  - **[Extensions](extensions.html)**: This page lists the set of extensions defined for use by QMs
  - **[Terminology](terminology.html)**: This page lists value sets and code systems defined in this IG
  - **[Capabilities](capabilities.html)**: This page defines the workflows and roles for QMs and contains the capability statements
  - **[Operations](operations.html)**: This page defines services and operations in support of authoring, publishing, and distributing QMs
  - **[Artifacts Summary](artifacts.html)**: This page defines the workflows and roles for QMs and contains the capability statements

-  **[Examples](examples.html)**: This page provides examples used in the other pages, as well as by the Data Exchange for Quality.
-  **[Glossary](glossary.html)** This page defines terms related to quality measurement.
-  **[Downloads](downloads.html)**: This page provides links to downloadable artifacts for implementations.
-  **[Changes](changes.html)**: This page details changes made in each version of the Quality Measure IG

### Background
{: #background}

<!-- Quality Improvement Ecosystem -->
{% include quality-improvement-ecosystem.md %}

<!-- Quality Measurement Standards Landscape -->
{% include quality-measurement-standards-landscape.md %}

<!-- Data Model Standards Landscape -->
{% include data-model-standards-landscape.md %}

### References
{: #references}

Centers for Medicare &amp; Medicaid. Clinical Quality Measures Basics. [Online]. Available from: [https://www.cms.gov/Regulations-and-Guidance/Legislation/EHRIncentivePrograms/ClinicalQualityMeasures.html](https://www.cms.gov/Regulations-and-Guidance/Legislation/EHRIncentivePrograms/ClinicalQualityMeasures.html) [Accessed 11 October 2019].

Centers for disease control and prevention. Adapting Clinical Guidelines for the Digital Age. [Online]. Available from:  [https://www.cdc.gov/csels/phio/clinical-guidelines/index.html](https://www.cdc.gov/csels/phio/clinical-guidelines/index.html) [Accessed 11 October 2019].

Health level seven. Clinical Quality Framework - HL7 Clinical Quality Information Work Group Confluence Page. [Online]. Available from: [https://confluence.hl7.org/display/CQIWC/Clinical Quality Framework](https://confluence.hl7.org/display/CQIWC/Clinical%20Quality%20Framework) [Accessed 11 October 2019].

### Dependencies
The dependency on QI-Core is included for the purposes of example validation only.  In addition the dependency on VSAC packages is indirect via the QI Core and US Core.  The conformance profiles in this IG do not make use of the value sets in VSAC.

{% include dependency-table.xhtml %}

### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

### Global Profiles

{% include globals-table.xhtml %}

### IP Statements

{% include ip-statements.xhtml %}
