---
layout: default
title: Introduction
---
## 1 Introduction

### 1.1 Purpose

The National Academy of Medicine (IOM) defines quality as: “The degree to which health services for individuals and populations increase the likelihood of desired health outcomes and are consistent with current professional knowledge.” [^1] For care quality to be evaluated, it must be standardized and communicated to the appropriate organizations. To that end, this Implementation Guide has been written to provide guidance for authoring electronic clinical quality measures (eCQMs), clinical quality measures specified in a standard electronic format and designed to use structured, encoded data present in the electronic health record.[^12] This implementation guide references the following standards for creating eCQMs:

* Fast Healthcare Interoperability Resources (FHIR) STU3 [^2]
* Clinical Quality Language (CQL) R1.4 [^3]
* QI-Core Implementation Guide (QI-Core) R3.2 [^11]

To avoid variation in the use of FHIR Resources and metadata consistently across eCQMs and clinical decision support (CDS), a quality-related implementation guide based on a logical data model is essential. In the US Realm, eCQM developers should use FHIR Quality Improvement Core (QICore) and Quality Improvement Clinical Knowledge (QUICK) as the data model to maintain consistency.

Although the specification is based on the 1.4 version of CQL, backwards-compatible future versions of CQL can be used as well. In addition, if necessary, the 1.2 and 1.3 versions of CQL can be used without loss of functionality for this Implementation Guide.

Note that this implementation guide is based on FHIR STU3, as that is the first version with the Clinical Reasoning module, which provides the necessary support for representing and reporting quality measures. Future versions of this implementation guide will address the use of R4 and later versions of FHIR.

Except where noted, material from the base FHIR specification, and in particular the Clinical Reasoning module, is not repeated here.

As features and functionality are identified by this implementation guide that apply more broadly, those features may be promoted to the base FHIR specification.

### 1.2 Structure of this Guide

This implementation guide is structured as follows:

1. Introduction - This section, providing narrative introduction and background material
2. Overview - Provides an overview of quality measurement
3. Measure Conformance - Provides detailed guidance and conformance requirements for measures
4. Composite Measures - Discusses composite measure calculation and representation approaches
5. Using CQL - Provides guidance and conformance requirements for the use of CQL within measures

In addition, there are appendices for examples, references, acknowledgements, and a glossary.

### 1.3 Structure of this Volume

// TODO: UPDATE THIS SECTION

This implementation guide is divided into 6 chapters. Chapters 2 - 6 describe how to construct a CQL based HQMF document and follow the structure of an HQMF document (metadata, data criteria, population criteria, stratification criteria).

Chapter 1 provides an introduction to this IG, gives a brief history of the IG, describes some of the standards upon which this IG was built, and briefly references other standards and tools present in the ecosystem of which this IG is part.

Chapter 2 provides an overview of FHIR Clinical Reasoning structure, how to use CQL libraries within the FHIR-based measure, and how to specify control variables (measure period).

Chapter 3 describes how to reference terminology (codes and valuesets) in CQL and the accompanying FHIR-based measure. 

Chapter 4 describes how to construct the CQL to reference libraries, definitions, and terminology in the FHIR-based measure.

Chapter 5 discusses measure scoring types, how to specify population criteria in the FHIR-based measure document, and how to specify measure populations in CQL. There are also sections discussing stratification, inclusion of supplemental data, and defining risk adjustment variables.

Chapter 6 contains a discussion of composite measures and FHIR-based examples of composite measures.

### 1.4 Audience

The audience for this IG includes software developers of measure authoring tools such as the US Centers for Medicare and Medicaid Services (CMS) Measure Authoring Tool (MAT); measure developers who will specify clinical quality measures using FHIR and CQL; software developers and implementers who will implement the quality measures specified in FHIR and CQL in their institutions or in their vendor products; institutions and organizations who wish to use FHIR and CQL to express and implement quality measures within their health systems; and local, regional, and national quality reporting agencies who wish to receive and process quality reporting documents that are based on measures specified in FHIR and CQL.

### 1.5 Approach

The approach taken here is consistent with balloted IGs for FHIR. These publications view the ultimate implementation specification as a set of formal artifacts, including profiles, extensions, and terminologies. The base FHIR specification provides for the representation of quality measures using the Measure resource, as well as guidance on quality reporting within the Clinical Reasoning module. IGs such as this add constraints to the base resources and guidance through profiles and conformance requirements that further define and restrict the sequence and cardinality of elements in the FHIR resources and the vocabulary sets for coded elements.

This IG is STU1 of the FHIR Quality Measure IG. Section 1.8 describes the development of this STU.

### 1.6 Scope

This IG is a conformance profile, as described in the “Conformance” [^9] section of the HL7 FHIR specification. The base resource for this IG is the HL7 FHIR Measure and Library resources and associated guidance within the Clinical Reasoning module. This IG does not describe every aspect of quality reporting in FHIR. Rather, it defines profiles and constraints on the base Measure and Library resources used in a FHIR Quality Measure. Additional optional Measure and Library elements, not included here, can be included and the result will be compliant with the specifications in this guide. The FHIR Clinical Reasoning module provides resources and universally applicable guidance for reporting quality measurement results, and the Data Exchange for Quality Measures Implementation Guide [^13] provides additional guidance and use cases related to quality reporting.

### 1.7 Conventions

The keywords SHALL, SHALL NOT, SHOULD, SHOULD NOT, MAY, and NEED NOT in this document are to be interpreted as defined in RFC 2119. Unlike RFC 2119, however, this specification allows that different applications may not be able to interoperate because of how they use optional features. In particular

* SHALL: an absolute requirement for all implementations
* SHALL NOT: an absolute prohibition against inclusion for all implementations
* SHOULD/SHOULD NOT: a best practice or recommendation to be considered by implementers within the context of their particular implementation; there may be valid reasons to ignore an item, but the full implications must be understood and carefully weighed before choosing a different course
* MAY/NEED NOT: truly optional; can be included or omitted as the implementer decides with no implications

### 1.8 Background

TODO: Update diagram to say QI-Core, not FHIR QUICK
TODO: Add documentation about QUICK as an author-focused view of QI-Core

QDM -> QUICK
HQMF/QRDA QDM-Based Templates -> QI-Core

Relationship between QI-Core and QRDA

This Implementation Guide (IG) defines an approach to using CQL with the FHIR Measure and Library resources for specifying quality measures. The guidance here is drawn from the FHIR Clinical Reasoning Module [^4], as well as the CQL-Based HQMF IG.

This Implementation Guide is the successor of the CQL-based HQMF IG STU4 (Figure 2a).

![Relationship between CQL-based and FHIR-based IG's](assets/images/RelationshipToCQLBasedHQMFIG.png)

Figure 2: Relationship between QDM based and CQL based HQMF IG’s.

#### 1.8.1 Clinical Quality Language R1.4

Clinical Quality Language R1.4 (CQL) is an HL7 standard for trial use (STU) [^3]. It is part of the effort to harmonize standards between electronic clinical quality measures (eCQMs) and clinical decision support (CDS). CQL provides the ability to express logic that is human readable yet structured enough for processing a query electronically.

#### 1.8.2 CQL based HQMF IG R1 STU3

The first version of the CQL-based HQMF IG was released in September 2015 and was intended to be used in conjunction with the pre-existing QDM based HQMF R1 IG. Since 2015, the community and the standards evolved and the current version of QDM (v5.4) no longer contains expression logic, ceding this functionality to CQL. The CQL-based HQMF IG is the sole guide describing how to use QDM, CQL, and HQMF in combination (Figure 2a).

A result of replacing QDM-based logic with CQL is that all QDM logic elements previously encoded in HQMF were replaced with CQL. This means that QDM data criteria specify only the data of interest (e.g. value sets, effective time, properties) for the eCQM, and the previous use of QDM expressions that captured interrelationships between data criteria (such as “starts after end of”) or identified subsets of data (such as min, max, last, and first) are now represented with CQL expressions. This IG documents the full approach in detail starting in Chapter 2.

This implementation guide, the FHIR Quality Measure IG, covers the use of FHIR, CQL, FHIR QI-Core and QUICK, and other emerging approaches to define eCQMs.

#### 1.8.3 HQMF

HQMF is a structured document markup standard* “…for representing a health quality measure as an electronic document. A quality measure is a quantitative tool to assess the performance of an individual or organization’s performance in relation to a specified process or outcome via the measurement of an action, process, or outcome of clinical care. Quality measures are often derived from clinical guidelines and are designed to determine whether the appropriate care has been provided given a set of clinical criteria and an evidence base.” [^4] [^a]

HQMF is now a normative HL7 V3 based standard that defines a header for classification and management of the quality measure as well as important metadata. HQMF also defines a document body that carries the content of the quality measure. It standardizes a measure’s structure, metadata, definitions, and logic, the HQMF ensures measure consistency and unambiguous interpretation.

#### 1.8.4 HQMF Release 1 Normative vs STU1 vs STU2

HQMF R1 STU1 was balloted in the September 2009 ballot cycle as a DSTU; it was supported by volunteer efforts and through the NQF contract with the US Department of Health and Human Services (HHS) to promote the effective use of EHR systems. The DSTU period for HQMF R1 STU1 was two years.

HQMF R1 STU2 was sponsored by the Center for Clinical Standards and Quality of CMS in partnership with HL7 and the Office of the National Coordinator (ONC). A driver for developing HQMF R1 STU2 was the need to make HQMF more amenable to automated machine processing. ONC’s Standards and Interoperability (S&I) Framework Query Health Technical Workgroup co-hosted project meetings. This IG is developed based on the normative release of HQMF R1 that was published in June of 2017 [^4].

The FHIR Clinical Reasoning module replaces HQMF by defining the quality measure structure.

[^a]: HQMF is not an HL7 V3 Clinical Document Architecture (CDA) standard, but is similar to CDA in being a structured document markup standard.

## References

[^1]: Crossing   the   Quality   Chasm:   A   New   Health   System   for   the   21st   Century.   Institute    of Medicine, March 2001. <http://www.nationalacademies.org/hmd/Reports/2001/Crossing-the-Quality-Chasm-A-New-Health-System-for-the-21st-Century.aspx>

[^2]: Quality Data Model, Version 5.4. Centers of Medicare & Medicaid Services; Office of the National Coordinator for Health Information Technology, 2017. <https://ecqi.healthit.gov/qdm>

[^3]: Clinical Quality Language (CQL), STU R1.4. HL7, July 2018. <http://www.hl7.org/implement/standards/product_brief.cfm?product_id=400>

[^4]: HL7, Representation of the Health Quality Measures Format (HQMF) Release 1. HL7, June 2017. <http://www.hl7.org/implement/standards/product_brief.cfm?product_id=97>

[^5]: HL7 Version 3 Implementation Guide: Quality Data Model (QDM)-based Health Quality Measure Format (HQMF), R1.4 – US Realm, Volume 2 (Draft Standard for Trial Use). HL7, October 2016. <http://www.hl7.org/implement/standards/product_brief.cfm?product_id=346>

[^6]: HL7 Implementation Guide for CDA Release 2: Quality Reporting Document Architecture – Category I STU Release 5 (US Realm). HL7, ballot cycle September 2017. <http://www.hl7.org/implement/standards/product_brief.cfm?product_id=35>

[^7]: Measure Authoring Tool. CMS. <https://www.emeasuretool.cms.gov/>

[^8]: Measures Management System Blueprint v14.0. CMS, September 2018. <https://www.cms.gov/Medicare/Quality-Initiatives-Patient-Assessment-Instruments/MMS/MMS-Blueprint.html>

[^9]: Conformance, Fast Healthcare Interoperability Resources, Conformance module, STU3, April 2017. <http://hl7.org/fhir/STU3/conformance-module.html>

[^10]: Value Set Authority Center. U.S. National Library of Medicine. <https://vsac.nlm.nih.gov/>

[^11]: QI-Core Implementation Guide, STU 3.2. HL7, February 2019. <http://hl7.org/fhir/us/qicore/> 

[^12]: eCQM definition – The Joint Commission: <https://www.jointcommission.org/about/jointcommissionfaqs.aspx?CategoryId=56#2404>

[^13]: Data Exchange for Quality Measures Implementation Guide, STU 2. HL7, February 2019. <http://build.fhir.org/ig/HL7/davinci-deqm/>

[^14]: FHIR Clinical Reasoning Module, STU3. HL7, April 2017. <http://hl7.org/fhir/STU3/clinicalreasoning-module.html>