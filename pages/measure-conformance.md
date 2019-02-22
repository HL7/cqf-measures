---
layout: default
title: Measure Conformance
---
## 2 HQMF Basics

In FHIR, an eCQM is represented as a Measure resource containing metadata (the rest of this section) and terminology (Section 3), a population criteria section (Section 5), and at least one Library resource containing a data criteria section (Section 4) as well as the logic used to define the population criteria. The population criteria section typically contains initial population criteria, denominator criteria, and numerator criteria sub-components, among others. Snippet 1 shows the structure of a FHIR Measure.

```xml
<Measure>
  <!-- metadata for the measure - snipped for brevity -->
  <library>
    <reference value="Library/library-exm-logic"/>
  </library>
  <group>
    <population>
      <code><coding><code value="initial-population"/></coding></code>
      <criteria value="Initial Population"/>
    </population>
    <population>
      <code><coding><code value="denominator"/></coding></code>
      <criteria value="Denominator"/>
    </population>
    <population>
      <code><coding><code value="numerator"/></coding></code>
      <criteria value="Numerator"/>
    </population>
  </group>
</Measure>
```

Snippet 1: FHIR Measure structure - abridged for clarity (from sample [Measure-measure-exm.xml](Measure-measure-exm.html))

### 2.1 Metadata

// TODO: Review and update?
The header of an eCQM document identifies and classifies the document and provides important metadata about the measure. The Blueprint includes a list of header data elements that are specified by CMS for use by all CMS measure contractors. The Blueprint header requirements have been implemented in the Meaningful Use 2014 eCQMs and all subsequent annual updates. This IG further constrains the header in the base HQMF standard by including the Blueprint header requirements. Details are as shown in Volume 3 of this IG package.

The rest of this section describes some of the more important components to the header, such as “Related Documents” (Section 2.2), “Control Variables” (Section 2.3), and “Data Criteria” (Section 4).

### 2.2 Related Documents

Clinical Quality Language R1.4 [^3] can be used in conjunction with the FHIR Measure resource to construct CQL-based quality measures. CQL is a domain specific language used in the Clinical Quality and Clinical Decision Support domains. Measures written in CQL leverage the expressivity and computability of CQL to define the population criteria used in the eCQM.

Any included CQL library must contain a library declaration line as its first line as in Snippet 2.

```cql
library EXM146_FHIR version '4.0.0'
```

Snippet 2: Library declaration line from [EXM146_FHIR-4.0.0.cql](cql/EXM146_FHIR-4.0.0.cql)

When using multiple CQL libraries to define a measure, refer to the “Nested Libraries” section of the Using CQL topic of this guide.

Inclusion of CQL into a FHIR eCQM is accomplished through the use of a Library resource as shown in Snippet 3. These libraries are then incorporated into the FHIR eCQM using the `library` element of the Measure (line: 3 of Snippet 1). CQL library content is included as the `content` element of the Library resource.

// TODO: Restrict to base64 encoded content or allow by reference?

Lines 21–32 in Snippet 3 identify a CQL expression document (EXM146v4 CQL.cql) and assign an internal root identifier to it (22688A59-B73C-4276-9E83-778214E1CA3C). This identifier is later used when referencing CQL expressions from HQMF population criteria. In addition, a global, version-independent identifier for the library is specified using the setId element. The root attribute of this element defines a globally unique namespace for the library, and the extension attribute specifies a stable, version-independent identifier for the library. If this identifier is not the same as the name of the library, then the identifierName attribute can be used to provide a human readable identifier. If the library has a version specified, the versionNumber element is used as well.

    Conformance Requirement 1 (Referencing CQL Documents):
    Measures utilizing CQL libraries SHALL include exactly 1 expressionDocument element per CQL library refenced in the HQMF.
    Libraries implicitly referenced through nesting of libraries MAY be included.
    The expressionDocument element SHALL contain a child text element that SHALL have a mediaType attribute value of text/cql and SHALL include a child reference element whose value contains an absolute URI that identifies the CQL expression document. This URI SHALL be constructed using the setID for the library.
    Any referenced CQL library SHALL contain a library declaration line.
    The library declaration line SHALL be the first line in the library.
    The expressionDocument element SHALL contain a setID element with a root element that provides a globally unique namespace identifier for libraries, and an extension attribute specifying a stable, version-independent identifier for the library.
    If the setID element is not the same as the name of the CQL library, the identifierName element SHOULD be used to provide a human-readable identifier.
    If the library is versioned, the expressionDocument element SHALL contain a versionNumber element with a value attribute specifying the version of the library as defined in the CQL library declaration

```xml
<relatedDocument typeCode="COMP">
    <expressionDocument>
        <id root="22688A59-B73C-4276-9E83-778214E1CA3C" />
        <text mediaType="text/cql">
            <reference value="http://example.org/ecqms/libraries/AD01B04B-4534-40E5-B3B4-CCC210450441/EXM146v4 CQL.cql" />
            <translation mediaType="application/elm+xml">
                <reference value="http://example.org/ecqms/libraries/AD01B04B-4534-40E5-B3B4-CCC210450441/EXM146v4 ELM.xml" />
            </translation>
            <translation mediaType="application/elm+json">
                <reference value="http://example.org/ecqms/libraries/AD01B04B-4534-40E5-B3B4-CCC210450441/EXM146v4 ELM.json" />
            </translation>
        </text>
        <setId root="http://example.org/ecqms/libraries/" extension="AD01B04B-4534-40E5-B3B4-CCC210450441" identifierName="EXM146" />
        <versionNumber value="4.0.0" />
    </expressionDocument>
</relatedDocument><relatedDocument>
    <expressionDocument>
        <id root="22688A59-B73C-4276-9E83-778214E1CA3D" />
        <text mediaType="text/cql">
            <reference value="http://example.org/ecqms/libraries/24B11242-A658-44B6-93F7-83DDE04F9677/Common-2.0.0 CQL.cql" />
            <translation mediaType="application/elm+xml">
                <reference value="http://example.org/ecqms/libraries/24B11242-A658-44B6-93F7-83DDE04F9677/Common-2.0.0 ELM.xml" />
            </translation>
            <translation mediaType="application/elm+json">
                <reference value="http://example.org/ecqms/libraries/24B11242-A658-44B6-93F7-83DDE04F9677/Common-2.0.0 ELM.json" />
            </translation>
        </text>
        <setId root="http://example.org/ecqms/libraries/" extension="24B11242-A658-44B6-93F7-83DDE04F9677" identifierName="Common" />
        <versionNumber value="2.0.0" />
    </expressionDocument>
</relatedDocument>
```

Snippet 3: Example CQL Library (from EXM146v4 eCQM.xml)

Inclusion of CQL libraries within the HQMF framework must conform to Conformance Requirement 1.

#### 2.2.1 Including ELM

CQL defines both a human-readable text representation and a machine-oriented XML representation called the Expression Logical Model (ELM). The human-readable text representation is optimized for authoring while the ELM XML representation offers a canonical, simplified representation that is easier to implement in software. Any CQL expression can be directly translated to its ELM equivalent. Measure authors do not work with ELM directly; rather authoring tools convert CQL to the ELM representation for distribution.

Both CQL and ELM representations should be referenced from the HQMF to follow the HL7 V3 approach of supporting human readability at a minimum (in this case, the high-level CQL syntax) and a canonical representation for machine processing (in this case, CQL’s Expression Logical Model (ELM)). This approach supports easy human review of measure logic via CQL and easy implementation of that logic in tools via ELM.

    Conformance Requirement 2 (Referencing ELM Documents):
    Any expressionDocument/text elements that reference a CQL document SHOULD include a translation element that includes a child reference element whose value contains an absolute URI that identifies an Expression Logical Model (ELM) expression document, constructed using the setId for the library.
    If an ELM translation is provided, both an XML and JSON representation of the ELM SHOULD
    be included.
    The XML representation of the ELM SHALL have a mediaType attribute value of
    application/elm+xml
    The JSON representation of the ELM SHALL have a mediaType attribute value of
    application/elm+json
    Any translation-referenced ELM documents SHALL be semantically equivalent to the corresponding parent CQL expression document.

Lines 25–30 of Snippet 3 shows an example of how an HQMF document would reference both the CQL and the ELM. More on ELM can be found in Chapter 4.1. For examples of ELM using the XML and JSON representations please see the included examples, EXM146v4 ELM.xml and
EXM146v4 ELM.json.

### 2.3 Control Variables

HQMF introduces the concept of control variables as metadata that influences the computation of measures. Currently HQMF defines only one control variable: the measurement period, see §4.1.3.12 of HQMF [4]. Snippet 4 demonstrates how to indicate a controlVariable in the HQMF (line: 2 of Snippet 1).

The values of HQMF control variables are accessible to CQL libraries as CQL parameters. The HQMF measurement period control variable is accessible to CQL libraries as the value of a parameter called "Measurement Period". Snippet 5 shows an example of a CQL library declaring this parameter.

```xml
<controlVariable>
    <measurePeriod>
        <code code="MSRTP" codeSystem="2.16.840.1.113883.3.560">
            <displayName value="Measurement Period" />
        </code>
        <value xsi:type="PIVL_TS">
            <phase lowClosed="true" highClosed="true">55
                <low value="201201010000" />
                <high value="201212312359" />
                <width xsi:type="PQ" value="1" unit="a" />
            </phase>
        </value>
    </measurePeriod>
</controlVariable>
```

Snippet 4: HQMF representation of control variables from (EXM146v4 eCQM.xml)

```cql
parameter "Measurement Period" Interval<DateTime>
```

Snippet 5: CQL declaration of the measurement period parameter (from EXM146v4 CQL.cql)

    Conformance Requirement 3 (HQMF Measurement Period):
    The value of the HQMF measurement period control variable SHALL be made available to CQL libraries as the value of the measurePeriod element.
    CQL libraries that require access to the HQMF measurement period control variable SHALL either declare the type of the "Measurement Period" parameter as an interval of DateTime or provide a default value as an interval of DateTime.

## 3 Terminology

This chapter describes how to use codes and valuesets from codesystems like LOINC, SNOMED-CT, and others within the CQL and HQMF files of a measure package.

Valuesets and direct referenced codes are declared in the header section of the CQL using the CQL valueset and code constructs. In the case of direct referenced codes a codesystem declaration must precede the code declaration (per CQL v1.2 specification). Examples of valueset and code declarations can be seen in the accompanying ”examples/TerminologyExample.cql”.

```cql
codesystem "SNOMED-CT": 'urn:oid:2.16.840.1.113883.6.96' version 'urn:hl7:version:201609'
valueset "Encounter Inpatient SNOMEDCT Value Set": 'urn:oid:2.16.840.1.113883.3.666.7.307' version 'urn:hl7:version:20160929'
code "Venous foot pump, device (physical object)": '442023007' from "SNOMED-CT"
```

Snippet 6: CQL declaration of codesystem, valueset, and code (from Terminology CQL.cql)

Further discussion of codesystem, valueset, and code can be found in Volume 2 of this IG, sections 2.3, 2.4, and 2.5.

All declared valuesets and codes can be found in the definition elements in the HQMF (line: 2 of Snippet 1). Examples of valueSet and cql-ext:code definitions can be found in the accompanying ”examples/TerminologyExample.xml”.

```xml
<defintion typeCode="DRIV">
    <valueSet classCode="OBS" moodCode="DEF">
        <!-- id of the value set from the CQL library with the URI prefixes removed -->
        <id root="2.16.840.1.113883.3.666.5.307" />
        <null>
            <title value="Encounter Inpatient SNOMEDCT Value Set" />
            <!-- Version attribute from the CQL valueset definition, without URI prefixes -->
            <cql-ext:version value="20160929" />
    </valueSet>
    </definition>
    <definition>
        <cql-ext:code code="442023007" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT" codeSystemVersion="201609">
            <null>
                <displayName value="Venous foot pump, device (physical object)" />
        </cql-ext:code>
    </definition>
```

Snippet 7: Example HQMF terminology definitions (from Terminology eCQM.xml) Measures using valueset and/or direct referenced codes must conform to Conformance Requirement 4.

    Conformance Requirement 4 (Terminology Inclusion):
    All valuesets and codes referenced in the CQL SHALL be included in the HQMF using definition elements.
    valueset.id@root SHALL be the OID of the valueset
    valueset.title@value SHALL be the CQL identifier for the valueset
    cql-ext:code@codeSystemName SHALL be the CQL identifier for the codesystem
    cql-ext:code.displayName@value SHALL be the CQL identifier for the code

Note that because this conformance requirement references the extension schema defined in this IG, it is not included in Vol III due to tooling constraints.

## 4 Data Criteria

The data criteria section (lines 4–6 of Snippet 1) defines the patient data of interest in the measure as a set of entries. Each entry identifies specific types of data along with constraints that the data must meet. Snippet 8 shows an example of a data criteria entry indicating a ”Laboratory Test, Performed”.

Volume 3 of this implementation guide contains templates for the entry elements in the data criteria section (as in Snippet 8) and the mappings from the HQMF templates to their respective QRDA templates. For an example of how to include direct referenced codes in the data criteria section please see line 110 of the accompanying examples/Terminology eCQM.xml.

```xml
<entry typeCode="DRIV">
    <observationCriteria classCode="OBS" moodCode="EVN">
        <templateId>
            <item root="2.16.840.1.113883.10.20.28.3.42" extension="2016-12-01" />
        </templateId>
        <id root="05f0a7c8-371e-4e77-aad4-22ff9fdf7fa3" />
        <code valueset="2.16.840.1.113883.3.464.1003.198.12.1012" valueSetVersion="20160929" />
        <title value="Laboratory Test, Performed" />
        <statusCode code="completed" />
    </observationCriteria>
</entry>
```

Snippet 8: Example HQMF data criteria (from EXM146v4 eCQM.xml)

    Conformance Requirement 5 (Data Criteria Inclusion):
    Data criteria entries SHALL be included in the HQMF for each QDM element referenced by the measure logic.
    Data criteria entries SHALL conform to the templates defined in Volume 3 of this IG.
    Data criteria entries SHALL NOT include excerpt or temporallyRelatedInformation elements.

Note that CQL defines its own method for referencing data and that there is no direct link between the data criteria included in the HQMF and the data used by the CQL expressions. The HQMF data criteria are retained by this implementation guide to promote limited backwards compatibility with existing implementations of the QDM-based HQMF IG for the following use cases:

* Determining the set of data used by a particular eCQM.
* Limited “scoop-and-filter” for creation of QRDA category 1 reports. The elimination of temporal relationships from HQMF data criteria may result in the inclusion of more data than actually required. Implementations desiring or required to comply with privacy policies that mandate or recommend fine-grained filtering should examine the CQL or ELM to determine additional data constraints necessary for adherence to those policies.

Section 4.1 describes a means for deriving HQMF data criteria from CQL data references.

### 4.1 Use of ELM

The canonical representation of ELM makes it straightforward to derive HQMF data criteria for CQL data references to comply with Conformance Requirement 6:

(a) ELM elements with an xsi:type of Retrieve are equivalent to the simplified HQMF data criteria defined in Chapter 2

(b) The value of those ELM element’s dataType attributes can be mapped to the corresponding QDM data type for that data reference

(c) The value of those ELM element’s codes child elements identify the value set for the concept for that data reference

(d) The corresponding HQMF data criteria template can be looked up in Volume 3 of this IG using the QDM data type identified in item (b) above

(e) For each ELM element identified in item (a) above, an HQMF data criteria should be included using the template identified in item (d) that references the value set identified in item (c)

To illustrate the mapping, Snippet 9 shows an ELM data reference and Snippet 10 shows the corresponding HQMF data criteria.

```xml
<def name="Acute Pharyngitis" id="2.16.840.1.113883.3.464.1003.102.12.1011" accessLevel="Public" />
```

```xml
<operand xmlns:ns2="urn:healthit-gov:qdm:v5_0_2" dataType="ns2:Diagnosis" xsi:type="Retrieve">
    <codes name="Acute Pharyngitis" xsi:type="ValueSetRef" />
</operand>
```

Snippet 9: ELM data reference for Diagnosis: Acute Pharyngitis (from EXM146v4 ELM.xml)

```xml
<entry typeCode="DRIV">
    <observationCriteria classCode="OBS" moodCode="EVN">
        <templateId>
            <item root="2.16.840.1.113883.10.20.28.3.1" extension="2016-12-01" />
        </templateId>
        <id root="9e4e810d-3c3e-461e-86f8-6fe7a0b1ca2b" />
        <code code="282291009" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT">
            <displayName value="Diagnosis" />
        </code>
        <title value="Diagnosis" />
        <statusCode code="completed" />
        <value xsi:type="CD" valueSet="2.16.840.1.113883.3.464.1003.102.12.1011" valueSetVersion="20160929" />
    </observationCriteria>
</entry>
```

Snippet 10: HQMF data criteria for Diagnosis: Acute Pharyngitis (from EXM146v4 eCQM.xml)

Note: while the QDM datatypes templates in volume 3 contain specifications of QDM attributes, they are included for the purpose of formal semantic representations of the QDM datatypes. The dataCriteriaSection entry (and by extension the HQMF) shall not contain any references to the attributes within the measure’s HQMF.

    Conformance Requirement 6 (Data Criteria Inclusion):
    dataCriteriaSection entry’s SHALL only contain information related to data types
    dataCriteriaSection entry’s SHALL NOT contain information related to data type attributes

## 5 Population Criteria

The populationCriteriaSection (lines 9 - 19 of Snippet 1) includes definitions of criteria used to specify populations. The criteria specifying these populations are described using CQL and those CQL expressions are given context in the HQMF. In this section, we describe how to use CQL and HQMF to define population criteria.

CQL provides the logical expression language that is used to define population criteria. CQL-based constraints are used instead of the RIM-based data criteria constraints and population expressions defined in §4.14.3 and §2.3.2 of the HQMF R1 STU 2 specification [^4] respectively.

    Conformance Requirement 7 (Population Criteria Restrictions):
    Population criteria SHALL NOT include allTrue, allFalse, atLeastOneTrue, atLeastOneFalse, onlyOneTrue or onlyOneFalse elements.

Once included in the HQMF file, expressions defined in the CQL can be used to further refine the data criteria and to define population criteria.  Figure 3 illustrates the general concept.  Figure 3 illustrates the relationship between the HQMF and CQL documents: The HQMF QualityMeasureDocument references a CQL expression script (#1), the population criteria sections reference a particular expression from the referenced CQL file (#2), the referenced expression in-turn may include or call another expression (#3) in the same (or a different) CQL expression script. Snippet 11 and Snippet 12 demonstrate the use of HQMF and CQL in the definition of the "Initial Population". Note that the root identifier of the criteria reference (line 424) matches the internal identifier assigned to the CQL expression document (line 22 of Snippet 3). Also, note the use of the EXM146v4 namespace and escaped quotation marks (“&quot;”) in line 425.

![HQMF with linked expression document](assets/images/HQMFWithLinkedExpression.jpg)

Figure 3: HQMF with linked expression document

Snippet 12 shows several examples of a CQL expression calling another, e.g. the "Initial Population" expression references another CQL expression: "Pharyngitis Encounters With Antibiotics". In this example the referenced expressions are all contained within the same CQL file (EXM146v4 CQL.cql)

```xml
<initialPopulationCriteria classCode="OBS" moodCode="EVN" isCriterionInd="true">
    <code codeSystem="2.16.840.1.113883.5.4" codeSystemName="HL7 Act Code" code="IPOP">
        <displayName value="Initial Population" />
    </code>
    <precondition typeCode="PRCN">
        <criteriaReference moodCode="EVN" classCode="OBS"> 424		<id root="22688A59-B73C-4276-9E83-778214E1CA3C" extension="EXM146v4.&quot;Initial Population&quot;" />
        </criteriaReference>
    </precondition>
</initialPopulationCriteria>
 ```

Snippet 11: Defining a population via reference to a CQL expression (from EXM146v4 eCQM.xml)

```cql
library EXM146 version '4.0.0'

using QDM version '5.02'

include Common version '2.0.0' called Common

define "In Demographic":
    AgeInYearsAt(start of Measurement Period) >= 2
    and AgeInYearsAt(start of Measurement Period) < 18

define "Measurement Period Encounters":
    ["Encounter, Performed": "Ambulatory/ED Visit"] Encounter
    where Encounter.relevantPeriod during Measurement Period
    and "In Demographic"

define "Pharyngitis Encounters With Antibiotics":
    "Measurement Period Encounters" Encounters
    with "Pharyngitis" Pharyngitis such that
    Common."Includes Or Starts During"(Pharyngitis, Encounters)
    with "Antibiotics" Antibiotics such that Antibiotics.authorDatetime
    3 days or less after start of Encounters.relevantPeriod

define "Initial Population":
    "Pharyngitis Encounters With Antibiotics"
```

Snippet 12: CQL definition of the "Initial Population" criteria (from EXM146v4 CQL.cql)

and some are included above. The "In Demographic" expression uses the built-in CQL function Age- InYearsAt(). The definition of "Pharyngitis Encounters With Antibiotics" includes the function "Includes Or Starts During", defined in another CQL library (Common as described in examples/EXM146v4/Common-2.0.0 CQL.cql), further explanation of nested libraries is given in the “Nested Libraries” section of Volume 2 of this IG.

    Conformance Requirement 8 (Referential Integrity):
    All HQMF populationCriteriaSection component’s

    SHALL reference exactly one CQL expression.
    SHALL reference the same CQL library.

### 5.1 Criteria Names

To encourage consistency among measures, the following guidelines for specifying population criteria within a measure are proposed. The measure population criteria names and calculation methods used here are based on the Health Quality Measures Format (HQMF) HL7 standard [^4].

    Conformance Requirement 9 (Criteria Names):
    The name of an expression specifying a population criteria within a measure SHOULD always be the name of the criteria type†† :
    * "Initial Population"
    * "Denominator"
    * "Denominator Exclusion"
    * "Denominator Exception"
    * "Numerator"
    * "Numerator Exclusion"
    * "Measure Population"
    * "Measure Population Exclusion"
    * "Measure Observation"
    * "Stratification"

For each type of measure, the set of applicable criteria are defined by the Health Quality Measure Format (HQMF) specification. In addition, the formula for calculating the measure score is implied by the type of the measure. The following sections describe the expected result type for population criteria for each type of measure, as well as explicitly defining the measure score calculation formula.

In addition to the measure type, measures generally fall into two categories, patient-based, and non-patient- based, such as episode-of-care-based.  In general, patient-based measures count the number of patients in each population, while non-patient-based measures count the number of items (such as encounters) in each population. Although the calculation formulas are conceptually the same for both categories, for ease of expression, population criteria for patient-based measures return true or false, while non-patient-based measures return the item to be counted such as an encounter or procedure.

### 5.2 HQMF Population Semantics

HQMF defines a set of measure population components that are used to construct measures. HQMF populations have implicit relationships to each other as defined in the HQMF specification. For example, for proportion measures, denominatorCriteria have an implicit dependency on initialPopulation- Criteria, i.e. the criteria for inclusion in the denominator of a measure implicitly include the criteria  for inclusion in the initial population.  Similarly, numeratorCriteria have an implicit dependency on

† This is the name of a function. See the Continuous Variable Measure section for more.
†† When using multiple populations and/or multiple population groups, see Section 5.7
‡‡ Some ratio measures will require multiple Initial Populations, one for the numerator and one for the denominator.

Table 2: Measure populations based on types of measure scoring.

| Initial Population | Denominator Exclusion| Denominator Exception | Numerator | Numerator Exclusion | Measure Population | Measure Population Exclusion |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|
| Proportion | R | R | O | O | R | O | NP | NP |
| Ratio | R‡‡ | R | O | NP | R | O | NP | NP |
| Continuous Variable | R | NP | NP | NP | NP | NP | R | O |
| Cohort | R | NP | NP | NP | NP | NP | NP | NP |

R=Required. O=Optional. NP=Not Permitted.

denominatorCriteria, i.e. the criteria for inclusion in the numerator of a measure implicitly include the criteria for inclusion in the denominator.
CQL expressions referenced by HQMF population criteria are executed within the context of these implicit dependencies.

    Conformance Requirement 10 (HQMF Population Semantics):
    CQL expressions referenced by an HQMF population component SHALL
    be executed within the context of the implicit HQMF population component dependencies.
    CQL expressions MAY include explicit dependencies that duplicate the implicit HQMF population dependencies.

For example, Snippet 13 defines the "Initial Population" and "Denominator" for a measure.

```cql
define "Initial Population":
"In Demographic" and "Has Target Encounter"

define "Denominator": "Initial Population"
```

Snippet 13: Explicit definition of the initial population and denominator.

In this snippet, the relationship between the "Denominator" and the "Initial Population" is made explicit even though the HQMF defines the "Denominator" to be a subset of the "Initial Population". With respect to the HQMF population definitions, the following CQL code has identical meaning:

```cql
define "Denominator": true
```

 This last bit of code defines the "Denominator" utilizing the HQMF dependencies but this dependency is not obvious from the CQL; this is called an implicit dependency.

### 5.3 Proportion Measures

An HQMF document representing a proportion measure will include one or more population criteria sections as described in Table 2.

The semantics of these components are unchanged from the HQMF specification; the only difference is that each component references a single criterion encoded as a CQL expression.

The referenced CQL expressions return either an indication that a patient meets the population criteria (patient-based measures) or the events that a particular patient contributes to the population (episode-of- care-based measures). For example, consider two measures:

| Measure # | Denominator | Numerator |
|:--|:-:|:-:|
| 1 | All patients with condition A that had one or more encounters during the measurement period. | All patients with condition A that underwent procedure B during the measurement period. |
| 2 | All encounters for patients with condition A during the measurement period. | All encounters for patients with condition A during the measurement period where procedure B was performed during the encounter. |

Table 3: Patient-based and Episode-of-Care Measure Examples

In Table 3, the first measure is an example of a patient-based measure. Each patient may contribute at most one count to the denominator and numerator, regardless of how many encounters they had. The second measure is an episode-of-care measure where each patient may contribute zero or more encounters to the denominator and numerator counts.
For measures conforming to this implementation guide, the HQMF ITMCNT measure attribute is not used to identify the items to count. Instead, CQL expressions should be written to return an appropriate value for each population depending on the measure type. Note that the CQL context indicates whether a given expression is executed in the context of a single patient or a population of patients. Therefore the Patient context is used for both patient and episode-of-care measures and it is the responsibility of the referenced expression to return an appropriate value.

    Conformance Requirement 11 (Proportion Measures):
    Population criteria SHALL each reference a single CQL expression.
    The CQL expression SHALL use the Patient context and be executed within the context of a single patient record at a time.
    The CQL expression for patient-based measures SHALL return a Boolean to indicate whether a patient matches the population criteria (true) or not (false).
    The CQL expression for episode-of-care measures SHALL return a List of events that match the population criteria.

#### 5.3.1 Proportion measure scoring

Additional information on how proportion measures are scored (and the semantics behind the criteria names) can be found in the HQMF specification [^4].

### 5.4 Ratio Measures

An HQMF document representing a ratio measure will include one or more population criteria sections as described in Table 2.

In addition, it may also include one measure observation section with one or more measureObservation- Definition elements. The semantics of these components are unchanged from the HQMF specification; the only difference is that each measure population component and each measure observation definition references a single criterion encoded as a CQL expression.

    Conformance Requirement 12 (Ratio Measures):
    Population criteria components SHALL each reference a single CQL expression as defined by 
    measureObservationDefinition elements SHALL reference CQL expressions as defined by ., with the exception that instead of a measurePopulationCriteria, the component element SHALL reference a numeratorCriteria or denominatorCriteria by id (i.e. using root and extension attributes).

For patient-based ratio measures, all population criteria must return true or false (or null). For non-patient- based ratio measures, each population criteria must return the same type, such as an Encounter, or Procedure.

For ratio measures that include a Measure Observation, the measure observation is specified in the same way as it is for continuous variable measures. In particular, the Measure Observation is defined as a function that takes a single argument of the same type as the elements returned by all the population criteria, and the aggregation method is specified in the HQMF.

#### 5.4.1 Ratio measure scoring

Additional information on how ratio measures are scored (and the semantics behind the criteria names) can be found in the HQMF specification [^4].

### 5.5 Continuous Variable Measure

An HQMF document representing a continuous variable measure will include one or more population criteria sections as described in Table 2.

In addition, it will also include at least one measureObservationSection (seperate from the populationCriteriaSection, often placed between lines 20 and 21 of Snippet 1) with one or more measureObservationDefinition elements. The semantics of these components are unchanged from the HQMF specification; with the exception that each measure population component references a single criterion encoded as a CQL expression, and and each measure observation definition references a single criterion by its id in the HQMF document. Note that the implicit population semantics described in Section 5.2 apply equally to continuous variable measures: measure observations are only computed for patients matching the appropriate set of population criteria (i.e. accounting for exclusions).

An example measureObservationDefinition element is shown in Snippet 14.

The criteria referenced from the measureObservationDefinition component refers to a CQL expression that returns a list of events for each patient that contributes to the measure population as shown in Snippet 15.

```xml
<measureObservationSection>
    <templateId>
        <item root="2.16.840.1.113883.10.20.28.2.4" extension="2018-05-01" />
    </templateId>
    <id extension="MeasureObservations" root="B525A408-F6C1-4755-97CF-E08346F3751E" /> 486	<code code="57027-5" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" />
    <title value="Measure Observation Section" />
    <text />
    <!--Definition for Measure Observation 1-->
    <definition>
        <measureObservationDefinition classCode="OBS" moodCode="DEF">
            <id extension="Measure Observation" root="8A9A47CF-45A4-4385-923C-5A045D8EA9F8" />
            <code code="AGGREGATE" codeSystem="2.16.840.1.113883.5.4" />
            <value nullFlavor="DER" xsi:type="INT">
                <expression value="TestCMS55v5.&quot;Measure Observation&quot;" />
            </value>
            <methodCode>
                <item code="MEDIAN" codeSystem="2.16.840.1.113883.5.84" />
            </methodCode>
            <component code="COMP">
                <criteriaReference classCode="OBS" moodCode="EVN">
                    <id extension="measurePopulation" root=" 0276D90F-87A1-44CA-86CC-4A35DD1D708A" />
                </criteriaReference>
            </component>
        </measureObservationDefinition>
    </definition>
</measureObservationSection>
 ```

Snippet 14: Sample measure observation section from TestCMS55v5 eCQM.xml

```cql
define "Measure Population":
    "Initial Population"

// Measure Observation
define function "Related ED Visit"(Encounter "Encounter, Performed" ):
    Last(["Encounter, Performed": "Emergency Department Visit"] ED
    where ED.relevantPeriod ends 1 hour or less before start of Encounter.relevantPeriod
    sort by start of ED.relevantPeriod )

define function "Measure Observation" (Encounter "Encounter, Performed" ):
    duration in minutes of "Related ED Visit"(Encounter).locationPeriod
```

Snippet 15: Sample CQL (from TestCMS55v5 CQL.cql) for a continuous-variable measure

In the example shown in Snippet 14 and Snippet 15: the measure reports the AGGREGATE (line 494 in the HQMF) of the result of executing the "Measure Observation" function (line 496 in the HQMF, line 66 in the CQL) on each of the events in the measure population, as determined by the "Measure Population" expression (line 501 in the HQMF, line 34 in the CQL).

    Conformance Requirement 13 (Continuous Variable Measures):
    initialPopulationCriteria, measurePopulationCriteria and measurePopulationExclusionCriteria SHALL each reference a single CQL expression as defined by .
    methodCode SHALL be populated to indicate the aggregation method for the measure
    CQL expressions referenced from measureObservationDefinition elements SHALL use
    Patient context and be executed within the context of a single patient.
    The component of the measureObservationDefinition
    SHALL contain a criteriaReference that refers to the measurePopulationCriteria (root and extension attributes) which is within the populationCriteriaSection that is the target population group fro the measureObservationDefinition.
    CQL functions referenced from the value of the measureObservationDefinition SHALL:
    be in the same CQL file as the CQL expression in the measurePopulationCriteria referenced from the component of the measureObservationDefinition since the value element does not allow specification of the document ID
    accept a single argument whose type matches the elements of the list returned by the CQL expression referenced from the component of the measureObservationDefinition
    return either an Integer, a Decimal, or a Quantity

For continuous variable measures, the measure observation is defined as a function that takes a single parameter of the type of elements returned by the population criteria. The Initial Population, Measure Population, and Measure Population Exclusion criteria expressions must all return a list of elements of the same type.

Note that the component reference in the measure observation definition is present to resolve which measure population should be used in the case of multiple populations, but the actual input to the measure observation definition needs to account for population membership (i.e. account for exclusions). In the case of a continuous variable measure with multiple populations, the id of the criterion in HQMF is used to ensure that the measure observation definition refers to a unique criterion.

#### 5.5.1 Continuous variable measure scoring

Additional information on how continuous variable measures are scored (and the semantics behind the criteria names) can be found in the HQMF specification [^4].

### 5.6 Cohort Definitions

For cohort definitions, only the Initial Population criteria type is used. For patient-based cohort definitions, the criteria should return a true or false (or null). For other types of cohort definitions, the criteria may return any type.

### 5.7 Measures with Multiple Populations

When a measure has multiple population groups (multiple populationCriteriaSection’s), the criteria names will follow the convention above, adding the number of the population group to each criterion, e.g. "Initial Population 1", "Denominator 1", etc. Note that when multiple population groups are present, the number of the group is added to all population groups, not just the groups other than the first

For multiple population ratio measures that specify 2 initial populations, the populations would be named with an additional " X" to distinguish the initial populations, e.g. "Initial Population 1 1", "Initial Population 1 2", "Initial Population 2 1", "Initial Population 2 2".

    Conformance Requirement 14 (Multiple Population Indexing):
    When specifying multiple populations and/or multiple population groups the following naming scheme
    SHOULD be used

    (Criteria Name) (population group number)( population number)

Note when a measure has a single population group but multiple populations (such as a ratio measure), the “ ” is dropped. For example, "Initial Population 1", "Initial Population 2" refers to the populations NOT population groups.

Note also that when a measure has multiple population groups, the expectation is that the measure would have multiple scores, one for each population group. The formulas for calculation of the groups do not change; they are the same as for single group measures, just calculated using the criteria for each group.

### 5.8 Stratification

    Conformance Requirement 15 (Stratification Criteria):
    Stratifier criteria SHALL NOT include HQMF logical operators.
    Each stratifier criteria child precondition SHALL include one criteriaReference element referencing a single CQL expression.
    For patient-based measures, the CQL expression SHALL return a Boolean.
    For event-based measures (e.g. episode-of-care), the CQL expression SHALL return a list of events of the same type as the population criteria.

Stratification is represented using a stratifierCriteria component. The semantics of this component is unchanged from the HQMF specification; the only difference is that each child criteriaReference references a CQL expression that returns a boolean to determine whether a given patient meets the criteria for that stratification. Snippet 16 shows an example stratifier that stratifies results for two sub-populations. Snippet 17 shows the CQL representation of the stratifier.

```xml
<stratifierCriteria>
    <id extension="Stratifiers" root="F8EB3BCE-C313-49F0-B441-83F9B060FBEC" />
    <code code="STRAT" codeSystem="2.16.840.1.113883.5.4" codeSystemName="Act Code" />
    <precondition typeCode="PRCN">
        <criteriaReference classCode="OBS" moodCode="EVN">
            <id extension="TestCMS55v5.&quot;Stratification 1&quot;" root="DFAAF6C1-0609-49C7-BCEA-8EEDFB65DCFF" />
        </criteriaReference>
    </precondition>
</stratifierCriteria>
 ```

Snippet 16: Example Stratifier from TestCMS55v5 eCQM.xml

```cql
 define "Stratification 1" :
    "Inpatient Encounter" Encounter
    where not (Encounter.principalDiagnosis in "Psychiatric/Mental Health Patient")
 ```

Snippet 17: Example Stratifier from TestCMS55v5 CQL.cql

### 5.9 Supplemental Data Elements

    Conformance Requirement 16 (Supplemental Data Elements):
    Each supplemental data element referrenced in the CQL SHOULD :

    return a single value when evaluated in the context of a member of the population
    have a name begining with "SDE"

Part of the definition of a quality measure involves the ability to specify additional information to be returned for each member of a population. Within QDM and HQMF, these supplemental data elements are specified as QDM Data Elements for patient characteristics (such as Race, Ethnicity, Payer, and Administrative Sex) and marking them with an SDE code within the underlying HQMF XML. Snippet 18 demonstrates an example supplemental data definition using the cql-ext:supplementalDataElement.

```xml
<cql-ext:supplementalDataElement>
    <id extension="Supplemental Data Elements" root=" 478294D1-2825-441E-A6B8-B0E6ADBBDF37" />
    <code code="SDC" codeSystem="2.16.840.1.113883.5.4" codeSystemName="Act Code" />
    <precondition typeCode="PRCN">
        <criteriaReference classCode="OBS" moodCode="EVN">
            <id extension=" TestRiskAdj.&quot;SDE Ethnicity&quot;" root="FAB9DAAA-36D9-4674-8C63-6A3CB38D6BCC" />
        </criteriaReference>
    </precondition>
</cql-ext:supplementalDataElement>
 ```

Snippet 18: Sample Supplemental Data Elements from TestRiskAdj eCQM.xml

```cql
 define "SDE Ethnicity":
 ["Patient Characteristic Ethnicity": "Ethnicity"]
 ```

Snippet 19: Example Supplemental Data Element from TestRiskAdj CQL.cql

With CQL, supplemental data elements are specified using the same mechanism as any other population criteria, by defining an expression that returns the appropriate data element, and then identifying that expression within the CQL-Based HQMF. Examples of the HQMF and CQL are given in Snippet 18 and Snippet 19, respectively.
By convention, the name of each supplemental data element expression would start with "SDE". The supplemental data element expressions would be required to return a single value when evaluated in the context of a member of the population. For example, patient-based measures would return the value of a supplemental data element for a given patient.

### 5.10 Risk Adjustment

    Conformance Requirement 17 (Risk Adjustment Criteria):
    Risk Adjustment Variables SHALL be included using cql-ext:supplementalDataElement  elements as defined in hhs-cql-hqmfn1-ext-v1.xsd
    Risk Adjustment Variables SHALL reference a single CQL expression.

Some measure may define variables used to adjust scores based on a measure of “risk” observed in the population. Such variables are referred to as risk adjustment variables. Risk adjustment variables are included in the populationCriteriaSection (lines 9 - 19 of Snippet 1) and defined using CQL; such inclusions must adhere to Conformance Requirement 17.

```xml
<cql-ext:supplementalDataElement>
    <id extension="Risk Adjustment Variables" root="E738B53D-3537-41C3-A24F-507853D0C905" />
    <code code="MSRADJ" codeSystem="2.16.840.1.113883.5.4" codeSystemName="Act Code" />
    <precondition typeCode="PRCN">
        <criteriaReference classCode="OBS" moodCode="EVN">
            <id extension="TestRiskAdj.&quot;Hepatic Failure&quot;" root="FAB9DAAA-36D9-4674-8C63-6A3CB38D6BCC" />
        </criteriaReference>
    </precondition>
</cql-ext:supplementalDataElement>
 ```

Snippet 20: Sample Risk Adjustment Variable from TestRiskAdj eCQM.xml

```cql
define "Hepatic Failure":
    exists ("Cirrhosis Dx")
    and exists ("Bilirubin Test")
    and exists ("Serum Albumin Test")
```

Snippet 21: Sample Risk Adjustment Variable from TestRiskAdj CQL.cql

An example of risk adjustment can be found in the included directory examples/TestRiskAdj v5 1/; the relevant sections of the HQMF (Snippet 20) and CQL (Snippet 21) have been included.


