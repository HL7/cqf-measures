---
layout: default
title: Introduction
---
## 1 Introduction

### 1.1 Purpose

The Institute of Medicine (IOM) defines quality as: “The degree to which health services for individuals and populations increase the likelihood of desired health outcomes and are consistent with current professional knowledge.” [^1] For care quality to be evaluated, it must be standardized and communicated to the appropriate organizations. To that end, this Implementation Guide has been written to provide guidance for authoring electronic Clinical Quality Measures (eCQMs) utilizing the following standards:

* Fast Healthcare Interoperability Resources (FHIR) STU3 [^2]
* Clinical Quality Language (CQL) R1.4 [^3]

Although the specification is based on the 1.4 version of CQL, backwards-compatible future versions of CQL can be used as well. In addition, if necessary, the 1.2 and 1.3 versions of CQL can be used without loss of functionality for this Implementation Guide.

Note that this implementation guide is based on FHIR STU3, as that is the first version with the Clinical Reasoning module, which provides the necessary support for representing and reporting quality measures. Future versions of this implementation guide will address the use of R4 and later versions of FHIR.

Except where noted, material from the base FHIR specification, and in particular the Clinical Reasoning module, is not repeated here.

As features and functionality are identified by this implementation guide that apply more broadly, those features may be promoted to the base FHIR specification.

### 1.2 Structure of this Guide

This implementation guide is structured as follows:

1. Introduction - This section, providing narrative introduction and background material
2. Overview - Provides an overview of quality measurement
3. Measure Components - Provides detailed documentation on how measures are represented
4. Measure Conformance - Provides detailed guidance and conformance requirements for measures
5. Composite Measures - Discusses composite measure calculation and representation approaches
6. Using CQL - Provides guidance and conformance requirements for the use of CQL within measures

In addition, there are appendices for examples, references, acknowledgements, and a glossary.

### 1.3 Structure of this Volume

This implementation guide is divided into 6 chapters. Chapters 2 - 6 describe how to construct a CQL based HQMF document and follow the structure of an HQMF document (metadata, data criteria, population criteria, stratification criteria).

Chapter 1 provides an introduction to this IG, gives a brief history of the IG, describes some of the standards upon which this IG was built, and briefly references other standards and tools present in the ecosystem of which this IG is part.

Chapter 2 provides an overview of HQMF structure, how to reference CQL documents in the HQMF document, and how to specify control variables (measure period).

Chapter 3 describes how to reference codes and valuesets in CQL and the accompanying HQMF. Chapter 4 describes how to construct the dataCriteriaSection of the HQMF document.

Chapter 5 discusses measure scoring types, how to specify population criteria in the HQMF document using CQL, and how to specify measure populations in CQL. There are also sections discussing stratification, inclusion of supplemental data, and defining risk adjustment variables.

Chapter 6 contains a discussion of composite measures and HQMF examples of composite measures.

### 1.4 Audience

The audience for this IG includes software developers of the Measure Authoring Tool (MAT); measure developers who will specify clinical quality measures in HQMF; software developers and implementers who will implement the quality measures specified in HQMF in their institutions or in their vendor products; and local, regional, and national quality reporting agencies who wish to receive and process quality report documents that are based on measures specified in HQMF.

### 1.5 Approach

The approach taken here is consistent with balloted IGs for Clinical Document Architecture (CDA). These publications view the ultimate implementation specification as a series of layered constraints. HQMF itself is a set of constraints on the Health Level Seven (HL7) Reference Information Model (RIM). IGs such as this add constraints to HQMF through conformance statements that further define and restrict the sequence and cardinality of HQMF objects and the vocabulary sets for coded elements.

This IG is STU3 of the CQL-based HQMF Standard for Trial Use (STU). Section 1.8 describes the development of this STU.

### 1.6 Scope

This IG is a conformance profile, as described in the “Refinement and Localization” [^9] section of the HL7 Version 3 Interoperability Standards. The base standard for this IG is the HL7 Health Quality Measures Format. This IG (Volumes 1, 2, and 3) does not describe every aspect of HQMF Release 1 Normative. Rather, it defines constraints on the base HQMF used in a CQL-based HQMF document in the US Realm. Additional optional HQMF elements, not included here, can be included and the result will be compliant with the specifications in this guide.

### 1.7 Conventions

The keywords SHALL, SHALL NOT, SHOULD, SHOULD NOT, MAY and NEED NOT in this document are to be interpreted as described in the HL7 Version 3 Publishing Facilitator’s Guide.

* SHALL: an absolute requirement for the particular element. Where a SHALL constraint is applied to an XML element, that element must be present in an instance but may have an exceptional value (i.e., may have a nullFlavor), unless explicitly precluded. Where a SHALL constraint is applied to an XML attribute, that attribute must be present and must contain a conformant value.

* SHALL NOT: an absolute prohibition against inclusion

* SHOULD/SHOULD NOT: best practice or recommendation. There may be valid reasons to ignore an item, but the full implications must be understood and carefully weighed before choosing a different course

* MAY/NEED NOT: truly optional; can be included or omitted as the author decides with no implications

### 1.8 Background

This Implementation Guide (IG) defines an approach to using CQL with Health Quality Measures Format Release 1 Normative (HQMF) [^4] for defining eCQMs.   This IG is split into three volumes, volume    1 (this volume) contains the instruction on how to use HQMF with CQL, volume 2 describes how to use QDM with CQL, and volume 3 contains all the necessary QDM based HQMF templates for defining a QDM based eCQM.

This Implementation Guide is the successor of the QDM-based HQMF IG R1.4 (Figure 2a) and the CQL- Based HQMF IG R1 STU1 (Figure 2b).

![QDM Based HQMF IG](assets/images/QDMBasedIG.png)

(a) QDM based HQMF IG [^5]

![CQL Based HQMF IG](assets/images/CQLBasedIG.png)

(b) CQL based HQMF IG (this IG)

Figure 2: Relationship between QDM based and CQL based HQMF IG’s.

#### 1.8.1 Clinical Quality Language R1.3

Clinical Quality Language R1.3 (CQL) is an HL7 standard for trial use (STU) [^3]. It is part of the effort to harmonize standards between electronic clinical quality measures (eCQMs) and clinical decision support (CDS). CQL provides the ability to express logic that is human readable yet structured enough for processing a query electronically.

#### 1.8.2 QDM based HQMF IG R1.4

The QDM based HQMF IG R1.4 [^5] published October 2016 described how to construct an HQMF measure using QDM data elements and QDM logic (Figure 2a). That IG was built using QDM version 4.3.

#### 1.8.3 CQL based HQMF IG R1 STU1

The first version of the CQL based HQMF IG was released in September 2015 and was intended to be used in conjunction with the QDM based HQMF R1 IG. Since 2015, the community and the standards have evolved and QDM v5.02 no longer contains expression logic, ceding this functionality to CQL. As such, no stand-alone QDM based HQMF IG will be built upon future versions of QDM starting with QDM v5.02. Rather, this IG is intended to be the sole guide describing how to use QDM, CQL, and HQMF in combination (Figure 2b).

A result of replacing QDM-based logic with CQL is that all QDM logic elements previously encoded in HQMF are replaced with CQL. This means that QDM data criteria specify only the data of interest (e.g. value sets, effective time, properties) for the eCQM, and the previous use of QDM expressions that captured interrelationships between data criteria (such as “starts after end of”) or identified subsets of data (such as min, max, last, and first) are now represented with CQL expressions. This IG documents the full approach in detail starting in Chapter 2.

A separate HL7 initiative will produce an IG that covers the use of Fast Healthcare Interoperability Resources (FHIR), CQL, FHIR Quality Profiles, and other emerging approaches to define eCQMs.

#### 1.8.4 HQMF

HQMF is a structured document markup standard* “…for representing a health quality measure as an electronic document. A quality measure is a quantitative tool to assess the performance of an individual or organization’s performance in relation to a specified process or outcome via the measurement of an action, process, or outcome of clinical care. Quality measures are often derived from clinical guidelines and are designed to determine whether the appropriate care has been provided given a set of clinical criteria and an evidence base.” [^4] [^a]

HQMF defines a header for classification and management of the quality measure as well as important metadata. HQMF also defines a document body that carries the content of the quality measure.

Through standardization of a measure’s structure, metadata, definitions, and logic, the HQMF ensures measure consistency and unambiguous interpretation. A health quality measure encoded in the HQMF format is referred to as an electronic clinical quality measure (eCQM). Standardization of document structure (e.g., sections), metadata (e.g., author, verifier), and definitions (e.g., numerator, initial population) enable a wide range of measures currently existing in a variety of formats to achieve consistency. This formal representation of the clinical, financial, and administrative concepts and logic within an eCQM produce unambiguous interpretation and consistent reporting.

During the past few years, National Quality Forum (NQF), through the Health Information Technology Expert Panel (HITEP), developed the Quality Data Model (QDM) for data representation in quality measures; and HL7 developed the HQMF Release 1 (R1) Draft Standard For Trial Use (DSTU). NQF, working with CMS, applied the QDM to HQMF R1, and implemented this solution in the Measure Authoring Tool (MAT) [^7]. The team did this by creating patterns for each QDM data type and QDM attribute, mapping them to the HL7 Reference Information Model (RIM), and using standard vocabularies. The QDM-based HQMF R1 was further refined (and the HQMF R1 DSTU was extended) in collaboration with measure developers through the eCQM Issues Group (eMIG), a consensus body of eCQM developers and stewards convened by CMS. The resulting QDM-based (extended) HQMF R1 was implemented in the MAT, and served as the basis for the creation of Meaningful Use 2014 eCQMs.

This approach was subsequently standardized in the QDM-based HQMF IG [^5] for the trial version of HQMF R1 STU2 along with the full list of templates for the QDM data types and QDM attributes in Volume 2 of the QDM- based HQMF IG, so that they could meet the needs of Meaningful Use eCQMs, and so that the QDM- based HQMF strategy would be governed by an open HL7 consensus process (as opposed to being driven by the MAT tooling implementation).

#### 1.8.5 HQMF Release 1 Normative vs STU1 vs STU2

HQMF R1 STU1 was balloted in the September 2009 ballot cycle as a DSTU; it was supported by volunteer efforts and through the NQF contract with the US Department of Health and Human Services (HHS) to promote the effective use of EHR systems. The DSTU period for HQMF R1 STU1 was two years.

HQMF R1 STU2 was sponsored by the Center for Clinical Standards and Quality of CMS in partnership with HL7 and the Office of the National Coordinator (ONC). A driver for developing HQMF R1 STU2 was the need to make HQMF more amenable to automated machine processing. ONC’s Standards and Interoperability (S&I) Framework Query Health Technical Workgroup co-hosted project meetings. This IG is developed based on the normative release of HQMF R1 that was published in June of 2017 [^4].

[^a]: HQMF is not an HL7 V3 Clinical Document Architecture (CDA) standard,but is similar to CDA in being a structured document markup standard.

### 1.9 Other Related Tools and Standards

This section describes other tools, standards, and resources related to electronic Clinical Quality Measures.

#### 1.9.1 Quality Data Model

Volume 1 of this IG is intended to be as model agnostic as possible. However, the examples used have incorporated QDM [^2]. Further discussion of incorporating QDM into CQL based HQMF measures is discussed in Volume 2 of this IG.

#### 1.9.2 Relationship to Quality Reporting Document Architecture

Volumes 2 and 3 discuss how to incorporate QDM into CQL based HQMF measures. A standard reporting mechanism for QDM based is the Quality Reporting Document Architecture [^6]. Further discussion of QRDA is available in Volume 2 of this IG.

#### 1.9.3 Measure Authoring Tool

The MAT is a web-based software-authoring tool that measure developers use to create eCQMs [^7]. The authoring tool allows measure developers to create eCQMs in a highly structured format using the QDM and healthcare industry standard vocabularies. The MAT was developed by NQF under a contract with HHS, and has been publicly available through NQF since September 2011. All Meaningful Use Stage 2 measures are authored in MAT to ensure consistency in creating header metadata, population criteria, data criteria, etc. Effective January 2013, CMS assumed ownership of the MAT and has contracted with Health Care Innovation Services, a joint venture between Telligen and Net-Integrated Consulting for the ongoing development, maintenance, and support.

The QDM-based building-block approach to eCQMs, which is described in this IG, was implemented in the MAT. It will be updated in accordance with this guide.

#### 1.9.4 NLM Value Set Authority Center

The Value Set Authority Center (VSAC) [^10] is provided by the National Library of Medicine (NLM), in collaboration with the ONC and CMS. The VSAC currently serves as the authority and central repository for the official versions of value sets that support Meaningful Use eCQMs. Through the VSAC, NLM draws upon the UMLS Metathesaurus and its responsibility as the central coordinating body for clinical terminology standards within the HHS to assure the ongoing validity and accuracy of the value sets. NLM launched the VSAC Authoring Tool on October 31, 2013. Value sets for eCQMs can now be authored directly in VSAC. In addition, direct reference codes can be retrieved from the VSAC for use in eCQMs.

#### 1.9.5 CMS Measures Management System Blueprint

CMS has developed a standardized approach for the development and maintenance of the quality measures it uses in its various quality initiatives and programs. The Measures Management System is composed ofa set of business processes and decision criteria that CMS-funded measure developers follow in the creation, implementation, and maintenance of quality measures. Measures developed following the Measures Management System meet the high standards required by the NQF for consensus endorsement. The full Measures Management System set of business processes and decision criteria are documented and described in A Blueprint for the CMS Measures Management System (the Blueprint). Updates to the Blueprint have been made every year since its first release in 2003.

To support the need of eCQM development, the “Measures Specifications” section was added to Version

8.0 of the Blueprint (August 2011) to guide CMS- contracted measure developers on how to develop and document an eCQM for either a retooled measure or a de novo measure. The “Measure Specifications” section has since gone through several updates and has been evolved to become the “Measure Lifecycle” section with the latest being published on CMS’ website [^8].

#### 1.9.6 HITSC Recommended Vocabularies

In 2012, the Health IT Standards Committee (HITSC) Clinical Quality Technology Workgroup and Vocabulary Task Force of the ONC published their recommendations for the use of vocabulary standards by measure developers. The list of QDM categories and their applicable HITSC recommended vocabulary standards are included in the Blueprint’s “Measure Lifecycle” section.


## References

[^1]: Crossing   the   Quality   Chasm:   A   New   Health   System   for   the   21st   Century.   Institute    of Medicine, March 2001. <http://www.nationalacademies.org/hmd/Reports/2001/Crossing-the-Quality-Chasm-A-New-Health-System-for-the-21st-Century.aspx>

[^2]: Quality Data Model, Version 5.4. Centers of Medicare & Medicaid Services; Office of the National Coordinator for Health Information Technology, 2017. <https://ecqi.healthit.gov/qdm>

[^3]: Clinical Quality Language (CQL), STU R1.3. HL7, July 2018. <http://www.hl7.org/implement/standards/product_brief.cfm?product_id=400>

[^4]: HL7, Representation of the Health Quality Measures Format (HQMF) Release 1. HL7, June 2017. <http://www.hl7.org/implement/standards/product_brief.cfm?product_id=97>

[^5]: HL7 Version 3 Implementation Guide: Quality Data Model (QDM)-based Health Quality Measure Format (HQMF), R1.4 – US Realm, Volume 2 (Draft Standard for Trial Use). HL7, October 2016. <http://www.hl7.org/implement/standards/product_brief.cfm?product_id=346>

[^6]: HL7 Implementation Guide for CDA Release 2: Quality Reporting Document Architecture – Category I STU Release 5 (US Realm). HL7, ballot cycle September 2017. <http://www.hl7.org/implement/standards/product_brief.cfm?product_id=35>

[^7]: Measure Authoring Tool. CMS. <https://www.emeasuretool.cms.gov/>

[^8]: Measures Management System Blueprint v13.0. CMS, May 2017. <https://www.cms.gov/Medicare/Quality-Initiatives-Patient-Assessment-Instruments/MMS/MMS-Blueprint.html>

[^9]: Refinement, Constraint and Localization, Release 2. HL7, September 2015. <http://www.hl7.org/v3ballotarchive_temp_52E32C7C-1C23-BA17-0CA99EC07A928F9D/v3ballot/html/infrastructure/conformance/conformance.html>

[^10]: Value Set Authority Center. U.S. National Library of Medicine. <https://vsac.nlm.nih.gov/>
