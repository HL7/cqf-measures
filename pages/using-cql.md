---
layout: default
title: Using CQL
---
## 3 CQL Basics

### 3.1 Libraries

A CQL artifact is referred to as a library.

**Conformance Requirement 17 (Library Declaration):**
  1. Any CQL library referenced by a Measure must contain a library declaration line as the first line of the library.
  2. The library declaration line SHALL contain a version number.
  3. The library version number SHALL follow the convention :  
       < major >.< minor >.< patch >

#### 3.1.1 Library Versioning

This IG recommends an approach to versioning libraries used within Measures to help track and manage dependencies. The approach recommended here is based on the Apache APR Versioning Scheme [^11].

There are three main types of changes that can be made to a library. First, a library can be changed in a way that would alter the public use of its components. Second, a library can be changed by adding new components or functionality but without changing existing components are used. And third, a library can be changed in a way that does not change existing components or add new components, but only corrects or improves the originally intended functionality.
By exposing version numbers that identify all three types of changes, libraries can be versioned in a way that makes clear when a change will impact usage, versus when a change can potentially be safely incorporated as an update. The first type of change will be referred to as a “major” change, and will require incrementing of the “major version number”. The second type of change will be referred to as a “minor” change, and will only require incrementing of the “minor version number”. And finally, the third type of change will be referred to as a “patch”, and will only require incrementing the “patch version number”.
Version numbers for CQL libraries can then be represented as:

```cql
<major>.<minor>.<patch>
```

For example:

```cql
library EXM146 version '1.0.0'
```

This would indicate the first major version of the EXM146 library. A minor change could be released by incrementing the minor version:

```cql
library EXM146 version '1.1.0'
```

And a major change could be released by incrementing the major version, and resetting the minor version: Minor changes are expected to retain backwards-compatibility, but may introduce new features and functionality, while patch changes are expected to retain forward and backwards-compatibility, and may only be used to fix issues.

```cql
library EXM146 version '2.0.0'
```

Snippet 1: Library line from EXM146_FHIR-2.0.0.cql, the second major version.

#### 3.1.2 Nested Libraries

CQL allows libraries to re-use logic already defined in other libraries. This is accomplished by utilizing the
include line as in Snippet 2.

```cql
includes Common_FHIR version '2.0.0' called Common
```

Snippet 2: Nested library within EXM146_FHIR-4.0.0.cql

The set of all CQL libraries used to define a Measure must adhere to Conformance Requirement 18.

**Conformance Requirement 18 (Nested Libraries):**
1. CQL libraries SHALL be structured such that all CQL expressions referenced by the Measure population criteria are contained within a single library.

Because of this conformance statement, the primary library for a measure can always be determined by looking at the library referenced by the initial population criteria for the measure.

### 3.2 Data Model

CQL can be used with any data model. In the context of a Measure, any referenced CQL library must identify the same data model.


**Conformance Requirement 19 (CQL Data Model):**
1. All CQL expressions used directly or indirectly within a measure SHALL reference a single data model
2. Data Model declarations SHALL include a version declaration.

For example:

```cql
using FHIR version '3.0.0'
```

Snippet 3: Data Model line from EXM146_FHIR-4.0.0.cql

### 3.3 Code Systems

Conformance Requirement 20 describes how to specify a code system within a CQL library.

**Conformance Requirement 20 (Code System Specification):**
1. Within CQL, the identifier of any code system reference SHALL be specified using a URI for the code system.
2. The URI SHALL be the canonical URL for the code system
3. The Code System declaration MAY include a version, consistent with the URI specification for FHIR and the code system

For example:

```cql
codesystem "SNOMEDCT:2017-09": 'http://snomed.info/sct/731000124108'
  version 'http://snomed.info/sct/731000124108/version/201709'
```

Snippet 4: codesystem definition line from Terminology_FHIR.cql.

The canonical URL for a code system is a globally unique, stable, version-independent identifier for the code system. The base FHIR specification defines canonical URLs for most common code systems [here](http://hl7.org/fhir/STU3/terminologies-systems.html).

The local identifier for the codesystem ("SNOMED-CT" in this case) should include the friendly name of the code system and optionally, an indication of the version, separated with a colon.

Version information for code systems is not required to be included in eCQMs; terminology versioning information may be specified externally. However, if versioning information is included, it must be done in accordance with the terminology usage specified by FHIR.

## 3.4 Value Sets

Conformance Requirement 21 describes how to specify a valueset within a CQL library.

**Conformance Requirement 21 (Value Set Specification):**
1. Within CQL, the identifier of any value set reference SHALL be specified using a URI for the value set.
2. The URI SHALL be the canonical URL for the value set
3. The URI MAY include a version, consistent with versioned canonical URL references in FHIR

For example:

```cql
valueset "Acute Pharyngitis": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.102.12.1011'
```

Snippet 5: Valueset reference from EXM146_FHIR-4.0.0.cql

The canonical URL for a value set is typically defined by the value set author, though it may be provided by the publisher as well. For example, value sets defined in the Value Set Authority Center and exposed via the VSAC FHIR interface have a base URL of `https://cts.nlm.nih.gov/fhir/`. This base is then used to construct the canonical URL for the value set (in the same way as any FHIR URL) using the resource type (`ValueSet` in this case) and the id (the value set OID in this case).

The local identifier for the value set within CQL should be the same as the name of the value set in the Value Set Authority Center (VSAC) [^9]. However, because the name of the value set is not guaranteed to be unique, it is possible to reference multiple value sets with the same name, but different identifiers. When this happens in a CQL library, the local identifier should be the name of the value set with a qualifying suffix to preserve the value set name as a human-readable artifact, but still allow unique reference within the CQL library.

For example:

```cql
valueset "Acute Pharyngitis (1)": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.102.12.1011.1'
valueset "Acute Pharyngitis (2)": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.102.12.1011.2'
```

Version information for value sets is not required to be included in eCQMs; terminology versioning information may be specified externally. However, if versioning information is included, it must be done in accordance with the terminology usage specified by FHIR. Note that the VSAC supports different approaches to retrieving the expansion of a valueset through its Sharing Value Sets (SVS) API [^10]. For the purposes of this guidance, two approaches are described: 1) by version, and 2) by profile.

#### 3.4.1 By Version

Conformance Requirement 22 describes how to retrieve an expansion of a value set by version.

**Conformance Requirement 22 (Value Set Specification By Version):**
1. When retrieving the expansion of a value set by version, append the version identifier to the canonical URL of the value set, separated by a pipe (`|`)

For example:

```cql
valueset "Encounter Inpatient SNOMEDCT Value Set":
   'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.7.307|20160929'
```

Snippet 6: valueset definition from Terminology_FHIR.cql.

#### 3.4.2 By Profile

From the perspective FHIR-based eCQMs, the profile identifier is considered a version identifier, so the identifier of the value set conforms to Conformance Requirement 23.

**Conformance Requirement 23 (Value Set Version Specification By Profile):**
1. When retrieving the expansion of a value set by profile, append the profile indicator to the canonical URL of the value set, separated by a pipe (`|`)

For example:

```cql
valueset "Face-to-Face Interaction":
  'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1004.101.12.1048|MU2%20Update@202016-04-01'
```

#### 3.4.3 Representation in a Library

The representation of valueset declarations in a Library is discussed in the [Measure Conformance Chapter](measure-conformance.html#20-ecqm) of this IG.

### 3.5 Codes

When direct reference codes are represented within CQL, the logical identifier is not recommended to be a URI. Instead, the logical identifier is the code from the code system.

**Conformance Requirement 24 (Direct Referenced Codes):**
1. When direct reference codes are represented within CQL, the logical identifier:<br/>
     a. SHALL NOT be a URI.<br/>
     b. SHALL be a code from the code system.

```cql
code "Venous foot pump, device (physical object)": '442023007' from "SNOMED-CT"
```

Snippet 7: code definition from Terminology_FHIR.cql.

Note that for direct reference code usage, the local identifier (in Snippet 7 the local identifier is "Venous foot pump, device (physical object)") should be the same as the description of the code within the terminology in order to avoid conflicting with any usage or license agreements with the referenced terminologies, but can be different to allow for potential naming conflicts, as well as simplification of longer names when appropriate.

#### 3.5.1 Representation in a Library

When direct reference codes are used within eCQMs, they will be represented in the narrative (Human-readable) as:

```html
"Assessment, Performed: Assessment of breastfeeding"
using "Venous foot pump, device (physical object) SNOMED-CT Code (442023007)"
```

The representation of code declarations in a Library is discussed in [Measure Conformance Chapter](measure-conformance.html#20-ecqm) of this IG.

### 3.6 Concepts

In addition to codes, CQL supports a concept construct, which is defined as a set of codes that are all semantically equivalent. CQL Concepts are not currently used within measure development and SHALL NOT be used within FHIR-based eCQMs, except to the extent that individual codes will be implicitly converted to concepts for the purposes of comparision with the Concept-value elements in FHIR resources.

**Conformance Requirement 25 (Concepts):**
1. The CQL concept construct SHALL NOT be used.

### 3.7 Library-level Identifiers

A “library-level identifier” is any named expression, function, parameter, code system, value set, concept, or code defined in the CQL. The library name referenced in the library-line, the data model, and any referenced external library should not be considered “library-level identifiers”. Library-level identifiers ought to be given a descriptive meaningful name (avoid abbreviations) and conform to Conformance Requirement 26.

**Conformance Requirement 26 (Library-level Identifiers):**
1. Library-level identifiers referenced in the CQL:<br/>
      a. SHOULD Use quoted identifiers<br/>
      b. SHOULD Use Title Case<br/>
      c. MAY Include spaces

For example:

```cql
define function
  "Includes Or Starts During"(Diagnosis "Diagnosis", Encounter "Encounter, Performed"):
    Diagnosis.prevalencePeriod includes Encounter.relevantPeriod
      or Diagnosis.prevalencePeriod starts during Encounter.relevantPeriod
```

Snippet 8: Function definition from Common_FHIR-2.0.0.cql

### 3.8 Data Type Names

A "data type" in CQL refers to any named type used within CQL expressions. They may be primitive types, such as the system-defined "Integer" and "DateTime", or they may be model-defined types such as "Encounter" or "Medication". For FHIR-based eCQMs using the QI-Core profiles, these will be the author-friendly identifiers for the QI-Core profile. Data types referenced in CQL libraries to be included in a Measure must conform to Conformance Requirement 27.

**Conformance Requirement 27 (Data Type Names):**
1. Data type names referenced in CQL SHALL:<br/>
       a. Use quoted identifiers<br/>
       b. Use PascalCase plus appropriate spacing

For example:

```cql
define "Statin at Discharge":
  ["MedicationRequest"] Statin
    where (Statin.medication as CodeableConcept) in "Statin Grouper"
      and Statin.intent = 'order'
```

Snippet 9: Expression definition from EXM105_FHIR-7.0.0.cql   

### 3.8.1 Negation in FHIR

Two commonly used patterns for negation in quality measurement are:

* Absence of evidence for a particular event
* Documentation of an event not occurring, together with a reason

For the purposes of quality measurement, when looking for documentation that a particular event did not occur, it must be documented with a reason in order to meet the intent. If a reason is not part of the intent, then the absence of evidence pattern should be used, rather than documentation of an event not occurring.

To address the reason an action did not occur (negation rationale), the eCQM must define the event it expects to occur using appropriate terminology to identify the kind of event (using a value set or direct reference code), and then use additional criteria to indicate that the event did not occur, as well as identifying a reason.

The following examples differentiate methods to indicate (a) presence of evidence of an action, (b) absence of evidence of an action, and (c) negation rationale for not performing an action. In each case, the "action" is an administration of medication included within a value set for "Antithrombotic Therapy".

#### Presence

Evidence that "Antithrombotic Therapy" (defined by a medication-specific value set) was administered:

    define "Antithrombotic Administered":
      ["MedicationAdministration": "Antithrombotic Therapy"] AntithromboticTherapy
        where AntithromboticTherapy.status = 'completed'
          and AntithromboticTherapy.category = "Inpatient Setting"

#### Absence

No evidence that "Antithrombotic Therapy" medication was administered:

    define "No Antithrombotic Therapy":
      not exists (
        ["MedicationAdministration": "Antithrombotic Therapy"] AntithromboticTherapy
          where AntithromboticTherapy.status = 'completed'
            and AntithromboticTherapy.category = "Inpatient Setting"
      )

#### Negation Rationale

Evidence that "Antithrombotic Therapy" medication administration did not occur for an acceptable medical reason as defined by a value set referenced by the eCQM (i.e., negation rationale):

    define "Antithrombotic Not Administered":
      ["MedicationAdministration": "Antithrombotic Therapy"] NotAdministered
        where NotAdministered.notGiven is true
          and NotAdministered.reasonNotGiven in "Medical Reason"

In this example for negation rationale, the logic looks for a member of the value set "Medical Reason" as the rationale for not administering the medication. However, underlying systems might not represent the negated action with a code from the "Antithrombotic Therapy" value set. When justifying the reason for not administering a class of medications, clinicians do not generally specify one of the medications in the class, they most often indicate avoidance of the entire class. In these cases, the value set may be used as a placeholder to indicate the medication class was not administered. Implementations processing data reported in this way should take into account that the reported data may not be returned with a single code, but rather a value set identifier, and should consider data with the appropriate value set identifier as satisfying the criteria for value set membership.

Similarly, "Procedure, Not Performed": "Cardiac Surgery" should not require specification of which cardiac surgery in a value set was not performed, but only reference any member of the class of procedures defined by the value set. The same process works for any application of negation rationale.

### 3.9 Attribute Names

All attributes referenced in the CQL follow Conformance Requirement 28.

**Conformance Requirement 28 (Attribute Names):**
1. Data model attributes referenced in the CQL:<br/>
      a. SHALL NOT Use quoted identifiers<br/>
      b. SHALL Use camelCase

Examples of attributes conforming to Conformance Requirement 28 is given below. For a full list of valid of attributes, refer to an appropriate data model specification such as QI-Core.

```cql
period
authoredOn
result
```

### 3.10 Aliases and Argument Names

Aliases are used in CQL as local variable names to refer to sections of code. When defining a function, argument names are used to create scoped variables that refer to the function inputs. Both aliases and argument names conform to Conformance Requirement 29.

**Conformance Requirement 29 (Aliases and Argument Names):**
1. Aliases and argument names referenced in the CQL :<br/>
      a. SHALL NOT Use quoted identifiers<br/>
      b. SHALL Use PascalCase<br/>
      c. SHOULD Use descriptive names (no abbreviations)

For example:

```cql
define "Encounters During Measurement Period":
    "Valid Encounters" QualifyingEncounter
        where QualifyingEncounter.period during "Measurement Period"

define function "ED Stay Time"(Encounter "Encounter, Performed"):
    duration in minutes of Encounter.period
```

## 3.11 Translation to ELM

Tooling exists to support translation of CQL to ELM for distribution in XML or JSON formats. These distributions are included with eCQMs to facilitate implementation. The existing translator tooling applies to both measure and decision support development, and has several options available to make use of different data models in different environments. For measure development with FHIR, the following options are recommended:

| Option | Description | Recommendation |
|----|----|----|
| EnableAnnotations | This instructs the translator to include the source CQL as an annotation within the ELM. | This option should be used to ensure that the distributed ELM could be linked back to the source CQL. |
| EnableLocators | This instructs the translator to include line number and character information for each ELM node. | This option should be used to ensure that distributed ELM could be tied directly to the input source CQL. |
| DisableListDemotion | This instructs the translator to disallow demotion of list-valued expressions to singletons. The list demotion feature of CQL is used to enable functionality related to use with FHIRPath. | This option should be used with Measures to ensure list demotion does not occur unexpectedly. |
| DisableListPromotion | This instructs the translator to disallow promotion of singletons to list-valued expressions. The list promotion feature of CQL is used to enable functionality related to use with FHIRPath. | This option should be used with Measures to ensure list promotion does not occur unexpectedly. |
| DisableMethodInvocation | This instructs the translator to disallow method-style invocation. The method-style invocation feature of CQL is used to enable functionality related to use with FHIRPath. | This option should be used with Measures to ensure method-style invocation cannot be used within eCQMs. |
| EnableDateRangeOptimization | This instructs the translator to optimize date range filters by moving them inside retrieve expressions. | This feature may be used with Measures. |
| EnableResultTypes | This instructs the translator to include inferred result types in the output ELM. | This feature may be used with Measures. |
| EnableDetailedErrors | This instructs the translator to include detailed error information. By default, the translator only reports root-cause errors. | This feature should not be used with Measures. |
| DisableListTraversal | This instructs the translator to disallow traversal of list-valued expressions. With Measures, disabling this feature would prevent a useful capability. | This feature should not be used with Measures. |
