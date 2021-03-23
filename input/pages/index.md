---
layout: default
title: Home
---

---

<!-- TOC  the css styling for this is \pages\assets\css\project.css under 'markdown-toc'-->

* Do not remove this line (it will not be displayed)
{:toc}

## 1 Quality Measure Implementation Guide
{: #quality-measure-implementation-guide}

### 1.1 Summary
{: #summary}

The Fast Healthcare Interoperability Resource (FHIR) Quality Measure Implementation Guide (this IG) describes an approach to representing electronic Clinical Quality Measures (eCQMs) using the FHIR Clinical Reasoning Module and Clinical Quality Language (CQL) in the US Realm. However, this Implementation Guide can be usable for multiple use cases across domains, and much of the content is likely to be usable outside the US Realm.

The implementation guide is based upon the previous generation of eCQM representation standards, the HL7 V3-based Health Quality Measure Format (HQMF) and accompanying implementation guides. As an HL7 FHIR Implementation Guide, changes to this specification are managed by the sponsoring Clinical Quality Information Work Group and are incorporated as part of the standard balloting process.

### 1.1.1 Examples
{: #examples}

Refer to the [QI-Core implementation guide](http://build.fhir.org/ig/cqframework/qi-core) for examples of how to represent data involved in calculation of quality measures.

### 1.2 How to read this Guide
{: #how-to-read-this-guide}

This Guide is divided into several pages which are listed at the top of each
page in the menu bar:

-  **[Home](index.html)**: The home page provides the summary and background information for the FHIR Quality Measure Implementation Guide
-  **[Introduction](introduction.html)**: The introduction provides a more detailed overview of quality measurement and the background for this guide
-  **[eCQMs](measure-conformance.html)**: This page describes measure representation and conformance requirements for eCQMs
-  **[Using CQL](using-cql.html)**: This page covers using Clinical Quality Language to author eCQMs
-  **[Composites](composite-measures.html)**: This page covers composite measure representation and conformance requirements
-  **[Packaging](packaging.html)**: This page describes measure packaging and distribution requirements for eCQMs
Measures IG
-  **[Profiles](profiles.html)**: This page lists the set of profiles defined for use by eCQMs
-  **[Extensions](extensions.html)**: This page lists the set of extensions defined for use by eCQMs
-  **[Terminology](terminology.html)**: This page lists value sets and code systems defined in this IG
-  **[Capabilities](capabilities.html)**: This page defines services and operations in support of authoring, publishing, and distributing eCQMs
-  **[Examples](examples.html)**: This page provides examples used in the other pages, as well as by the Data Exchange for Quality
-  **[Glossary](glossary.html)** This page defines terms related to quality measurement.
-  **[Downloads](downloads.html)**: This page provides links to downloadable artifacts for implementations.
-  **[Acknowledgements](acknowledgements.html)**

### 1.3 Background
{: #background}

<!-- 1.3.1 Quality Improvement Ecosystem -->
{% include quality-improvement-ecosystem.md %}

<!-- 1.3.2 Quality Measurement Standards Landscape -->
{% include quality-measurement-standards-landscape.md %}

<!-- 1.3.3 Data Model Standards Landscape -->
{% include data-model-standards-landscape.md %}

### 1.4 References
{: #references}

Centers for medicare &amp; medicaid. Clinical Quality Measures Basics. [Online]. Available from: [https://www.cms.gov/Regulations-and-Guidance/Legislation/EHRIncentivePrograms/ClinicalQualityMeasures.html](https://www.cms.gov/Regulations-and-Guidance/Legislation/EHRIncentivePrograms/ClinicalQualityMeasures.html) [Accessed 11 October 2019].

Centers for disease control and prevention. Adapting Clinical Guidelines for the Digital Age. [Online]. Available from: [https://www.cdc.gov/ddphss/clinical-guidelines/index.html](https://www.cdc.gov/ddphss/clinical-guidelines/index.html) [Accessed 11 October 2019].

Health level seven. Clinical Quality Framework - HL7 Clinical Quality Information Work Group Confluence Page. [Online]. Available from: [https://confluence.hl7.org/display/CQIWC/Clinical Quality Framework](https://confluence.hl7.org/display/CQIWC/Clinical%20Quality%20Framework) [Accessed 11 October 2019].
