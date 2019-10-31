#### 1.2.2 Quality Measurement Standards Landscape
{: #quality-measurement-standards-landscape}

This implementation guide is part of a larger FHIR-based quality improvement
and quality measurement standards landscape, depicted in the following
diagram:

<details open>
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