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

### 1.2 Background
{: #background}

#### 1.2.1 Quality Improvement Ecosystem
{: #quality-improvement-ecosystem}

As shown in step 1 in the diagram below, the Quality Improvement Ecosystem
begins with information, preferably evidence-based from research, public health
surveillance, and data mining and other analyses performed by third parties such
as payers. Such information indicates existing status and knowledge about a
given clinical topic. In step 2, stakeholders, such as professional societies,
public health and governmental bodies, and healthcare insurers have various
methods for publishing such information to assure awareness among consumers,
healthcare practitioners, and healthcare organizations about what is known and
suggested methods for managing the clinical topic. Ideally, suggested management
efforts are captured and documented in guidelines based on collaboration among
clinical subject matter experts, terminologists, informaticists, clinicians and
consumers.  In step 3, these clinical guidelines are translated into clinical
decision support (CDS) artifacts to incorporate valuable clinical
recommendations and actions directly within clinical workflow. To adequately
impact clinical care for clinicians and patients requires local implementation
activities as shown in Step 4. Ideally, the clinical guidelines and CDS include
methods for evaluating what successful implementation means, i.e., whether the
clinical care ultimately provided included processes that addressed the intent
of the guideline and if it achieved the desired outcomes. In step 5, to close
the loop and enable continuous improvement, the results of such measurement
analytics must be reported for aggregate review. Step 6, "Reporting" serves the
purpose of evaluating clinical performance and outcomes for healthcare
organizations, for public health and for payers.

<details>
<summary>

<b>Figure 1-1: The Quality Improvement Ecosystem Diagram</b>

</summary>

<img src="assets/images/quality-improvement-ecosystem.png" alt="Quality
Improvement Ecosystem" class="img-responsive img-rounded
center-block"/>

</details>

> Stakeholders such as public health have ongoing needs for
quality improvement at the point of care. Every effort should be made to
establish a capable distributed rule processing environment in FHIR. For
additional information about idealized processes for moving evidence and
information from guidelines to CDS and measurement, refer to an effort by the
Centers for Disease Control and Prevention (CDC) called 
[Adapting Clinical Guidelines for the Digital Age](https://www.cdc.gov/ddphss/clinical-guidelines/index.html).

#### 1.2.2 Quality Measurement Standards Landscape
{: #quality-measurement-standards-landscape}

This implementation guide is part of a larger FHIR-based quality improvement
and quality measurement standards landscape, depicted in the following
diagram:

<details>
<summary>

<b>Figure 1-2: The Quality Measurement Standards Landscape Diagram</b>

</summary>

<img src="assets/images/quality-measurement-standards-landscape.png"
alt="Quality Measurement Standards Landscape" class="img-responsive img-rounded center-block"/>

</details>

The left side of the quality measurement standards landscape diagram depicts
the activities and standards associated with measure specification, while the
right side depicts measure reporting. Stakeholders and the roles they play are
represented by the three rounded rectangles in the foreground. Note that the
lists are representative of typical stakeholders, but that a single stakeholder
may play any or all of the roles in this diagram. For example, an institution
specifying its own measures for internal use would be the Producer, Consumer,
and Specifier.

**Measure specification** involves the end product of the measure
development process, a precisely specified, valid, reliable, and clinically
significant measure specification to support accurate data representation and
capture of quality measures. Clinical quality measures (CQMs) are tools that
help measure and track the quality of health care services provided in care 
delivery environments, including eligible clinicians (ECs), eligible hospitals 
(EHs), and critical access hospitals (CAHs). Measuring and reporting CQMs helps 
to ensure that our health care system is delivering effective, safe, efficient, 
patient-centered, equitable, and timely care. CQMs measure many aspects of 
patient care, including patient and family engagement, patient safety, care 
coordination, public health, population health management, efficient use of 
healthcare resources, and clinical process and effectiveness. For more 
information on the basics of Clinical Quality Measures, see 
[Clinical Quality Measures Basics](https://www.cms.gov/Regulations-and-Guidance/Legislation/EHRIncentivePrograms/ClinicalQualityMeasures.html). 
Before Electronic Health Record (EHR) systems, chart-abstracted CQMs were 
predominant. Modern EHR systems enable electronic CQMs, or eCQMs.

**Measure reporting** involves the data collection and aggregation,
calculation and analytics, and ultimately reporting of quality measures. Measure
reporting may be accomplished in different ways at various levels of the
healthcare delivery system, from individual providers attesting to specific
quality measures as part of federally-regulated healthcare quality initiatives,
to provider organizations reporting to healthcare plans as part of payer quality
improvement activities, to institutions reporting on the quality of their own
healthcare delivery.

Stakeholders in the quality space, represented by the three rounded
rectangles in the foreground of the above diagram, fall into three broad
categories:

1.  **Data Producers** in the diagram represent the various stakeholders
involved in the de novo creation of healthcare data. Date Producers can include
providers and provider systems; patients, care teams, caregivers, and patient
engagement systems; and other related clinical systems such as laboratory,
clinic, and hospital information systems that are primary producers of patient
healthcare information.

2.  **Data Consumers** in the diagram represent the various stakeholders
involved in the consumption and use of healthcare data. Data Consumers can
include data routers and aggregators, payers, health information exchanges and
health integrated networks, as well as public health and other
healthcare-related agencies.

3.  **Specifiers** in the diagram represents the various stakeholders involved
in the specification of quality measures for use in healthcare quality
measurement and reporting. Specifiers can include quality agencies, public
health, and other healthcare-related agencies, industry consortiums concerned
with improving care quality, and clinical professional societies. Specifiers may
also be institutions and clinics using the quality measurement standards to
specify quality measures for use in their own environments and quality
improvement initiatives.

The shaded areas underlying the stakeholders depict the various standards
involved (see [Clinical Quality Framework](https://confluence.hl7.org/display/CQIWC/Clinical+Quality+Framework) 
for more information).

##### 1.2.2.1 Fast Healthcare Interoperability Resources (FHIR)
{: #fast-healthcare-interoperability-resources-(fhir)}

[Fast Healthcare Interoperability Resources](http://hl7.org/fhir), 
or FHIR, is a Health Level 7 (HL7) platform specification for healthcare that 
supports exchange of healthcare information between systems. FHIR is universally 
applicable, meaning that it can be used in a broad variety of implementation 
environments. The platform provides layers of implementation that support 
foundational protocols; base implementation functionality such as conformance 
and terminology; administrative functionality to represent patients, care teams, 
locations, and organizations; healthcare processes including clinical and 
diagnostic information, as well as medication, workflow, and financial; and 
finally, a clinical reasoning layer that provides support for the representation 
of knowledge and reasoning about healthcare.

The quality measurement standards landscape makes use of all these layers of
FHIR: the foundational and implementation layers to define interactions and
profiles; the administrative and process layers to represent the data of
interest for quality measurement; and the clinical reasoning layer to specify
and support evaluation and reporting of quality measures.

##### 1.2.2.2 Clinical Quality Language (CQL)
{: #clinical-quality-language-(cql)}

[Clinical Quality Language](https://cql.hl7.org), or CQL, is an HL7 cross-paradigm specification
that defines a high-level, domain-specific language focused on clinical quality
and targeted for use by measure and decision support artifact authors. In
addition, the specification describes a machine-readable canonical
representation called Expression Logical Model (ELM) targeted at implementations
and designed to facilitate sharing and evaluation of clinical knowledge.

This ability to render clinical knowledge in a high-level human-readable form
as well as an intermediate-level, platform-independent machine-readable form
makes CQL an ideal mechanism for specifying the criteria involved in quality
measures.

##### 1.2.2.3 FHIR Quality Measure Implementation Guide
{: #fhir-quality-measure-implementation-guide}

The FHIR Quality Measure Implementation Guide (this IG) defines conformance
profiles and guidance focused on the specification of quality measures using the
FHIR Measure and Library resources. The IG does not standardize the content of
any particular measure, rather it defines the standard approach to the
representation of that content so that quality measure specifiers can define and
share standardized FHIR-based electronic Clinical Quality Measures (eCQMs).

##### 1.2.2.4 Quality Improvement Core Implementation Guide (QI-Core)
{: #quality-improvement-core-implementation-guide-(qi-core)}

The Quality Improvement Core Implementation Guide, or QI-Core, defines a set
of FHIR profiles with extensions and bindings needed to create interoperable,
quality-focused applications. Importantly, the scope of QI-Core includes both
quality measurement and decision support to ensure that knowledge expressed can
be shared across both domains. QI-Core is derived from US Core, meaning that
where possible, QI-Core profiles are based on US Core to ensure alignment with
and support for quality improvement data within healthcare systems in the US
Realm.

> Note that QI-Core is intended to be a FHIR-based rendering of a 
quality-focused _logical model_ called QUICK (Quality Information and 
Clinical Knowledge). However, the QUICK model is still in development, so the 
QI-Core profiles are currently built directly as a FHIR Implementation Guide. To 
support the goals of the QUICK logical model, the QI-Core implementation guide 
includes an author-focused _view_ of QUICK, the QUICK _logical 
view_. See the [Relationship Between QUICK, the QI-Core Profiles, and FHIR](http://hl7.org/fhir/us/qicore/index.html#relationships)
discussion in the QI-Core implementation guide for more information.

##### 1.2.2.5 Data Exchange for Quality Measures (DEQM)
{: #data-exchange-for-quality-measures-(deqm)}

The Data Exchange for Quality Measures Implementation Guide, or DEQM,
provides a framework that defines conformance profiles and guidance to enable
the exchange of quality information and quality measure reporting (e.g. for
transferring quality information from a health care provider to a payer). The
DEQM expects to use quality measures specified in accordance with the Quality
Measure IG and QI-Core.

#### 1.2.3 Data Model Standards Landscape
{: #data-model-standards-landscape}

The quality improvement ecosystem covers every aspect of the healthcare
delivery system, and needs to be able to represent information across that
entire spectrum. FHIR provides a foundation for representation of this
information in a universally applicable way. In particular cases, more
specificity is required to capture the intended meaning of healthcare
information. As FHIR is more and more broadly adopted, consensus among
participating stakeholders on the use of particular profiles and patterns
enables semantic interoperability for more use cases.

Within the US Realm, US Core profiles comprise this base consensus, and
although it enables a variety of interoperability use cases, the profiles do not
represent all of the requirements for quality improvement. The QI-Core profiles
are derived from US Core and provide this additional functionality.

There are occasional instances where additional specificity or functionality
is required explicitly for quality measurement, or a particular component within
a quality measure. In these cases, additional profiles are defined within the
DEQM, or by stakeholders such as measure developers or implementers. For
example, the Medication Reconciliation Post Discharge measure example included
in this implementation guide references the Healthcare Effectiveness Data and
Information Set (HEDIS) Implementation Guide, which defines profiles specific to
that particular HEDIS measure.

The following diagram depicts this data model standards landscape:

<details>
<summary>

<b>Figure 3: The Data Model Standards Landscape Diagram</b>

</summary>

<img src="assets/images/data-model-standards-landscape.png" alt="Data Model
Standards Landscape" class="img-responsive img-rounded center-block"/>

</details>


As illustrated, FHIR provides the foundation, and sets of profiles are built
on top of FHIR that provide more and more focused use cases by constraining
profiles and extending functionality to cover gaps. While the additional layers
are necessary to represent specific operations and provide space for agreement
among relevant stakeholders, the consensus-based standards development process
is used to suggest changes to the layers below, resulting in an ever-broadening
umbrella of interoperability.

This layering of profiles balances the relative adoption and implementation
maturity of FHIR and the data representation requirements of the use cases
involved, guided by the following principles:

1.  **Avoid proliferation of profiles.** To the extent possible, make
use of existing profiles at the lowest level of the stack, only defining a new
profile if absolutely necessary to express a requirement for a particular use
case that cannot be represented by an existing one.
2.  **Share profiles across measures.** There should not be profiles specific to any particular
measure. Instead, QI Core provides a layer for the expression of quality
improvement requirements across measures and decision support artifacts.
3.  **No terminology-narrowing-only profiles.** Profiles should not be used
to specify only terminology narrowing constraints. The FHIR Clinical Reasoning
module and CQL enable the representation of data requirements for quality
measures and decision support artifacts.
4.  **Promote data-related profiles.** When it becomes necessary to define a data-related profile at the
measurement-specific level (in DEQM or HEDIS for example), steps should be taken
to promote that profile to the broadest consensus group possible.

##### 1.2.3.1 FHIR Version Support
{: #fhir-version-support}

There are three broadly used and fully published versions of the FHIR
specification:

-  **FHIR DSTU2** - This version has broad support among US-based
vendors as it is the basis for the Argonaut profiles. Most major vendors today
support some subset of this version of FHIR
-    **FHIR STU3** - This is
the version that US Core, QI Core, and many other implementation guides are
based on. There is broad vendor support for this version.
-  **FHIR R4** - This is the first normative release of FHIR, including several of the
foundational, conformance, and administrative resources going normative.

The implementation guides in this landscape are currently focused on FHIR
STU3, with the plan to produce R4 versions once the US Core and QI Core profiles
have been updated to R4.

In addition to _what_ data is reported, use cases frequently require the 
communication of _when_, _where_ and _how_ to report. See the 
[Electronic Case Reporting (eCR) implementation guide](http://hl7.org/fhir/us/ecr/2018Sep/design-considerations.html#fhir-design-considerations) 
for a more complete discussion of these design considerations. We are actively 
seeking feedback from implementers how this type of information is currently 
communicated in quality reporting scenarios and when it would be useful to do 
so electronically.
{: .stu-note}

### 1.3 How to read this Guide
{: #how-to-read-this-guide}

This Guide is divided into several pages which are listed at the top of each 
page in the menu bar:

-  **[Home](index.html)**: The home page provides the summary and background 
information for the FHIR Quality Measure Implementation Guide
-  **[Introduction](introduction.html)**: The introduction provides a more detailed 
overview of quality measurement and the background for this guide
-  **[eCQMs](measure-conformance.html)**: This page describes measure representation 
and conformance requirements for eCQMs
-  **[Using CQL](using-cql.html)**: This page covers using Clinical Quality Language 
to author eCQMs
-  **[Examples](examples.html)**: This page provides examples used in the other pages, 
as well as by the Data Exchange for Quality Measures IG
-  **[Profiles](profiles.html)**: This page lists the set of profiles defined for use by eCQMs
-  **[Extensions](extensions.html)**: This page lists the set of extensions defined for use by eCQMs
-  **[Terminology](terminology.html)**: This page lists value sets and code systems defined in this IG
-  **[Glossary](glossary.html)** This page defines terms related to quality measurement.
-  **[Downloads](downloads.html)**: This page provides links to downloadable artifacts for implementations.
-  **[Acknowledgements](acknowledgements.html)**

### 1.4 References
{: #references}

Centers for medicare &amp; medicaid. Clinical Quality Measures Basics. [Online]. Available from: [https://www.cms.gov/Regulations-and-Guidance/Legislation/EHRIncentivePrograms/ClinicalQualityMeasures.html](https://www.cms.gov/Regulations-and-Guidance/Legislation/EHRIncentivePrograms/ClinicalQualityMeasures.html) [Accessed 11 October 2019].

Centers for disease control and prevention. Adapting Clinical Guidelines for the Digital Age. [Online]. Available from: [https://www.cdc.gov/ddphss/clinical-guidelines/index.html](https://www.cdc.gov/ddphss/clinical-guidelines/index.html) [Accessed 11 October 2019].

Health level seven. Clinical Quality Framework - HL7 Clinical Quality Information Work Group Confluence Page. [Online]. Available from: [https://confluence.hl7.org/display/CQIWC/Clinical Quality Framework](https://confluence.hl7.org/display/CQIWC/Clinical%20Quality%20Framework) [Accessed 11 October 2019].
