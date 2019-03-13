---
layout: default
title: Measure Conformance
---
## 2 eCQM Basics

In FHIR, an eCQM is represented as a Measure resource containing metadata (the rest of this section) and terminology (Section 3), a population criteria section (Section 5), and at least one Library resource containing a data criteria section (Section 4) as well as the logic used to define the population criteria. The population criteria section typically contains initial population criteria, denominator criteria, and numerator criteria sub-components, among others. Snippet 1 shows the structure of a FHIR Measure.

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

// TODO: Review and update?
The header of an eCQM document identifies and classifies the document and provides important metadata about the measure. The Blueprint includes a list of header data elements that are specified by CMS for use by all CMS measure contractors. The Blueprint header requirements have been implemented in the Meaningful Use 2014 eCQMs and all subsequent annual updates. This IG further constrains the header in the base HQMF standard by including the Blueprint header requirements. Details are as shown in Volume 3 of this IG package.

The rest of this section describes some of the more important components to the header, such as “Related Documents” (Section 2.2), “Measurement Period” (Section 2.3), and “Data Criteria” (Section 4).

### 2.2 Related Documents

Clinical Quality Language R1.4 [^3] can be used in conjunction with the FHIR Measure resource to construct CQL-based quality measures. CQL is a domain specific language used in the Clinical Quality and Clinical Decision Support domains. Measures written in CQL leverage the expressivity and computability of CQL to define the population criteria used in the eCQM.

Any included CQL library must contain a library declaration line as its first line as in Snippet 2.

```cql
library EXM146_FHIR version '4.0.0'
```

Snippet 2: Library declaration line from [EXM146_FHIR-4.0.0.cql](cql/EXM146_FHIR-4.0.0.cql)

When using multiple CQL libraries to define a measure, refer to the “Nested Libraries” section of the Using CQL topic of this guide.

Inclusion of CQL into a FHIR eCQM is accomplished through the use of a Library resource as shown in Snippet 3. These libraries are then incorporated into the FHIR eCQM using the `library` element of the Measure (line: 7 of Snippet 1). CQL library content is included as the `content` element of the Library resource.

// TODO: Restrict to base64 encoded content or allow by reference?

Snippet 3 illustrates a Library resource containing a CQL library with a stable, globally unique, version-independent identifier for the library, the `url`. If the library has a version specified, the versionNumber element is used as well.

    Conformance Requirement 1 (Referencing CQL Documents):
    CQF Measures SHALL consist of a FHIR Measure resource conforming to at least the CQFMMeasure profile
    Proportion Measures SHALL conform to the CQFMProportionMeasure profile
    Ratio Measures SHALL conform to the CQFMRatioMeasure profile
    Continuous Variable Measures SHALL conform to the CQFMContinuousVariableMeasure profile
    Cohort Measures SHALL conform to the CQFMCohortMeasure profile
    CQF Libraries SHALL consist of a FHIR Library resource conforming to at least the CQFMLibrary profile
    CQFMMeasures utilizing CQL libraries SHALL include exactly 1 CQFMLibrary per CQL library refenced in the Measure.
    CQL Libraries implicitly referenced through nesting of libraries MAY be included.
    CQFMLibraries SHALL include exactly 1 content element with a mediaType of `text/cql`
    CQFMLibraries SHALL specify content as a base-64-encoded string in content.data
    Any referenced CQL library SHALL contain a library declaration line.
    The library declaration line SHALL be the first line in the library.

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

Snippet 3: Example CQL Library (from [library-exm146-FHIR.json](Library-library-exm146-FHIR.json.html))

Inclusion of CQL libraries within the HQMF framework must conform to Conformance Requirement 1.

#### 2.2.1 Including ELM

CQL defines both a human-readable text representation and a machine-oriented XML representation called the Expression Logical Model (ELM). The human-readable text representation is optimized for authoring while the ELM representation offers a canonical, simplified representation that is easier to implement in software. Any CQL expression can be directly translated to its ELM equivalent. Measure authors do not work with ELM directly; rather authoring tools convert CQL to the ELM representation for distribution.

Both CQL and ELM representations should be referenced from the Measure to follow the approach of supporting human readability at a minimum (in this case, the high-level CQL syntax) and a canonical representation for machine processing (in this case, CQL’s Expression Logical Model (ELM)). This approach facilitates human review of measure logic via CQL and implementation of that logic in tools via ELM.

    Conformance Requirement 2 (Referencing ELM Documents):
    CQFMLibraries SHOULD include exactly 1 content element with the ELM 
      in either XML or JSON format
    CQFMLibraries SHALL specify ELM content as a base-64-encoded string 
      in content.data
    If an ELM translation is provided, both an XML and JSON representation
      of the ELM SHOULD be included.
    The XML representation of the ELM SHALL have a mediaType attribute 
      value of `application/elm+xml`
    The JSON representation of the ELM SHALL have a mediaType attribute 
      value of `application/elm+json`
    Any translation-referenced ELM documents SHALL be semantically 
      equivalent to the corresponding parent CQL expression document.

The content elements in Snippet 3 provide an example of how a CQFMLibrary resource would reference both the CQL and the ELM. More on ELM can be found in Chapter 4.1. For examples of ELM using the XML and JSON representations please see the included examples, EXM146v4_FHIR-4.0.0.xml and EXM146v4_FHIR-4.0.0.json.

### 2.3 Measurement Period

The Measure resource uses the `effectivePeriod` element to define the "Measurement Period", a control variable as metadata that influences the computation of measures. Snippet 4 demonstrates how to provide the "Measurement Period" in the Measure (line: 3 of Snippet 1).

The value of the "Measurement Period" control variable is accessible to CQL libraries as a parameter called "Measurement Period". Snippet 5 shows an example of a CQL library declaring this parameter.

```xml
<effectivePeriod>
  <start value="2018-01-01"/>
  <end value="2018-12-31"/>
</effectivePeriod>
```

Snippet 4: Measure representation of the "Measurement Period" control variable from (measure-exm.xml)

```cql
parameter "Measurement Period" Interval<DateTime>
```

Snippet 5: CQL declaration of the measurement period parameter (from EXM146_FHIR-4.0.0.cql)

    Conformance Requirement 3 (Measurement Period):
    The value of the measurement period control variable SHALL be made available to CQL libraries as the value of the effectivePeriod element.
    CQL libraries that require access to the measurement period control variable SHALL either declare the type of the "Measurement Period" parameter as an interval of DateTime or provide a default value as an interval of DateTime.

## 3 Terminology

This chapter describes how to use codes and valuesets from codesystems like LOINC, SNOMED-CT, and others within the CQL and HQMF files of a measure package.

Valuesets and direct referenced codes are declared in the header section of the CQL using the CQL valueset and code constructs. In the case of direct referenced codes a codesystem declaration must precede the code declaration (per CQL v1.2 specification). Examples of valueset and code declarations can be seen in the accompanying ”cql/Terminology_FHIR.cql”.

```cql
codesystem "SNOMEDCT:2017-09": 'http://snomed.info/sct/731000124108' 
  version 'http://snomed.info/sct/731000124108/version/201709'

valueset "Encounter Inpatient SNOMEDCT Value Set":
   'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.7.307|20160929' 

code "Venous foot pump, device (physical object)": '442023007' from "SNOMED-CT:2017-09"
```

Snippet 6: CQL declaration of codesystem, valueset, and code (from Terminology_FHIR.cql)

Further discussion of codesystem, valueset, and code can be found in the Using CQL Chapter of this IG, sections 2.3, 2.4, and 2.5.

All declared valuesets and codes can be found in the `datarequirement` elements in the Measure.

```json
"dataRequirement": [
  {
    "type": "CodeableConcept",
    "codeFilter": [
      {
        "valueCoding": {
          "system": "http://snomed.info/sct/731000124108/",
          "version": "http://snomed.info/sct/731000124108/version/201709",
          "code": "129325002",
          "display": "Introduction - action (qualifier value)"
        }
      }
    ]
  },
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
  },
  {
    "type": "Procedure",
    "codeFilter": [
      {
        "path": "code",
        "valueCoding": {
          "system": "http://snomed.info/sct/731000124108/",
          "version": "http://snomed.info/sct/731000124108/version/201709",
          "code": "71861002",
          "display": "Implantation (procedure)"
        }
      }
    ]
  }
],
```

Snippet 7: Example Library terminology definitions (from library-terminology-FHIR.json) Measures using valueset and/or direct referenced codes must conform to Conformance Requirement 4.

    Conformance Requirement 4 (Terminology Inclusion):
    All valuesets and codes referenced in the CQL SHALL be included in the Library
      using dataRequirement elements.
    If a valueset or code is referenced outside the context of a retrieve, 
      the dataRequirement SHALL have the type 'CodeableConcept'

## 4 Data Criteria

The data criteria section defines the patient data of interest in the library as a set of dataRequirements. Each entry identifies specific types of data along with constraints that the data must meet. Snippet 8 shows an example of a data criteria entry indicating an ”Encounter”.

```json
{
  "type": "Encounter",
  "codeFilter": [
    {
      "path": "type",
      "valueSetString": "https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.7.307|20160929"
    }
  ]
}
```

Snippet 8: Example data criteria (from library-terminology-FHIR.json)

    Conformance Requirement 5 (Data Criteria Inclusion):
    dataRequirement entries SHALL be included in the Library for each retrieve appearing in the CQL library

Note that CQL defines its own method for referencing data and that there is no direct link between the data criteria included in the Measure and the data used by the CQL expressions. The Library data criteria are surfaced by this implementation guide to promote structured review of the data criteria for a Library (and by examining Libraries referenced by a Measure, for a Measure or set of Measures) for the following use cases:

* Determining the set of data used by a particular eCQM.
* Limited “scoop-and-filter” for creation of quality reports. Implementations desiring or required to comply with privacy policies that mandate or recommend fine-grained filtering should examine the CQL or ELM to determine additional data constraints necessary for adherence to those policies.

Section 4.1 describes a means for deriving data requirements from CQL data references.

### 4.1 Use of ELM

The canonical representation of ELM makes it straightforward to derive data requirements for CQL data references to comply with Conformance Requirement 6:

(a) ELM elements with an xsi:type of Retrieve are equivalent to the DataRequirement type defined in FHIR

(b) The value of those ELM element’s dataType attributes can be mapped to the type element for the DataRequirement

(c) The value of those ELM element’s codes child elements identify the value set for the concept for that data reference

(d) The value of those ELM element's templateIdentifier attributes can be mapped to the profile element for the DataRequirement

(e) For each ELM element identified in item (a) above, an dataRequirement should be included using the profile identified in item (d) that references the value set identified in item (c)

To illustrate the mapping, Snippet 9 shows an ELM data reference and Snippet 10 shows the corresponding dataRequirement

```xml
<def name="Acute Pharyngitis" id="2.16.840.1.113883.3.464.1003.102.12.1011" accessLevel="Public" />
```

```xml
<operand dataType="fhir:Condition" xsi:type="Retrieve">
    <codes name="Acute Pharyngitis" xsi:type="ValueSetRef" />
</operand>
```

Snippet 9: ELM data reference for Condition: Acute Pharyngitis (from EXM146_FHIR-4.0.0.xml)

```xml
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

Snippet 10: Library dataRequirement for Diagnosis: Acute Pharyngitis (from library-exm146-FHIR.json)

## 5 Population Criteria

The Population Criteria (lines 10 - 23 of Snippet 1) includes definitions of criteria used to specify populations. The criteria specifying these populations are described using CQL and those CQL expressions are given context in the Measure. In this section, we describe how to use CQL and the Measure resource to define population criteria.

CQL provides the logical expression language that is used to define population criteria. CQL-based constraints are then referenced from the population.criteria elements of the Measure resource. Once included in the Measure, expressions defined in the CQL can be used to further refine the data criteria and to define population criteria.  Figure 3 illustrates the general concept.  Figure 3 illustrates the relationship between the Measure and CQL documents: The Measure resource references a CQL expression script (#1), the population criteria sections reference a particular expression from the referenced CQL file (#2), the referenced expression in-turn may include or call another expression (#3) in the same (or a different) CQL expression script. Snippet 11 and Snippet 12 demonstrate the use of Measure and CQL in the definition of the "Initial Population". Note that the root identifier of the criteria reference (line 424) matches the internal identifier assigned to the CQL expression document (line 22 of Snippet 3). Also, note the use of the EXM146v4 namespace and escaped quotation marks (“&quot;”) in line 425.

![Measure with linked expression document](assets/images/HQMFWithLinkedExpression.jpg)

Figure 3: Measure with linked expression document

Snippet 12 shows several examples of a CQL expression calling another, e.g. the "Initial Population" expression references another CQL expression: "Pharyngitis Encounters With Antibiotics". In this example the referenced expressions are all contained within the same CQL file (EXM146_FHIR-4.0.0.cql)

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
    "criteria": "\"EXM146_FHIR\".Initial Population"
  }
]
 ```

Snippet 11: Defining a population via reference to a CQL expression (from measure-exm146-FHIR.json)

```cql
library EXM146_FHIR version '4.0.0'

using FHIR version '3.0.0'

include FHIRHelpers version '3.0.0' called FHIRHelpers
include Common_FHIR version '2.0.0' called Common

define "In Demographic":
   AgeInYearsAt(start of "Measurement Period") >= 2
      and AgeInYearsAt(start of "Measurement Period") < 18

define "Measurement Period Encounters":
   [Encounter: "Ambulatory/ED Visit"] Encounter
      where Encounter.period during "Measurement Period"
        and Encounter.status = 'finished'
        and "In Demographic"

define "Pharyngitis Encounters With Antibiotics":
   "Measurement Period Encounters" Encounters
      with "Pharyngitis" Pharyngitis such that 
         Common."Includes Or Starts During"(Pharyngitis, Encounters)
      with "Antibiotics" Antibiotics such that Antibiotics.authoredOn 
         3 days or less after FHIRHelpers.ToInterval(Encounters.period)

define "Initial Population":
   "Pharyngitis Encounters With Antibiotics"
```

Snippet 12: CQL definition of the "Initial Population" criteria (from EXM146_FHIR-4.0.0.cql)

and some are included above. The "In Demographic" expression uses the built-in CQL function Age- InYearsAt(). The definition of "Pharyngitis Encounters With Antibiotics" uses the function "Includes Or Starts During", defined in another CQL library (Common as described in Common_FHIR-2.0.0.cql), further explanation of nested libraries is given in the “Nested Libraries” section of the Using CQL topic of this IG.

    Conformance Requirement 8 (Referential Integrity):
    All Measure population criteria components
      SHALL reference exactly one CQL expression.
      SHALL reference the same CQL library.

### 5.1 Criteria Names

To encourage consistency among measures, the following guidelines for specifying population criteria within a measure are proposed. The measure population criteria names and calculation methods used here are based on those defined by the base Measure specification in FHIR.

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

For each type of measure, the set of applicable criteria are defined by the base Measure specification. In addition, the formula for calculating the measure score is implied by the type of the measure. The following sections describe the expected result type for population criteria for each type of measure, as well as explicitly defining the measure score calculation formula.

In addition to the measure type, measures generally fall into two categories, patient-based, and non-patient- based, such as episode-of-care-based.  In general, patient-based measures count the number of patients in each population, while non-patient-based measures count the number of items (such as encounters) in each population. Although the calculation formulas are conceptually the same for both categories, for ease of expression, population criteria for patient-based measures return true or false, while non-patient-based measures return the item to be counted such as an encounter or procedure.

### 5.2 Measure Population Semantics

The base Measure resource defines a set of measure population components that are used to construct measures. Measure populations have implicit relationships to each other as defined in the base specification. For example, for proportion measures, denominator criteria have an implicit dependency on initial population criteria, i.e. the criteria for inclusion in the denominator of a measure implicitly include the criteria for inclusion in the initial population.  Similarly, numerator criteria have an implicit dependency on denominator criteria, i.e. the criteria for inclusion in the numerator of a measure implicitly include the criteria for inclusion in the denominator. CQL expressions referenced by Measure population criteria are evaluated within the context of these implicit dependencies.

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

    Conformance Requirement 10 (Measure Population Semantics):
    CQL expressions referenced by a Measure population element SHALL be executed
      within the context of the implicit Measure population criteria dependencies.
    CQL expressions MAY include explicit dependencies that duplicate the 
      implicit HQMF population dependencies.

For example, Snippet 13 defines the "Initial Population" and "Denominator" for a measure.

```cql
define "Initial Population":
"In Demographic" and "Has Target Encounter"

define "Denominator": "Initial Population"
```

Snippet 13: Explicit definition of the initial population and denominator.

In this snippet, the relationship between the "Denominator" and the "Initial Population" is made explicit even though the Measure specification defines the "Denominator" to be a subset of the "Initial Population". With respect to the Measure population definitions, the following CQL code has identical meaning:

```cql
define "Denominator": true
```

 This last bit of code defines the "Denominator" utilizing the Measure dependencies but this dependency is not obvious from the CQL; this is called an implicit dependency.

### 5.3 Proportion Measures

A Measure document representing a proportion measure will include one or more population criteria sections as described in Table 2.

The semantics of these components are unchanged from the base Measure specification; the only difference is that each component references a single criterion encoded as a CQL expression.

The referenced CQL expressions return either an indication that a patient meets the population criteria (patient-based measures) or the events that a particular patient contributes to the population (episode-of- care-based measures). For example, consider two measures:

| Measure # | Denominator | Numerator |
|:--|:-:|:-:|
| 1 | All patients with condition A that had one or more encounters during the measurement period. | All patients with condition A that underwent procedure B during the measurement period. |
| 2 | All encounters for patients with condition A during the measurement period. | All encounters for patients with condition A during the measurement period where procedure B was performed during the encounter. |

Table 3: Patient-based and Episode-of-Care Measure Examples

In Table 3, the first measure is an example of a patient-based measure. Each patient may contribute at most one count to the denominator and numerator, regardless of how many encounters they had. The second measure is an episode-of-care measure where each patient may contribute zero or more encounters to the denominator and numerator counts.
For measures conforming to this implementation guide, the populationBasis extension is used to identify the return type of population criteria expressions. CQL expressions SHALL be written to return an appropriate value for each population depending on the measure type, and that type SHALL be specified using the populationBasis extension.

    Conformance Requirement 11 (Proportion Measures):
    Population criteria SHALL each reference a single CQL expression.
    The CQL expression SHALL use the Patient context and be executed within the context of a single patient record at a time.
    The CQL expression for patient-based measures SHALL return a Boolean to indicate whether a patient matches the population criteria (true) or not (false).
    The CQL expression for non-patient-based measures SHALL return a List of events of the same type, such as an Encounter or Procedure.

#### 5.3.1 Proportion measure scoring

Additional information on how proportion measures are scored (and the semantics behind the criteria names) can be found in the base Measure specification.

### 5.4 Ratio Measures

A Measure document representing a ratio measure will include one or more population criteria sections as described in Table 2.

In addition, it may also include one or more measure-observation elements. The semantics of these components are unchanged from the base Measure specification; the only difference is that each measure population component and each measure observation definition references a single criterion encoded as a CQL expression.

    Conformance Requirement 12 (Ratio Measures):
    Population criteria SHALL each reference a single CQL expression as defined by Conformance Requirement 11.
    measure-observation criteria SHALL reference CQL expressions as defined by Conformance Requirement 13, with the exception that instead of a measure-population, the criteriaReference element SHALL reference a numerator or denominator criteria by the identifier of the criteria.
    The CQL expression for patient-based measures SHALL return a Boolean to indicate whether a patient matches the population criteria (true) or not (false).
    The CQL expression for non-patient-based measures SHALL return a List of events of the same type, such as an Encounter or Procedure.

For ratio measures that include a Measure Observation, the measure observation is specified in the same way as it is for continuous variable measures. In particular, the Measure Observation is defined as a function that takes a single argument of the same type as the elements returned by all the population criteria, and the aggregation method is specified in the Measure.

#### 5.4.1 Ratio measure scoring

Additional information on how ratio measures are scored (and the semantics behind the criteria names) can be found in the base Measure specification.

### 5.5 Continuous Variable Measure

A Measure document representing a continuous variable measure will include one or more population criteria sections as described in Table 2.

In addition, it will also include at least one measure-observation criteria. The semantics of these components are unchanged from the base Measure specification; with the exception that each measure population component references a single criterion encoded as a CQL expression, and each measure observation definition references a single criterion by its identifier in the Measure document. Note that the implicit population semantics described in Section 5.2 apply equally to continuous variable measures: measure observations are only computed for patients matching the appropriate set of population criteria (i.e. accounting for exclusions).

An example measure-observation criteria is shown in Snippet 14.

The criteria referenced from the measure-observation component refers to a CQL expression that returns a list of events for each patient that contributes to the measure population as shown in Snippet 15.

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
  "criteria": "\"EXM55_FHIR\".\"Measure Observation\""
}
 ```

Snippet 14: Sample measure observation section from measure-exm55-FHIR.json

```cql
define "Measure Population" : 
  "Initial Population" 

define "Inpatient Encounter" : 
  ["Encounter"] Encounter
    where LengthInDays(Encounter.period) <= 120
      and Encounter.period ends during "Measurement Period" 

//Measure Observation
define function "Related ED Visit" (Encounter "Encounter, Performed" ) : 
  Last(["Encounter" : "Emergency Department Visit"] ED 
    where ED.status = 'finished'
      and ED.period ends 1 hour or less before start of Encounter.period
    sort by start of period ) 

define function "Measure Observation" (Encounter "Encounter, Performed" ) : 
  duration in minutes of "Related ED Visit"(Encounter).period
```

Snippet 15: Sample CQL (from CMS55_FHIR-5.0.0.cql) for a continuous-variable measure

In the example shown in Snippet 14 and Snippet 15: the measure reports the aggregate (line 9 in Snippet 14) of the result of executing the "Measure Observation" function (line 22 in Snippet 14, line 16 in Snippet 15) on each of the events in the measure population, as determined by the "Measure Population" expression (line 5 in Snippet 14, line 1 in Snippet 15).

    Conformance Requirement 13 (Continuous Variable Measures):
    Population criteria SHALL each reference a single CQL expression as defined by Conformance Requirement 11.
    The aggregateMethod extension SHALL be population to indicate the aggregate method for the measure
    CQL expressions referenced from measureObservationDefinition elements SHALL use
      Patient context and be executed within the context of a single patient.
    The population element of a measure-observation criteria SHALL contain a criteriaReference extension that refers to the population criteria within the same population group that is the target population criteria for the measure-observation
    CQL functions referenced from a measure-observation criteria SHALL:
      be in the same CQL file as the CQL expression in the measure-population criteria referenced from the criteriaReference extension of the measure-observation criteria
      accept a single argument whose type matches the elements of the list returned by the CQL expression referenced from the criteriaReference extension of the measure-observation criteria
      return either an Integer, a Decimal, or a Quantity

For continuous variable measures, the measure observation is defined as a function that takes a single parameter of the type of elements returned by the population criteria. The Initial Population, Measure Population, and Measure Population Exclusion criteria expressions must all return a list of elements of the same type.

Note that the criteria reference in the measure observation definition is present to resolve which measure population should be used in the case of multiple populations, but the actual input to the measure observation definition needs to account for population membership (i.e. account for exclusions). In the case of a continuous variable measure with multiple populations, the identifier of the population criteria in the Measure is used to ensure that the measure observation definition refers to a unique population criteria.

#### 5.5.1 Continuous variable measure scoring

Additional information on how continuous variable measures are scored (and the semantics behind the criteria names) can be found in the base Measure specification.

### 5.6 Cohort Definitions

For cohort definitions, only the Initial Population criteria type is used. For patient-based cohort definitions, the criteria should return a true or false (or null). For other types of cohort definitions, the criteria may return any type.

### 5.7 Measures with Multiple Populations

When a measure has multiple population groups (multiple group elements), the criteria names will follow the convention above, adding the number of the population group to each criterion, e.g. "Initial Population 1", "Denominator 1", etc. Note that when multiple population groups are present, the number of the group is added to all population groups, not just the groups other than the first.

For multiple population ratio measures that specify 2 initial populations, the populations would be named with an additional " X" to distinguish the initial populations, e.g. "Initial Population 1 1", "Initial Population 1 2", "Initial Population 2 1", "Initial Population 2 2".

    Conformance Requirement 14 (Multiple Population Indexing):
    When specifying multiple populations and/or multiple population groups the following naming scheme
    SHOULD be used
      (Criteria Name) (population group number)( population number)

Note when a measure has a single population group but multiple populations (such as a ratio measure), the quotations are dropped. For example, "Initial Population 1", "Initial Population 2" refers to the populations NOT population groups.

Note also that when a measure has multiple population groups, the expectation is that the measure would have multiple scores, one for each population group. The formulas for calculation of the groups do not change; they are the same as for single group measures, just calculated using the criteria for each group.

### 5.8 Stratification

    Conformance Requirement 15 (Stratification Criteria):
    For patient-based measures, the CQL expression SHALL return a Boolean.
    For event-based measures (e.g. episode-of-care), the CQL expression SHALL return a list of events of the same type as the population criteria.

Stratification is represented using the stratifier element. The semantics of this element are unchanged from the base Measure specification; the only difference is that each population criteria references a CQL expression that returns a boolean, (or event for event-based measures) to determine whether a given patient meets the criteria for that stratification. Snippet 16 shows an example stratifier that stratifies results for two sub-populations. Snippet 17 shows the CQL representation of the stratifier.

```json
"stratifier": [
  {
    "identifier": {
      "value": "stratifier-1-identifier"
    },
    "criteria": "\"EXM55_FHIR\".\"Stratification 1\""
  }
]
 ```

Snippet 16: Example Stratifier from measure-exm55-FHIR.json

```cql
define "Stratification 1" : 
  "Inpatient Encounter" Encounter 
    where not (PrincipalDiagnosis(Encounter).code in "Psychiatric/Mental Health Patient") 
 ```

Snippet 17: Example Stratifier from EXM55_FHIR-5.0.0.cql

### 5.9 Supplemental Data Elements

    Conformance Requirement 16 (Supplemental Data Elements):
    Each supplemental data element referenced in the CQL SHOULD :
      return a single value when evaluated in the context of a member of the population
      have a name begining with "SDE"

Part of the definition of a quality measure involves the ability to specify additional information to be returned for each member of a population. Within a FHIR-based eCQM, these supplemental data elements are specified using expressions, typically involving patient characteristics (such as Race, Ethnicity, Payer, and Administrative Sex) and then marking them with an SDE code within the Measure resource. Snippet 18 demonstrates an example supplemental data definition using the cql-ext:supplementalDataElement.

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
    "criteria": "\"EXM146_FHIR\".\"SDE Ethnicity\""
  }
]
 ```

Snippet 18: Sample Supplemental Data Elements from measure-exm146-FHIR.json

```cql
define "SDE Ethnicity":
  ["Patient Characteristic Ethnicity": "Ethnicity"]
 ```

Snippet 19: Example Supplemental Data Element from EXM146_FHIR-4.0.0.cql

With CQL, supplemental data elements are specified using the same mechanism as any other population criteria, by defining an expression that returns the appropriate data element, and then identifying that expression within the Measure resource. Examples of the Measure and CQL are given in Snippet 18 and Snippet 19, respectively.
By convention, the name of each supplemental data element expression would start with "SDE". The supplemental data element expressions are normally expected to return a single value when evaluated in the context of a member of the population. For example, patient-based measures would return the value of a supplemental data element for a given patient.

### 5.10 Risk Adjustment

    Conformance Requirement 17 (Risk Adjustment Criteria):
    Risk Adjustment Variables SHALL be included using a usage element of risk-adjustment-variable
    Risk Adjustment Variables SHALL reference a single CQL expression.

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
    "criteria": "\"EXMRiskAdjustment_FHIR\".\"Hepatic Failure\""
  }
]
 ```

Snippet 20: Sample Risk Adjustment Variable from EXMRiskAdjustment_FHIR.xml

```cql
define "Hepatic Failure":
    exists ("Cirrhosis Dx")
    and exists ("Bilirubin Test")
    and exists ("Serum Albumin Test")
```

Snippet 21: Sample Risk Adjustment Variable from EXMRiskAdjustment_FHIR.cql

An example of risk adjustment can be found in the included examples/EXMRiskAdjustment; the relevant sections of the Measure (Snippet 20) and CQL (Snippet 21) have been included.


