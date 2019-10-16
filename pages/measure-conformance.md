---
layout: default
title: Measure Conformance
---
## 2 eCQM Basics

In FHIR, an eCQM is represented as a FHIR Measure resource containing metadata ([Section 2.1](measure-conformance.html#21-metadata)) and terminology ([Section 2.2](measure-conformance.html#22-terminology)), a population criteria section ([Section 2.4](measure-conformance.html#24-population-criteria)), and at least one FHIR Library resource containing a data criteria section ([Section 2.3](measure-conformance.html#23-data-criteria)) as well as the logic used to define the population criteria. The population criteria section typically contains initial population criteria, denominator criteria, and numerator criteria sub-components, among others. Snippet 1 shows the structure of a FHIR Measure.

```xml
<Measure>
  <!-- metadata for the measure - snipped for brevity -->
  <effectivePeriod>
    <start value="2018-01-01"/>
    <end value="2018-12-31"/>
  </effectivePeriod>
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

The header of an eCQM document identifies and classifies the document and provides important metadata about the measure. [The CMS Measures Management System Blueprint](https://www.cms.gov/Medicare/Quality-Initiatives-Patient-Assessment-Instruments/MMS/MMS-Blueprint.html) includes a list of header data elements that are specified by CMS for use by all CMS measure contractors. The Blueprint header requirements have been implemented in the Meaningful Use 2014 eCQMs and all subsequent annual updates. This IG further constrains the header in the [base Measure resource]({{site.data.fhir.path}}measure.html) by including the Blueprint header requirements.

The rest of this section describes some of the more important components to the header, such as “Related Documents” ([Section 2.1.1](measure-conformance.html#211-realted-documents)), “Measurement Period” ([Section 2.1.2](measure-conformance.html#212-measurement-period)), and “Data Criteria” ([Section 2.3](measure-conformance.html#23-data-criteria)).

#### 2.1.1 Related Documents

[Clinical Quality Language R1.4](http://www.hl7.org/implement/standards/product_brief.cfm?product_id=400) can be used in conjunction with the FHIR Measure resource to construct CQL-based quality measures. CQL is a domain specific language used in the Clinical Quality Measurement and Clinical Decision Support domains. Measures written in CQL leverage the expressivity and computability of CQL to define the population criteria used in the eCQM.

Any included CQL library must contain a library declaration line as its first line as in Snippet 2.

```cql
library EXM146_FHIR version '4.0.0'
```

Snippet 2: Library declaration line from [EXM146_FHIR-4.0.0.cql](cql/EXM146_FHIR-4.0.0.cql)

When using multiple CQL libraries to define a measure, refer to the [Nested Libraries](using-cql.html#312-nested-libraries) section of the [Using CQL](using-cql.html#3-cql-basics) topic of this guide.

Inclusion of CQL into a FHIR eCQM is accomplished through the use of a FHIR Library resource as shown in Snippet 4. These libraries are then incorporated into the FHIR eCQM using the `library` element of the Measure (Snippet 3). CQL library content is encoded as `base64` and included as the `content` element of the Library resource.

```xml
 <library>
    <reference value="Library/library-exm-logic"/>
  </library>
```
Snippet 3: `library` element from Snippet 1

Snippet 4 illustrates a FHIR Library resource containing a CQL library with a stable, globally unique, version-independent identifier for the library, the `url`. If the library has a version specified, the versionNumber element is used as well.

**Conformance Requirement 1 (Referencing CQL Documents):**

1. FHIR-based eCQMs SHALL consist of a FHIR Measure resource conforming to at least the CQFMMeasure profile
2. Proportion Measures SHALL conform to the CQFMProportionMeasure profile
3. Ratio Measures SHALL conform to the CQFMRatioMeasure profile
4. Continuous Variable Measures SHALL conform to the CQFMContinuousVariableMeasure profile
5. Cohort Measures SHALL conform to the CQFMCohortMeasure profile
6. Libraries used with FHIR-based eCQMs SHALL consist of a FHIR Library resource conforming to at least the CQFMLibrary profile
7. CQFMMeasures utilizing CQL libraries SHALL include exactly 1 CQFMLibrary per CQL library referenced in the Measure.
8. CQL Libraries implicitly referenced through nesting of libraries MAY be included.
9. CQFMLibraries SHALL include a content element for CQL.
10. The CQFMLibrary content element SHALL include a sub-element with a mediaType of `text/cql`
11. CQFMLibraries SHALL  specify CQL content as a base-64-encoded string in the content sub-element as content.data
12. Any referenced CQL library SHALL contain a library declaration line.
13. The library declaration line SHALL be the first line in the library.

```json
{
  "resourceType": "Library",
  "id": "library-exm146-FHIR",
  "url": "http://hl7.org/fhir/us/cqfmeasures/Library/library-exm146-FHIR",
  "identifier": [
    {
      "use": "official",
      "system": "http://example.org/fhir/cqi/ecqm/Library/Identifier/exm",
      "value": "146"
    }
  ],
  "version": "4.0.0",
  "status": "active",
  "experimental": true,
  "type": {
    "coding": [
      {
        "code": "logic-library"
      }
    ]
  },
  "relatedArtifact": [
    {
      "type": "depends-on",
      "resource": {
        "reference": "Library/library-common-FHIR"
      }
    },
    {
      "type": "depends-on",
      "resource": {
        "reference": "Library/FHIRHelpers"
      }
    }
  ],
  "dataRequirement": [
    {
      "type": "Encounter",
      "codeFilter": [
        {
          "path": "type",
          "valueSetString": "https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1061"
        }
      ]
    },
    {
      "type": "MedicationRequest",
      "codeFilter": [
        {
          "path": "medication",
          "valueSetString": "https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.196.12.1001"
        }
      ]
    },
    {
      "type": "Condition",
      "codeFilter": [
        {
          "path": "code",
          "valueSetString": "https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.102.12.1011"
        }
      ]
    },
    {
      "type": "Condition",
      "codeFilter": [
        {
          "path": "code",
          "valueSetString": "https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.102.12.1012"
        }
      ]
    },
    {
      "type": "Observation",
      "codeFilter": [
        {
          "path": "code",
          "valueSetString": "https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.198.12.1012"
        }
      ]
    }
  ],
  "content": [
    {
      "contentType": "application/elm+xml",
      "data": "PD94bWwgdm...JyYXJ5Pg=="
    },
    {
      "contentType": "text/cql",
      "data": "bGlicmFyeS...VzaW9uCg=="
    }
  ]
}
```

Snippet 4: Example CQL Library (from [library-exm146-FHIR.json](Library-library-exm146-FHIR.json.html))

Inclusion of CQL libraries within the FHIR-based eCQM framework must conform to Conformance Requirement 1.

##### 2.1.1.1 Including ELM

CQL defines both a human-readable text representation and a machine-oriented  representation called the Expression Logical Model (ELM), which can be represented using XML or JSON. The human-readable text representation is optimized for authoring while the ELM representation offers a canonical, simplified representation that is easier to implement in software. Any CQL expression can be directly translated to its ELM equivalent. Measure authors do not work with ELM directly; rather authoring tools convert CQL to the ELM representation for distribution.

Both CQL and ELM representations should be referenced from the Measure to follow the approach of supporting human readability at a minimum (in this case, the high-level CQL syntax) and a canonical representation for machine processing (in this case, CQL’s Expression Logical Model (ELM)). This approach facilitates human review of measure logic via CQL and implementation of that logic in tools via ELM.

**Conformance Requirement 2 (Referencing ELM Documents):**
1. CQFMLibraries SHOULD include a content element with the ELM  in either XML or JSON format
2. CQFMLibraries SHALL specify ELM content as a base-64-encoded string in the content sub-element as content.data
3. If an ELM translation is provided, both an XML and JSON representation
of the ELM SHOULD be included.
4. The XML representation of the ELM SHALL have a mediaType attribute
value of `application/elm+xml`
5. The JSON representation of the ELM SHALL have a mediaType attribute
value of `application/elm+json`
6. Any translation-referenced ELM documents SHALL be semantically
equivalent to the corresponding parent CQL expression document.

The content elements in Snippet 4 provide an example of how a CQFMLibrary resource would contain both the CQL and the ELM as base-64-encoded strings. More on ELM can be found in Section 3.1.1. For examples of ELM using the XML and JSON representations please see the included examples, [EXM146v4_FHIR-4.0.0.xml](Measure-measure-exm146-FHIR.xml.html) and [EXM146v4_FHIR-4.0.0.json](Measure-measure-exm146-FHIR.json.html).

#### 2.1.2 Measurement Period

The Measure resource uses the `effectivePeriod` element to define the "Measurement Period", a control variable as metadata that influences the computation of measures. Snippet 5 demonstrates how to provide the "Measurement Period" in the Measure (line: 3 of Snippet 1).

The value of the "Measurement Period" control variable is accessible to CQL libraries as a parameter called "Measurement Period". Snippet 5 shows an example of a CQL library declaring this parameter.

```xml
<effectivePeriod>
  <start value="2018-01-01"/>
  <end value="2018-12-31"/>
</effectivePeriod>
```

Snippet 5: Measure representation of the "Measurement Period" control variable from [(measure-exm.xml)](Measure-measure-exm.xml.html)

```cql
parameter "Measurement Period" Interval<DateTime>
```

Snippet 6: CQL declaration of the measurement period parameter (from [EXM146_FHIR-4.0.0.cql](cql/EXM146_FHIR-4.0.0.cql))


**Conformance Requirement 3 (Measurement Period):**
1. The value of the "Measurement Period" control variable SHALL be made available to CQL libraries as the value of the effectivePeriod element.
2. CQL libraries that require access to the "Measurement Period" control variable SHALL either declare the type of the "Measurement Period" parameter as an interval of DateTime or provide a default value as an interval of DateTime.

### 2.2 Terminology

This section describes how to use codes and valuesets from codesystems like LOINC, SNOMED-CT, and others within the CQL and FHIR-based eCQM files of a measure package.

Valuesets and direct referenced codes are declared in the header section of the CQL using the CQL valueset and code constructs. In the case of direct referenced codes, a codesystem declaration must precede the code declaration (per CQL v1.3 specification). Examples of valueset and code declarations can be seen in the accompanying [cql/Terminology_FHIR.cql](cql/Terminology_FHIR.cql).

```cql
codesystem "SNOMEDCT:2017-09": 'http://snomed.info/sct/731000124108'
  version 'http://snomed.info/sct/731000124108/version/201709'

valueset "Encounter Inpatient SNOMEDCT Value Set":
   'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.7.307|20160929'

code "Venous foot pump, device (physical object)": '442023007' from "SNOMED-CT:2017-09"
```

Snippet 7: CQL declaration of codesystem, valueset, and code (from [Terminology_FHIR.cql](cql/Terminology_FHIR.cql))

Further discussion of codesystem, valueset, and code can be found in the [Using CQL Chapter](using-cql.html#3-cql-basics) of this IG, sections [3.3](using-cql.html#23-code-systems), [3.4](using-cql.html#24-value-sets), and [3.5](using-cql.html#25-codes).

All declared valuesets and codes can be found in the [dataRequirement](StructureDefinition-library-cqfm-definitions.html#Library.dataRequirement) elements in the Library resource referenced by the Measure.

```json
"dataRequirement": [
  {
    "type": "CodeableConcept",
    "codeFilter": [
      {
        "valueCoding": {
          "system": "http://snomed.info/sct/731000124108/",
          "version": "http://snomed.info/sct/731000124108/version/201709",
          "code": "442023007",
          "display": "Venous foot pump, device (physical object)"
        }
      }
    ]
  },
  {
    "type": "Encounter",
    "codeFilter": [
      {
        "path": "type",
        "valueSetString": "https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.7.307|20160929"
      }
    ]
  }
]
```

Snippet 8: Example Library terminology definitions (from [library-terminology-FHIR.json](Library-library-terminology-FHIR.json.html))

**Conformance Requirement 4 (Terminology Inclusion):** Measures using valueset and/or direct referenced codes must conform to requirements of Conformance Requirement 4.
1. All valuesets and codes referenced in the CQL SHALL be included in the Library using dataRequirement elements.
2. If a valueset or code is referenced outside the context of a retrieve, the dataRequirement SHALL have the type 'CodeableConcept'

All retrieves are included in the `dataRequirement` section.

Retrieves include the information for their corresponding terminology (value set or direct reference code).

Any direct reference codes or value sets not referenced by a retrieve will be included in `dataRequirements` using an element of type "CodeableConcept".

### 2.3 Data Criteria

The data criteria section defines the patient data of interest in the library as a set of `dataRequirements`. Each entry identifies specific types of data along with constraints that the data must meet. Snippet 9 shows an example of a data criteria entry indicating an ”Encounter”.

```json
"dataRequirement": [
  {
    "type": "Encounter",
    "codeFilter": [
      {
        "path": "type",
        "valueSetString": "https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.7.307|20160929"
      }
    ]
  }
]
```

Snippet 9: Example data criteria (from [library-terminology-FHIR.json](Library-library-terminology-FHIR.json.html))

**Conformance Requirement 5 (Data Criteria Inclusion):**
1. `dataRequirement` entries SHALL be included in the Library for each retrieve appearing in the CQL library

Note that CQL defines its own method for referencing data and that there is no direct link between the data criteria included in the Measure and the data used by the CQL expressions. The Library data criteria are surfaced by this implementation guide to promote structured review of the data criteria for a Library (and by examining Libraries referenced by a Measure, for a Measure or set of Measures) for the following use cases:

* Determining the set of data used by a particular eCQM.
* Limited “scoop-and-filter” for creation of quality reports. Implementations desiring or required to comply with privacy policies that mandate or recommend fine-grained filtering should examine the CQL or ELM to determine additional data constraints necessary for adherence to those policies.

Section 2.3.1 describes a means for deriving data requirements from CQL data references.

#### 2.3.1 Use of ELM

The canonical representation of ELM makes it straightforward to derive data requirements for CQL data references to comply with Conformance Requirement 6:

**Conformance Requirement 6**
1. ELM elements with type "Retrieve" are represented using the DataRequirement type defined in FHIR
2. The Retrieve ELM element's "dataType" value is represented by the DataRequirement's "type" attribute
3. The Retrieve ELM element's "codes" value referencing a value set or direct reference code is represented by the DataRequirement's "codeFilter.valueSetString" attribute
4. The Retrieve ELM element's " templateId" value can be represented by the DataRequirement's "profile" attribute.
5. For each ELM element identified in item (1) above, an dataRequirement should be included using the profile identified in item (4) that references the value set identified in item (3)

Note that if the data model does not specify profile identifiers, the ELM retrieves will not have a templateId specified. In this case, the name of the type in the data model is used.

To illustrate the mapping, Snippet 10 shows an ELM data reference and Snippet 10 shows the corresponding dataRequirement

```xml
<def name="Acute Pharyngitis" id="2.16.840.1.113883.3.464.1003.102.12.1011" accessLevel="Public" />
```

```xml
<operand dataType="fhir:Condition" xsi:type="Retrieve">
    <codes name="Acute Pharyngitis" xsi:type="ValueSetRef" />
</operand>
```

Snippet 10: ELM data reference for Condition: Acute Pharyngitis (from [EXM146_FHIR-4.0.0.xml](Measure-measure-exm146-FHIR.xml.html))

```json
{
  "type": "Condition",
  "codeFilter": [
    {
      "path": "code",
      "valueSetString": "https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.102.12.1011"
    }
  ]
}
```

Snippet 11: Library dataRequirement for Condition: Acute Pharyngitis (from [library-exm146-FHIR.json](Library-library-exm146-FHIR.xml.html))

### 2.4 Population Criteria

The Population Criteria (Snippet 12) includes definitions of criteria used to specify populations. The criteria specifying these populations are described using CQL and those CQL expressions are given context in the FHIR Measure resource. In this section, we describe how to use CQL and the FHIR Measure resource to define population criteria.

```xml
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
```

Snippet 12: Population Criteria from Snippet 1 (FHIR Measure structure - abridged for clarity (from sample [Measure-measure-exm.xml](Measure-measure-exm.html)))

CQL provides the logical expression language that is used to define population criteria. CQL-based constraints are then referenced from the group elements of the FHIR Measure resource. Once included in the FHIR Measure, expressions defined in the CQL can be used to further refine the data criteria and to define population criteria.  Figure 5 illustrates the general concept.  Figure 5 illustrates the relationship between the FHIR Measure resource and CQL documents: The FHIR Measure resource references a CQL expression script (#1), the FHIR library resource references a particular expression from the referenced CQL file (#2), the referenced expression in-turn may include or call another expression (#3) in the same (or a different) CQL expression script. Snippet 13 and Snippet 14 demonstrate the use of the FHIR Measure resource and CQL in the definition of the "Initial-population".

![Measure with linked expression document](assets/images/FHIRMeasureWithLinkedExpression.png)

Figure 5: Relationship between FHIR Measure and CQL Expression Script

```json
"population": [
  {
    "identifier": {
      "value": "initial-population-identifier"
    },
    "code": {
      "coding": [
        {
          "code": "initial-population"
        }
      ]
    },
    "criteria": "\"Initial Population\""
  }
]
```

Snippet 13: Defining a population via reference to a CQL expression (from [measure-exm146-FHIR.json](Measure-measure-exm146-FHIR.json.html))

Snippet 14 shows several examples of a CQL expression calling another, e.g. the "Initial Population" expression references another CQL expression: "Pharyngitis Encounters With Antibiotics". In this example the referenced expressions are all contained within the same CQL file (EXM146_FHIR-4.0.0.cql) and some are included above. The "Is Between 2 and 17 Years of Age at Start of Measurement Period" expression uses the built-in CQL function AgeInYearsAt(). The definition of "Pharyngitis Encounters With Antibiotics" uses the function "Includes Or Starts During", defined in another CQL library (Common as described in Common_FHIR-2.0.0.cql), further explanation of nested libraries is given in the “Nested Libraries” section of the Using CQL topic of this IG.

```cql
library EXM146_FHIR version '4.0.0'

using FHIR version '3.0.0'

include FHIRHelpers version '3.0.0' called FHIRHelpers
include Common_FHIR version '2.0.0' called Common

define "Is Between 2 and 17 Years of Age at Start of Measurement Period":
   AgeInYearsAt(start of "Measurement Period") >= 2
      and AgeInYearsAt(start of "Measurement Period") <= 17

define "Measurement Period Encounters":
   [Encounter: "Ambulatory/ED Visit"] Encounter
      where Encounter.period during "Measurement Period"
        and Encounter.status = 'finished'
        and "Is Between 2 and 17 Years of Age at Start of Measurement Period"

define "Pharyngitis Encounters With Antibiotics":
   "Measurement Period Encounters" Encounters
      with "Pharyngitis" Pharyngitis such that
         Common."Includes Or Starts During"(Pharyngitis, Encounters)
      with "Antibiotics" Antibiotics such that Antibiotics.authoredOn
         3 days or less after FHIRHelpers.ToInterval(Encounters.period)

define "Initial Population":
   "Pharyngitis Encounters With Antibiotics"
```

Snippet 14: CQL definition of the "Initial Population" criteria (from [EXM146_FHIR-4.0.0.cql](cql/EXM146_FHIR-4.0.0.cql))


**Conformance Requirement 7 (Referential Integrity):**
1. All Measure population criteria components <br/>
     a. SHALL reference exactly one CQL expression.<br/>
     b. SHALL reference the same CQL library.

#### 2.4.1 Criteria Names

To encourage consistency among measures, the following guidelines for specifying population criteria within a measure are proposed. The measure population criteria names used here are defined by the [MeasurePopulationType]({{site.data.fhir.path}}codesystem-measure-population.html) code system in the base FHIR specification.

**Conformance Requirement 8 (Criteria Names):**<br/>
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

†† When using multiple populations and/or multiple population groups, see Section 2.4.7

Note that the Measure Observation criteria is the name of a function used in the Continuous Variable Measure. See the [Continuous Variable Measure](measure-conformance.html#245-continuous-variable-measure) section for more.

For each scoring type, the set of applicable criteria are specified in the [Quality Reporting]() topic of the FHIR Clinical Reasoning module. The table is reproduced here for reference:

Table 1: Measure populations based on types of measure scoring.

| | Initial Population | Denominator | Denominator Exclusion | Denominator Exception | Numerator | Numerator Exclusion | Measure Population | Measure Population Exclusion |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|
| Proportion | R | R | O | O | R | O | NP | NP |
| Ratio | R‡‡ | R | O | NP | R | O | NP | NP |
| Continuous Variable | R | NP | NP | NP | NP | NP | R | O |
| Cohort | R | NP | NP | NP | NP | NP | NP | NP |
{: .grid}

R=Required. O=Optional. NP=Not Permitted.

‡‡ Some ratio measures will require multiple Initial Populations, one for the numerator and one for the denominator.

In addition, the formula for calculating the measure score is implied by the type of the measure. The following sections describe the expected result type for population criteria for each type of measure, as well as explicitly defining the measure score calculation formula.

In addition to the measure type, measures generally fall into two categories, patient-based, and non-patient-based (e.g. encounter-based).  In general, patient-based measures count the number of patients in each population, while non-patient-based measures count the number of items (such as encounters) in each population. Although the calculation formulas are conceptually the same for both categories, for ease of expression, population criteria for patient-based measures indicates whether a patient matches the population criteria (true) or not (false). Non-patient-based measures return the item to be counted such as an encounter or procedure.

**Conformance Requirement 9 (Population Basis):**<br/>
1. CQL expressions SHALL be written to return an appropriate value for each population depending on the measure type
2. The populationBasis extension SHALL be used to identify the result type of population criteria expressions in the measure

#### 2.4.2 Measure Population Semantics

The base FHIR Measure resource defines a set of measure population components that are used to construct measures. Measure populations have implicit relationships to each other depending on the measure scoring type. For example, for proportion measures, denominator criteria have an implicit dependency on initial population criteria, i.e. the criteria for inclusion in the denominator of a measure implicitly include the criteria for inclusion in the initial population.  Similarly, numerator criteria have an implicit dependency on denominator criteria, i.e. the criteria for inclusion in the numerator of a measure implicitly include the criteria for inclusion in the denominator. CQL expressions referenced by Measure population criteria are evaluated within the context of these implicit dependencies.

**Conformance Requirement 9 (Measure Population Semantics):**
1. CQL expressions used as measure population criteria SHALL be evaluated taking relevant dependencies into account, as specified by the membership determination formulas defined for each scoring type.
2. CQL expressions MAY include explicit dependencies that duplicate the
implicit FHIR-based eCQM population dependencies.

For example, Snippet 15 defines the "Initial Population" and "Denominator" for a measure.

```cql
define "Initial Population":
  "In Demographic" and "Has Target Encounter"

define "Denominator": "Initial Population"
```

Snippet 15: Explicit definition of the initial population and denominator.

In this snippet, the relationship between the "Denominator" and the "Initial Population" is made explicit even though the Measure specification defines the "Denominator" to be a subset of the "Initial Population". With respect to the Measure population definitions, the following CQL code has identical meaning:

```cql
define "Denominator": true
```

In this variant, the "Denominator" is utilizing the Measure dependencies but this dependency is not explicitly expressed in the CQL; this is referred to as an implicit dependency.

#### 2.4.3 Proportion Measures

A Measure document representing a proportion measure will include one or more population criteria sections as described in Table 2.

The semantics of these components are unchanged from the [base Measure specification]({{site.data.fhir.path}}measure.html); the only difference is that each component references a single criterion encoded as a CQL expression.

The referenced CQL expressions return either an indication that a patient meets the population criteria (patient-based measures) or the events that a particular patient contributes to the population (episode-of- care-based measures). For example, consider two measures:

<!-- | Measure | Denominator | Numerator |
|:--------|:------------|:----------|
| Patient-based | All patients with condition A that had one or more encounters during the measurement period. | All patients with condition A that underwent procedure B during the measurement period. |
| Episode-of-Care | All encounters for patients with condition A during the measurement period. | All encounters for patients with condition A during the measurement period where procedure B was performed during the encounter. | -->
<table class="table">
  <thead>
    <tr>
      <th style="text-align: left" class="col-2">Measure</th>
      <th style="text-align: left" class="col-5">Denominator</th>
      <th style="text-align: left" class="col-5">Numerator</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align: left" class="col-2">Patient-based</td>
      <td style="text-align: left" class="col-5">All patients with condition A that had one or more encounters during the measurement period.</td>
      <td style="text-align: left" class="col-5">All patients with condition A that underwent procedure B during the measurement period.</td>
    </tr>
    <tr>
      <td style="text-align: left" class="col-2">Episode-of-Care</td>
      <td style="text-align: left" class="col-5">All encounters for patients with condition A during the measurement period.</td>
      <td style="text-align: left" class="col-5">All encounters for patients with condition A during the measurement period where procedure B was performed during the encounter.</td>
    </tr>
  </tbody>
</table>
Table 2: Patient-based and Episode-of-Care Measure Examples

In Table 2, the first measure is an example of a patient-based measure. Each patient may contribute at most one count to the denominator and numerator, regardless of how many encounters they had. The second measure is an episode-of-care measure where each patient may contribute zero or more encounters to the denominator and numerator counts.

For complete examples of patient-based proportion measures, see the Screening Measure [Examples](examples.html). For a complete example of an encounter-based proportion measure, see the [VTE-1-FHIR](Measure-measure-vte-1-FHIR.html) measure included in this implementation.

**Conformance Requirement 10 (Proportion Measures):**
1. The CQL expression SHALL use the Patient context and be executed within the context of a single patient record at a time.
2. The CQL expression for patient-based measures SHALL return a Boolean to indicate whether a patient matches the population criteria (true) or not (false).
3. The CQL expression for non-patient-based measures SHALL return a List of events of the same type, such as an Encounter or Procedure.

##### 2.4.3.1 Proportion measure scoring

The population types for a Proportion measure are "Initial Population", "Denominator", "Denominator Exclusion", "Numerator", "Numerator Exclusion" and "Denominator Exception". The following diagram shows the relationships between the populations for proportion measures and the table below provides their definitions.

Figure 4: Population criteria for Proportion measures illustration

![Proportion Venn Diagram](assets/images/ProportionVenn.jpg)

Table 2: Population Criteria Definitions for Proportion Measures

| Population | Definition |
|:----|:----:|
| Initial Population (IPOP) | All entities to be evaluated by an eMeasure which may but are not required to share a common set of specified characteristics within a named measurement set to which the eMeasure belongs. |
| Denominator (DENOM) | The same as the Initial Population or a subset of the Initial Population to further constrain the population for the purpose of the eMeasure. |
| Denominator Exclusion (DENEX) | Entities to be removed from the Initial Population and Denominator before determining if Numerator criteria are met. Denominator Exclusions are used in Proportion and Ratio measures to help narrow the Denominator. |
| Numerator (NUMER) | The processes or outcomes for each entity defined in the Denominator of a Proportion or Ratio measure. |
| Numerator Exclusion (NUMEX) | Entities that should be removed from the eMeasure's Numerator. Numerator exclusions are used in Proportion and Ratio measures to help narrow the Numerator (for inverted measures). |
| Denominator Exception (DENEXCEP) | Those conditions that should remove a patient, procedure, or unit of measurement from the Denominator only if the Numerator criteria are not met. Denominator exceptions allow for adjustment of the calculated score for those providers with higher risk populations. |

Here is an example of using population types to select data on diabetes patients for a Proportion measure:

* Initial Population (IPOP): Patient is between the age of 16 and 74
* Denominator (DENOM): Patient has Diabetes Type II
* Numerator (NUMER): Patient is between the age of 16 and 74, has Diabetes Type II, and the most recent laboratory result has hbA1C value > 9%
* Denominator Exception (DENEXCEP): Patient meets the DENOM criteria and does NOT meet the NUMER criteria, and is designated as having "Steroid Induced Diabetes" or "Gestational Diabetes"

Figure 5: Calcuation Flow for Proportion Measures

![Calculation Flow Diagram-Proportion](assets/images/CalculationFlowDiagrams-Proportion.jpg)

* Initial population (IPOP): Identify those cases that meet the IPOP criteria.
* Denominator (DENOM): Identify that subset of the IPOP that meet the DENOM criteria.
* Denominator exclusion (DENEX): Identify that subset of the DENOM that meet the DENEX criteria. There are cases that should be removed from the denominator as exclusion. Once these cases are removed, the subset remaining would reflect the denominator per criteria.
* Numerator (NUMER): Identify those cases in the DENOM and NOT in the DENEX that meet the NUMER criteria. In proportion measures, the numerator criteria are the processes or outcomes expected for each patient, procedure, or other unit of measurement defined in the denominator.
* Numerator exclusion (NUMEX): Identify that subset of the NUMER that meet the NUMEX criteria. Numerator Exclusion is used only in ratio eMeasures to define instances that should not be included in the numerator data.
* Denominator exception (DENEXCEP): Identify those in the DENOM and NOT in the DENEX and NOT in the NUMER that meet the DENEXCEP criteria.

The “performance rate” is a ratio of patients meeting NUMER criteria, divided by patients in the DENOM (accounting for exclusion and exception). Performance rate can be calculated using this formula:

Performance rate = (NUMER - NUMEX) / (DENOM – DENEX – DENEXCEP)

##### 2.3.1.1.1 Patient-based Calcuation

The following snippet provides precise semantics for the measure score calculation for a patient-based proportion measure:

```cql
context Patient

define "Denominator Membership":
  "Initial Population"
    and "Denominator"
    and not "Denominator Exclusion"
    and not ("Denominator Exception" and not "Numerator")

define "Numerator Membership":
  "Initial Population"
    and "Denominator"
    and not "Denominator Exclusion"
    and "Numerator"
    and not "Numerator Exclusion"

context Population

define "Measure Score":
  Count("Numerator Membership" IsMember where IsMember is true)
    / Count("Denominator Membership" IsMember where IsMember is true)
```

##### 2.3.1.1.2 Non-patient-based Calcuation

The following snippet provides precise semantics for the measure score calculation for a non-patient-based proportion measure:

```cql
define "Numerator Membership":
  "Initial Population"
    intersect "Denominator"
    except "Denominator Exclusion"
    intersect "Numerator"
    except "Numerator Exclusion"

define "Denominator Membership":
  "Initial Population"
    intersect "Denominator"
    except "Denominator Exclusion"
    except ("Denominator Exception" except "Numerator")

context Population

define "Measure Score":
  Count("Numerator Membership") /
    Count("Denominator Membership")
```

#### 2.4.4 Ratio Measures

A Measure document representing a ratio measure will include one or more population criteria sections as described in Table 1.

In addition, it may also include one or more measure-observation elements. The semantics of these components are unchanged from the [base Measure specification]({{site.data.fhir.path}}measure.html); the only difference is that each measure population component and each measure observation definition references a single criterion encoded as a CQL expression.

**Conformance Requirement 11 (Ratio Measures):**
1. Population criteria SHALL each reference a single CQL expression as defined by Conformance Requirement 11.
2. measure-observation criteria SHALL reference CQL expressions as defined by Conformance Requirement 13, with the exception that instead of a measure-population, the criteriaReference element SHALL reference a numerator or denominator criteria by the identifier of the criteria.
3. The CQL expression for patient-based measures SHALL return a Boolean to indicate whether a patient matches the population criteria (true) or not (false).
4. The CQL expression for non-patient-based measures SHALL return a List of events of the same type, such as an Encounter or Procedure.

For ratio measures that include a Measure Observation, the measure observation is specified in the same way as it is for continuous variable measures. In particular, the Measure Observation is defined as a function that takes a single argument of the same type as the elements returned by all the population criteria, and the aggregation method is specified in the Measure.

##### 2.4.4.1 Ratio measure scoring

The population types for a Ratio measure are "Initial Population", "Denominator", "Denominator Exclusion", "Numerator" and "Numerator Exclusion". The following diagrams show the relationships between the populations for Ratio measures and the table below provides their definitions.

Figure 8: Population criteria for Ratio measures illustration

![Ratio Venn Diagram](assets/images/RatioVenn.jpg)

Figure 9: Population criteria for Ratio measures illustration

![Ratio 2 Venn Diagram](assets/images/Ratio2Venn.png)

Figure 10: Population criteria for Ratio measures illustration

![Ratio 3 Venn Diagram](assets/images/Ratio3Venn.png)

Table 4: Population Criteria Definitions for Ratio Measures

| Population | Definition |
|:----|:----:|
| Initial Population (IPOP) | All entities to be evaluated by an eMeasure which may but are not required to share a common set of specified characteristics within a named measurement set to which the eMeasure belongs. Ratio measures are allowed to have two Initial Populations, one for Numerator and one for Denominator. In most cases, there is only 1 Initial Population |
| Denominator (DENOM) | The same as the Initial Population or a subset of the Initial Population to further constrain the population for the purpose of the eMeasure. |
| Denominator Exclusion (DENEX) | Entities that should be removed from the Initial Population and Denominator before determining if Numerator criteria are met. Denominator exclusions are used in Proportion and Ratio measures to help narrow the Denominator. |
| Numerator (NUMER) | The outcomes expected for each entity defined in the Denominator of a Proportion or Ratio measure. |
| Numerator Exclusion (NUMEX) | Entities that should be removed from the eMeasure's Numerator before determining if Numerator criteria are met. Numerator exclusions are used in Proportion and Ratio measures to help narrow the Numerator. |

Here is an example of using the population types to select data on patients with central line catheters for a ratio measure:

* Initial Population (IPOP): Patient is aged 65 years or older and admitted to hospital
* Denominator (DENOM): Patient has a central line
* Denominator Exclusion (DENEX): Patient is immunosuppressed
* Numerator (NUMER): Patient has a central line blood stream infection
* Numerator Exclusion (NUMEX): Patient's central line blood stream infection is deemed to be a contaminant

Figure 11: Calcuation Flow for Ratio Measure Score

![Calculation Flow Diagram-Ratio](assets/images/CalculationFlowDiagrams-Ratio.jpg)

* Initial population (IPOP): Identify those cases that meet the IPOP criteria. (Some ratio measures will require multiple initial populations, one for the numerator, and one for the denominator.)
* Denominator (DENOM): Identify that subset of the IPOP that meet the DENOM criteria.
* Denominator exclusion (DENEX): Identify that subset of the DENOM that meet the DENEX criteria.
* Numerator (NUMER): Identify that subset of the IPOP that meet the NUMER criteria.
* Numerator exclusion (NUMEX): Identify that subset of the NUMER that meet the NUMEX criteria.

##### 2.3.1.3.1 Individual Observations

For each case in the DENOM and not in the DENEX, determine the individual DENOM observations.

For each case in the NUMER and not in the NUMEX, determine the individual NUMER observations.

##### 2.3.1.3.2 Measusre Aggregates

Using individual observations for all cases in the DENOM and not in the DENEX, calculate the aggregate DENOM.

Using individual observations for all cases in the NUMER and not in the NUMEX, calculate the aggregate NUMER.

Ratio = aggregate NUMER / aggregate DENOM

##### 2.3.1.3.3 Patient-based Calcuation

The following snippet provides precise semantics for the measure score calculation for a patient-based ratio measure:

```cql
context Patient

define "Denominator Membership":
  "Initial Population"
    and "Denominator"
    and not "Denominator Exclusion"

define "Numerator Membership":
  "Initial Population"
    and "Numerator"
    and not "Numerator Exclusion"

context Population

define "Measure Ratio Numerator":
  Count("Numerator Membership" IsMember where IsMember is true)

define "Measure Ratio Denominator":
  Count("Denominator Membership" IsMember where IsMember is true)
```

##### 2.3.1.3.4 Non-patient-based Calcuation

The following snippet provides precise semantics for the measure score calculation for a non-patient-based ratio measure:

```cql
define "Numerator Membership":
  "Initial Population"
    intersect "Numerator"
    except "Numerator Exclusion"

define "Denominator Membership":
  "Initial Population"
    intersect "Denominator"
    except "Denominator Exclusion"

context Population

define "Measure Score Numerator":
  Count("Numerator Membership")

define "Measure Score Denominator":
  Count("Denominator Membership")
```

#### 2.4.5 Continuous Variable Measure

A Measure document representing a continuous variable measure will include one or more population criteria sections as described in Table 1.

In addition, it will also include at least one measure-observation criteria. The semantics of these components are unchanged from the [base Measure specification]({{site.data.fhir.path}}measure.html). For measure-observation criteria, two extensions are used to ensure implementability:

1. aggregateMethod: This extension defines the method used to aggregate the measure observations defined by the criteria
2. criteriaReference: This extension is used to indicate which population should be used as the source for the measure observations. This extension is used in cases where there may be multiple initial populations in a single group (such as a Ratio measure).

Note that the implicit population semantics described in Section 2.4.2 apply equally to continuous variable measures: measure observations are only computed for patients matching the appropriate set of population criteria (i.e. accounting for exclusions).

An example measure-observation criteria is shown in Snippet 15.

The criteria referenced from the measure-observation component refers to a CQL expression that returns a list of events for each patient that contributes to the measure population as shown in Snippet 16.

```json
{
  "extension": [
    {
      "url": "http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-criteriaReference",
      "valueString": "measure-population-identifier"
    },
    {
      "url": "http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-aggregateMethod",
      "valueCode": "median"
    }
  ],
  "identifier": {
    "value": "measure-observation-identifier"
  },
  "code": {
    "coding": [
      {
        "code": "measure-observation"
      }
    ]
  },
  "criteria": "\"Measure Observation\""
}
 ```

Snippet 15: Sample measure observation section from [measure-exm55-FHIR.json](Measure-measure-exm55-FHIR.json.html)

```cql
define "Measure Population" :
  "Initial Population"

define "Inpatient Encounter" :
  ["Encounter"] Encounter
    where LengthInDays(Encounter.period) <= 120
      and Encounter.period ends during "Measurement Period"

//Measure Observation
define function "Related ED Visit" (encounter Encounter) :
  Last(["Encounter" : "Emergency Department Visit"] ED
    where ED.status = 'finished'
      and ED.period ends 1 hour or less before start of encounter.period
    sort by start of period )

define function "Measure Observation" (encounter Encounter) :
  duration in minutes of "Related ED Visit"(encounter).period
```

Snippet 16: Sample CQL (from [CMS55_FHIR-5.0.0.cql](cql/EXM55_FHIR-5.0.0.cql)) for a continuous-variable measure

In the example shown in Snippet 15 and Snippet 16: the measure reports the aggregate type (Snippet 17) of the result of executing the "Measure Observation" function (Snippet 18, Snippet 19) on each of the events in the measure population, as determined by the “Measure Population” expression (Snippet 20, and Snippet 21).


```json
{
  "url": "http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-aggregateMethod",
  "valueCode": "median"
}
 ```
 Snippet 17: Aggregate type from Snippet 15 (Sample measure observation section from [measure-exm55-FHIR.json](Measure-measure-exm55-FHIR.json.html))

```json
"criteria": "\"Measure Observation\""
```
Snippet 18: "Measure Observation" function in Snippet 15 (Sample measure observation section from [measure-exm55-FHIR.json](Measure-measure-exm55-FHIR.json.html))

```cql
define function "Measure Observation" (encounter Encounter) :
```
Snippet 19: "Measure Observation" function in Snippet 16 (Sample CQL (from [CMS55_FHIR-5.0.0.cql](cql/EXM55_FHIR-5.0.0.cql)) for a continuous-variable measure)

```json
{
  "url": "http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-criteriaReference",
  "valueString": "measure-population-identifier"
}
```
Snippet 20: Identifier referenced in Snippet 15 (Sample measure observation section from [measure-exm55-FHIR.json](Measure-measure-exm55-FHIR.json.html))

```cql
define "Measure Population" :
```
Snippet 21: Definition from Snippet 16 (Sample CQL (from [CMS55_FHIR-5.0.0.cql](cql/EXM55_FHIR-5.0.0.cql)) for a continuous-variable measure)

**Conformance Requirement 12 (Continuous Variable Measures):**
1. Population criteria SHALL each reference a single CQL expression as defined by Conformance Requirement 11.
2. The aggregateMethod extension SHALL be used on the measureObservation criteria to indicate the aggregate method for the observations.
CQL expressions referenced from measure-observation criteria elements SHALL use<br/>
      a. Patient context and be executed within the context of a single patient.
3. The population element of a measure-observation criteria SHALL contain a criteriaReference extension that
refers to the population criteria within the same population group that is the target population criteria
for the measure-observation
4. CQL functions referenced from a measure-observation criteria SHALL:<br/>
      a. be in the same CQL file as the CQL expression in the measure-population criteria referenced from the
         criteriaReference extension of the measure-observation criteria<br/>
      b. accept a single argument whose type matches the elements of the list returned by the CQL expression
         referenced from the criteriaReference extension of the measure-observation criteria<br/>
      c. return either an Integer, a Decimal, or a Quantity

For continuous variable measures, the measure observation is defined as a function that takes a single parameter of the type of elements returned by the population criteria. The Initial Population, Measure Population, and Measure Population Exclusion criteria expressions must all return a list of elements of the same type.

Note that the criteria reference in the measure observation definition is present to resolve which measure population should be used in the case of multiple populations, but the actual input to the measure observation definition needs to account for population membership (i.e. account for exclusions). In the case of a continuous variable measure with multiple populations, the identifier of the population criteria in the Measure is used to ensure that the measure observation definition refers to a unique population criteria.

##### 2.4.5.1 Continuous variable measure scoring

The population types for a Continuous Variable measure are "Initial Population", "Measure Population", and "Measure Population Exclusion". In addition to these populations, a Measure Observation is defined which contains one or more Continuous Variable statements that are used to score one or more particular aspects of performance. The following diagram shows the relationships between the populations for Continuous Variable measures and the table below provides their definitions.

Figure 6: Population criteria for Continuous Variable measures illustration

![Continuous Variable Venn Diagram](assets/images/CVVenn.jpg)

Table 3: Population Criteria Definitions for Continuous Variable Measures

| Population | Definition |
|:----|:----:|
| Initial Population (IPOP) | All entities to be evaluated by an eMeasure which may but are not required to share a common set of specified characteristics within a named measurement set to which the eMeasure belongs. |
| Measure Population (MSRPOPL) | Continuous Variable measures do not have a Denominator, but instead define a Measure Population, as shown in the figure above. Rather than reporting a Numerator and Denominator, a Continuous Variable measure defines variables that are computed across the Measure Population (e.g., average wait time in the emergency department). A Measure Population may be the same as the Initial Population or a subset of the Initial Population to further constrain the population for the purpose of the eMeasure. |
| Measure Population Exclusions (MSRPOPLEX) | Patients who should be removed from the eMeasure's Initial Population and Measure Population before determining the outcome of one or more continuous variables defined within a Measure Observation. Measure Population Exclusions are used in Continuous Variable measures to help narrow the Measure Population. |

Here is an example of using the population types to select data on emergency department patients for a Continuous Variable measure:

* Initial Population (IPOP): Patient had an emergency department (ED) encounter
* Measure Population (MSRPOPL): Same as Initial Population
* Measure Population Exclusion (MSRPOPLEX): Patient had an inpatient encounter that was within 6 hours of the ED encounter or expired in the ED

Figure 7: Calcuation Flow for Continuous Variable Measure Score

![Calculation Flow Diagram-ContinuousVariable](assets/images/CalculationFlowDiagrams-ContinuousVariable.jpg)

* Initial population (IPOP): Identify those cases that meet the IPOP criteria.
* Measure population (MSRPOPL): Identify that subset of the IPOP that meet the MSRPOPL criteria.
* Measure population exclusion (MSRPOPLEX): Identify that subset of the MSRPOPL that meet the MSRPOPLEX criteria.

##### 2.3.1.2.1 Individual Observations

Individual Observations are calculated for each case in the MSRPOPL and not in the MSRPOPLEX.

##### 2.3.1.2.2 Measure Aggregates

Using individual observations for all cases in the MSRPOPL and not in the MSRPOPLEX, calculate the aggregate MSRPOPL.

Score = aggregate MSRPOPL

##### 2.3.1.2.3 Calcuation

The following snippet provides precise semantics for the measure score calculation for a continuous variable measure:

```cql
define "Measure Population Membership":
  "Initial Population"
    intersect "Measure Population"
    except "Measure Population Exclusion"

context Population

define "Measure Score":
  Avg("Measure Population Membership" PopulationMember
      return "Median ED Time"(PopulationMember)
  )
```

#### 2.4.6 Cohort Definitions

For cohort definitions, only the Initial Population criteria type is used. For patient-based cohort definitions, the criteria should return a true or false (or null). For other types of cohort definitions, the criteria may return any type.

In a cohort measure, a population is identified from the population of all items being counted. For example, one might identify all the patients who have had H1N1 symptoms. The identified population is very similar to the Initial Population but is called a Cohort Population for public health purposes. In the Constrained Information Model (CIM), the population will be expressed using the InitialPopulationCriteria act. The Cohort Population result is used by public health agencies to trigger specific public health activities. The following diagram depicts the population for a Cohort measure and the table below provides its definition.

Figure 12: Population criteria for Cohort measures illustration

![Cohort Venn Diagram](assets/images/CohortVenn.jpg)

Table 5: Population Criteria Definitions for Cohort Measures

| Population | Definition |
|:----|:----:|
| Initial Population (IPOP) | All entities to be evaluated by an eMeasure which may but are not required to share a common set of specified characteristics within a named measurement set to which the eMeasure belongs. (Also known as a Cohort Population) |

Here is an example of using the population types to select data on patients who have received immunizations for a Cohort measure:

* Initial Population (IPOP): All patients who had an immunization

Figure 13: Calcuation Flow for Cohort

Calculation Flow Diagram-Cohort

* Initial population (IPOP): Identify those cases that meet the IPOP criteria.

#### 2.4.7 Measures with Multiple Populations

When a measure has multiple population groups (multiple group elements), the criteria names will follow the convention above, adding the number of the population group to each criterion, e.g. "Initial Population 1", "Denominator 1", etc. Note that when multiple population groups are present, the number of the group is added to all population groups, not just the groups other than the first.

For multiple population ratio measures that specify 2 initial populations, the populations would be named with an additional "\_X" to distinguish the initial populations, e.g. "Initial Population 1_1", "Initial Population 1_2", "Initial Population 2_1", "Initial Population 2_2".

**Conformance Requirement 13 (Multiple Population Indexing):**
1. When specifying multiple populations and/or multiple population groups the following naming scheme
SHOULD be used<br/>
(Criteria Name) (population group number)( population number)

Note when a measure has a single population group but multiple populations (such as a ratio measure), the underscore ("\_") is dropped. For example, "Initial Population 1", "Initial Population 2" refers to the populations NOT population groups.

Note also that when a measure has multiple population groups, the expectation is that the measure would have multiple scores, one for each population group. The formulas for calculation of the groups do not change; they are the same as for single group measures, just calculated using the criteria for each group.

#### 2.4.8 Stratification

**Conformance Requirement 14 (Stratification Criteria):**
1. For patient-based measures, the CQL stratification expression SHALL return a Boolean.
2. For event-based measures (e.g. episode-of-care), the CQLstratification  expression SHALL return a list of events of the same type as the population criteria.

Stratification is represented using the stratifier element. The semantics of this element are unchanged from the [base Measure specification]({{site.data.fhir.path}}measure.html); the only difference is that each population criteria references a CQL expression that returns a Boolean, (or event for event-based measures) to determine whether a given patient meets the criteria for that stratification. Snippet 22 shows an example stratifier that stratifies results for two sub-populations. Snippet 23 shows the CQL representation of the stratifier.

```json
"stratifier": [
  {
    "identifier": {
      "value": "stratifier-1-identifier"
    },
    "criteria": "\"Stratification 1\""
  }
]
 ```

Snippet 22: Example Stratifier from [measure-exm55-FHIR.json](Measure-measure-exm55-FHIR.json.html)

```cql
define "Stratification 1" :
  "Inpatient Encounter" Encounter
    where not (PrincipalDiagnosis(Encounter).code in "Psychiatric/Mental Health Patient")
 ```

Snippet 23: Example Stratifier from [CMS55_FHIR-5.0.0.cql](cql/EXM55_FHIR-5.0.0.cql)

#### 2.4.9 Supplemental Data Elements

**Conformance Requirement 15 (Supplemental Data Elements):**
1. Supplemental Data Elements SHALL be included within the supplementalData element using a usage element of supplemental-data.
2. Supplemental Data Elements SHOULD reference a single CQL expression definition, with a name beginning with SDE.

Part of the definition of a quality measure involves the ability to specify additional information to be returned for each member of a population. Within a FHIR-based eCQM, these supplemental data elements are specified using expressions, typically involving patient characteristics (such as Race, Ethnicity, Payer, and Administrative Sex) and then marking them with an SDE code within the FHIR Measure resource. Snippet 24 demonstrates an example supplemental data definition using the cql-ext:supplementalDataElement.

```json
"supplementalData": [
  {
    "identifier": {
      "value": "supplemental-data-identifier-1"
    },
    "usage": {
      "coding": [
        {
          "code": "supplemental-data"
        }
      ],
      "text": "Supplemental Data"
    },
    "criteria": "\"SDE Ethnicity\""
  }
]
 ```

Snippet 24: Sample Supplemental Data Elements from [measure-exm146-FHIR.json](Measure-measure-exm146-FHIR.json.html)

```cql
define "SDE Ethnicity":
  ["Patient Characteristic Ethnicity": "Ethnicity"]
 ```

Snippet 25: Example Supplemental Data Element from [EXM146_FHIR-4.0.0.cql](cql/EXM146_FHIR-4.0.0.cql)

With CQL, supplemental data elements are specified using the same mechanism as any other population criteria, by defining an expression that returns the appropriate data element, and then identifying that expression within the Measure resource. Examples of the Measure and CQL are given in Snippet 18 and Snippet 19, respectively.
By convention, the name of each supplemental data element expression would start with "SDE". The supplemental data element expressions are normally expected to return a single value when evaluated in the context of a member of the population. For example, patient-based measures would return the value of a supplemental data element for a given patient. However, there are cases where returning multiple elements for supplemental data would be useful. For example, collecting observations related to a particular condition. The intent of this conformance requirement is to simplify implementation of supplemental data collection, so care should be taken when using supplemental data elements that return multiple elements.

#### 2.4.10 Risk Adjustment

**Conformance Requirement 16 (Risk Adjustment Criteria):**
1. Risk Adjustment Variables SHALL be included within the supplementalData element using a usage element of risk-adjustment-variable
2. Risk Adjustment Variables SHOULD reference a single CQL expression definition, with a name beginning with RAF

Some measures may define variables used to adjust scores based on a measure of “risk” observed in the population. Such variables are referred to as risk adjustment variables. Risk adjustment variables are included in the supplementalData section and defined using CQL; such inclusions must adhere to Conformance Requirement 17.

```json
"supplementalData": [
  {
    "identifier": {
      "value": "supplemental-data-identifier-1"
    },
    "usage": {
      "coding": [
        {
          "code": "risk-adjustment-variable"
        }
      ],
      "text": "Risk Adjustment Variable"
    },
    "criteria": "\"Hepatic Failure\""
  }
]
 ```

Snippet 26: Sample Risk Adjustment Variable from [EXMRiskAdjustment_FHIR.xml](Measure-measure-risk-adjustment-FHIR2.xml.html)

```cql
define "Hepatic Failure":
  exists ("Cirrhosis Dx")
    and exists ("Bilirubin Test")
    and exists ("Serum Albumin Test")
```

Snippet 27: Sample Risk Adjustment Variable from [EXMRiskAdjustment_FHIR2.cql](cql/RiskAdjustment_FHIR2.cql)                                                

An example of risk adjustment can be found in the included examples/EXMRiskAdjustment; the relevant sections of the FHIR Measure (Snippet 26) and CQL (Snippet 27) have been included.
