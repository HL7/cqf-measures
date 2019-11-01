---
layout: default
title: Using CQL
---

---

<!-- TOC  the css styling for this is \pages\assets\css\project.css under 'markdown-toc'-->

* Do not remove this line (it will not be displayed)
{:toc}

## 4 CQL Basics
{: #cql-basics}

### 4.1 Libraries
{: #libraries}

A CQL artifact is referred to as a library.

**Conformance Requirement 18 (Library Declaration):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-18)
{: #conformance-requirement-18}
  1. Any CQL library referenced by a Measure must contain a library declaration line as the first line of the library.
  2. The library declaration line SHALL contain a version number.
  3. The library version number SHALL follow the convention :  
       < major >.< minor >.< patch >

#### 4.1.1 Library Versioning
{: #library-versioning}

This IG recommends an approach to versioning libraries used within Measures to help track and manage dependencies.
The approach recommended here is based on the [Semantic Versioning Scheme.](https://semver.org/)

There are three main types of changes that can be made to a library. First, a library can be changed in a way that
would alter the public use of its components. Second, a library can be changed by adding new components or functionality
but without changing existing components are used. And third, a library can be changed in a way that does not change
existing components or add new components, but only corrects or improves the originally intended functionality.
By exposing version numbers that identify all three types of changes, libraries can be versioned in a way that makes
clear when a change will impact usage, versus when a change can potentially be safely incorporated as an update. The
first type of change will be referred to as a "major" change, and will require incrementing of the "major version
number". The second type of change will be referred to as a "minor" change, and will only require incrementing of the
"minor version number". And finally, the third type of change will be referred to as a "patch", and will only require
incrementing the "patch version number". Version numbers for CQL libraries can then be represented as:

```cql
<major>.<minor>.<patch>
```
{: #content-pre}

For example:

```cql
library EXM146 version '1.0.0'
```

This would indicate the first major version of the EXM146 library. A minor change could be released by incrementing the
minor version:

```cql
library EXM146 version '1.1.0'
```

And a major change could be released by incrementing the major version, and resetting the minor version: Minor changes
are expected to retain backwards-compatibility, but may introduce new features and functionality, while patch changes
are expected to retain forward and backwards-compatibility, and may only be used to fix issues.

```cql
library EXM146 version '2.0.0'
```

Snippet 4-1: Library line from EXM146_FHIR-2.0.0.cql, the second major version.

#### 4.1.2 Nested Libraries
{: #nested-libraries}

CQL allows libraries to re-use logic already defined in other libraries. This is accomplished by utilizing the
include line as in Snippet 4-2.

```cql
includes Common_FHIR version '2.0.0' called Common
```

Snippet 4-2: Nested library within [EXM146_FHIR-4.0.0.cql](cql/EXM146_FHIR-4.0.0.cql)

The set of all CQL libraries used to define a Measure must adhere to Conformance Requirement 19.

**Conformance Requirement 19 (Nested Libraries):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-19)
{: #conformance-requirement-19}

1. CQL libraries SHALL be structured such that all CQL expressions referenced by the Measure population criteria are
contained within a single library.
2. CQL libraries SHALL use a `called` clause for all included libraries
3. The `called`-alias for an included library SHOULD be consistent for usages across libraries

Because of this conformance statement, the primary library for a measure can always be determined by looking at the
library referenced by the initial population criteria for the measure.

#### 4.1.3 Library Namespaces
{: #library-namespaces}

CQL allows libraries to define a namespace that can be used to organize libraries across different groups of users.
Within a namespace, library names are required to be unique. Across namespaces, the same library name may be reused.
For example, OrganizationA and OrganizationB can both define a library named `Common`, so long as they use different
namespaces. For example, consider the following library declaration:

```cql
library CMS.Common version '2.0.0'
```

This example declares a library named Common in the CMS namespace. Per the CQL specification, the namespace for a
library is included in the ELM, along with a URI that provides a globally unique, stable identifier for the namespace.
For example, the URI for the CMS namespace would be `https://ecqi.healthit.gov/ecqm/measures`.

Note that this is a URI that may or may not correspond to a reachable web address (a URL). The important aspect is not
the addressability, but the uniqueness, ensuring that library name collisions cannot occur.

**Conformance Requirement 20 (Library Namespaces):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-20)
{: #conformance-requirement-20}

1. CQL libraries SHOULD use namespaces.
2. When a namespace is not used, the library SHALL be considered part of a "public" global namespace for the purposes of resolution within a given environment.

In addition, because the namespace of a library is part of the text, changing the namespace of a library requires a new version, just like any other change to the text of the library. However, because a change to the namespace is not a material change to the library itself, changing the namespace does not require a different version-independent identifier to be used for the library.

### 4.2 Data Model
{: #data-model}

CQL can be used with any data model. In the context of a Measure, any referenced CQL library must identify the same data model.


**Conformance Requirement 21 (CQL Data Model):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-21)
{: #conformance-requirement-21}

1. All CQL expressions used directly or indirectly within a measure SHALL reference a single data model
2. Data Model declarations SHALL include a version declaration.

For example:

```cql
using FHIR version '3.0.0'
```

Snippet 4-3: Data Model line from [EXM146_FHIR-4.0.0.cql](cql/EXM146_FHIR-4.0.0.cql)

### 4.3 Code Systems
{: #code-systems}

Conformance Requirement 22 describes how to specify a code system within a CQL library.

**Conformance Requirement 22 (Code System Specification):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-22)
{: #conformance-requirement-22}

1. Within CQL, the identifier of any code system reference SHALL be specified using a URI for the code system.
2. The URI SHALL be the canonical URL for the code system
3. The Code System declaration MAY include a version, consistent with the URI specification for FHIR and the code system

For example:

```cql
codesystem "SNOMED CT:2017-09": 'http://snomed.info/sct'
  version 'http://snomed.info/sct/731000124108/version/201709'
```

Snippet 4-4: codesystem definition line from [Terminology_FHIR.cql](cql/Terminology_FHIR.cql).

The canonical URL for a code system is a globally unique, stable, version-independent identifier for the code system.
The base FHIR specification defines canonical URLs for most common code systems
[here](http://hl7.org/fhir/R4/terminologies-systems.html).

The local identifier for the codesystem ("SNOMED CT:2017-09" in this case) should include the friendly name of the code system 
and optionally, an indication of the version, separated with a colon.

Version information for code systems is not required to be included in eCQMs; terminology versioning information may be
specified externally. However, if versioning information is included, it must be done in accordance with the terminology
usage specified by FHIR.

If no version is specified, then the default behavior for a FHIR terminology server is to use the most recent code
system version available on the server.

## 4.4 Value Sets
{: #value-sets}

Conformance Requirement 23 describes how to specify a valueset within a CQL library.

**Conformance Requirement 23 (Value Set Specification):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-23)
{: #conformance-requirement-23}

1. Within CQL, the identifier of any value set reference SHALL be specified using a URI for the value set.
2. The URI SHALL be the canonical URL for the value set
3. The URI MAY include a version, consistent with versioned canonical URL references in FHIR

For example:

```cql
valueset "Acute Pharyngitis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.102.12.1011'
```

Snippet 4-5: Valueset reference from [EXM146_FHIR-4.0.0.cql](cql/EXM146_FHIR-4.0.0.cql)

The canonical URL for a value set is typically defined by the value set author, though it may be provided by the
publisher as well. For example, value sets defined in the Value Set Authority Center and exposed via the VSAC FHIR
interface have a base URL of `http://cts.nlm.nih.gov/fhir/`. This base is then used to construct the canonical URL for
the value set (in the same way as any FHIR URL) using the resource type (`ValueSet` in this case) and the id (the value
set OID in this case). Note that the _canonical URL_ is a globally unique, stable, version-independent identifier for the
value set. See [Canonical URLs](http://hl7.org/fhir/references.html#canonical) in the base FHIR specification for more information.

The local identifier for the value set within CQL should be the same as the name of the value set in the
[Value Set Authority Center (VSAC)](https://vsac.nlm.nih.gov/). However, because the name of the value set is not
guaranteed to be unique, it is possible to reference multiple value sets with the same name, but different identifiers.
When this happens in a CQL library, the local identifier should be the name of the value set with a qualifying suffix to
preserve the value set name as a human-readable artifact, but still allow unique reference within the CQL library.

For example:

```cql
valueset "Acute Pharyngitis (1)": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.102.12.1011.1'
valueset "Acute Pharyngitis (2)": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.102.12.1011.2'
```

Note carefully that although this URL may be resolveable for some terminology implementations, this is not necessarily the
case. This use of a canonical URL can be resolved as a search by the `url` element:

```http
GET fhir/ValueSet?url=http%3A%2F%2Fcts.nlm.nih.gov%2Ffhir%2FValueSet%2F2.16.840.1.113883.3.464.1003.102.12.1011.1
```

#### 4.4.1 Value Set Version
{: #value-set-version}

Version information for value sets is not required to be included in eCQMs; terminology versioning information may be
specified externally. However, if versioning information is included, it must be done in accordance with the terminology
usage specified by FHIR.

Conformance Requirement 24 describes how to retrieve an expansion of a value set by version.

**Conformance Requirement 24 (Value Set Specification By Version):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-24)
{: #conformance-requirement-24}

1. When retrieving the expansion of a value set by version, append the version identifier to the canonical URL of the
value set, separated by a pipe (`|`)

For example:

```cql
valueset "Encounter Inpatient SNOMEDCT Value Set":
   'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.7.307|20160929'
```

Snippet 4-6: valueset definition from [Terminology_FHIR.cql](cql/Terminology_FHIR.cql).

This is a _version specific value set reference_, and can be resolved as a search by the `url` and `version` elements:

```http
GET fhir/ValueSet?url=http%3A%2F%2Fcts.nlm.nih.gov%2Ffhir%2FValueSet%2F2.16.840.1.113883.3.666.7.307&version=20160929
```

#### 4.4.2 Value Set Expansion

It is important to maintain the distinction between the _definition_ of a value set and the _expansion_ of a value set. The searches
described in previous sections all retrieve the definition of a value set. For the purposes of local evaluation, implementations may
wish to retrieve the _expansion_ of a value set, or the set of all codes that are defined to be in the value set by the _definition_.

Because the definition of a value set can, and often does, include codes from a code system based on properties of that code system, the
expansion of a value set is sensitive to the versions of the code systems used in the definition. This means that in general, the expansion
of a value set is version-specific, and care must be taken to ensure that version considerations are taken into account when using the
results of an expansion. For more information, see the [Value Set Expansion](http://hl7.org/fhir/valueset.html#expansion) topic in the
base FHIR specification.

#### 4.4.2 Representation in a Library
{: #representation-in-a-library}

The representation of valueset declarations in a Library is discussed in the
[Measure Conformance Chapter](measure-conformance.html#ecqm-basics) of this IG.

#### 4.4.3 String-based Membership Testing
{: #string-based-membership-testing}

Although CQL allows the use of strings as input to membership testing in value sets, this capability should be
disallowed in measure CQL as it can lead to incorrect matching if the code system is ignored.

**Conformance Requirement 25 (String-based Membership Testing):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-25)
{: #conformance-requirement-25}

1. String-based membership testing SHALL NOT be used in CQL libraries

For example, given a valueset named `"Administrative Gender"`, the following CQL expression would be non-conformant:

```cql
'female' in "Administrative Gender"
```

### 4.5 Codes
{: #codes}

When direct reference codes are represented within CQL, the logical identifier is not recommended to be a URI. Instead,
the logical identifier is the code from the code system.

**Conformance Requirement 26 (Direct Referenced Codes):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-26)
{: #conformance-requirement-26}

1. When direct reference codes are represented within CQL, the logical identifier:<br/>
     a. MUST NOT be a URI.<br/>
     b. SHALL be a code from the code system.

```cql
code "Venous foot pump, device (physical object)": '442023007' from "SNOMED CT"
```

Snippet 4-7: code definition from [Terminology_FHIR.cql](cql/Terminology_FHIR.cql).

Note that for direct reference code usage, the local identifier (in Snippet 7 the local identifier is "Venous foot pump,
device (physical object)") should be the same as the description of the code within the terminology in order to avoid
conflicting with any usage or license agreements with the referenced terminologies, but can be different to allow for
potential naming conflicts, as well as simplification of longer names when appropriate.

#### 4.5.1 Representation in a Library
{: #representation-in-a-library}

When direct reference codes are used within eCQMs, they will be represented in the narrative (Human-readable) as:

```html
"Assessment, Performed: Assessment of breastfeeding"
using "Venous foot pump, device (physical object) SNOMED CT Code (442023007)"
```

The representation of code declarations in a Library is discussed in [Measure Conformance Chapter](measure-conformance.html#ecqm-basics) of this IG.

### 4.6 Concepts
{: #concepts}

In addition to codes, CQL supports a concept construct, which is defined as a set of codes that are all semantically
equivalent. CQL Concepts are not currently used within measure development and SHALL NOT be used within FHIR-based
eCQMs, except to the extent that individual codes will be implicitly converted to concepts for the purposes of
comparision with the Concept-value elements in FHIR resources.

**Conformance Requirement 27 (Concepts):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-27)
{: #conformance-requirement-27}

1. The CQL concept construct SHALL NOT be used.

### 4.7 Library-level Identifiers
{: #library-level-identifiers}

A "library-level identifier" is any named expression, function, parameter, code system, value set, concept, or code
defined in the CQL. The library name referenced in the library-line, the data model, and any referenced external library
should not be considered "library-level identifiers". Library-level identifiers ought to be given a descriptive
meaningful name (avoid abbreviations) and conform to Conformance Requirement 28.

**Conformance Requirement 28 (Library-level Identifiers):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-28)
{: #conformance-requirement-28}

1. Library-level identifiers referenced in the CQL:<br/>
      a. SHOULD Use quoted identifiers<br/>
      b. SHOULD Use Title Case<br/>
      c. MAY Include spaces

For example:

```cql
define function
   "Includes Or Starts During"(Condition "Condition", Encounter "Encounter"):
      Interval[Condition.onset, Condition.abatement] includes Encounter.period
         or Condition.onset during Encounter.period
```

Snippet 4-8: Function definition from [Common_FHIR-2.0.0.cql](cql/Common_FHIR-2.0.0.cql)

### 4.8 Data Type Names
{: #data-type-names}

A "data type" in CQL refers to any named type used within CQL expressions. They may be primitive types, such as the
system-defined "Integer" and "DateTime", or they may be model-defined types such as "Encounter" or "Medication". For
FHIR-based eCQMs using the QI-Core profiles, these will be the author-friendly identifiers for the QI-Core profile. Data
types referenced in CQL libraries to be included in a Measure must conform to Conformance Requirement 29.

**Conformance Requirement 29 (Data Type Names):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-29)
{: #conformance-requirement-29}

1. Data type names referenced in CQL SHALL:<br/>
       a. Use quoted identifiers<br/>
       b. Use PascalCase plus appropriate spacing

For example:

```cql
define "Flexible Sigmoidoscopy Performed":
  [Procedure: "Flexible Sigmoidoscopy"] FlexibleSigmoidoscopy
    where FlexibleSigmoidoscopy.status = 'completed'
      and FlexibleSigmoidoscopy.performed ends 5 years or less on or before end of "Measurement Period"
```

Snippet 4-9: Expression definition from [EXM130_FHIR-7.2.000.cql](cql/EXM130_FHIR-7.2.000.cql)

### 4.8.1 Negation in FHIR
{: #negation-in-fhir}

Two commonly used patterns for negation in quality measurement are:

* Absence of evidence for a particular event
* Documentation of an event not occurring, together with a reason

For the purposes of quality measurement, when looking for documentation that a particular event did not occur, it must
be documented with a reason in order to meet the intent. If a reason is not part of the intent, then the absence of
evidence pattern should be used, rather than documentation of an event not occurring.

To address the reason an action did not occur (negation rationale), the eCQM must define the event it expects to occur
using appropriate terminology to identify the kind of event (using a value set or direct reference code), and then use
additional criteria to indicate that the event did not occur, as well as identifying a reason.

The following examples differentiate methods to indicate (a) presence of evidence of an action, (b) absence of evidence
of an action, and (c) negation rationale for not performing an action. In each case, the "action" is an administration
of medication included within a value set for "Antithrombotic Therapy".

#### 4.8.1.1 Presence
{: #presence}

Evidence that "Antithrombotic Therapy" (defined by a medication-specific value set) was administered:

    define "Antithrombotic Administered":
      ["MedicationAdministration": "Antithrombotic Therapy"] AntithromboticTherapy
        where AntithromboticTherapy.status = 'completed'
          and AntithromboticTherapy.category = "Inpatient Setting"

#### 4.8.1.2 Absence
{: #absence}

No evidence that "Antithrombotic Therapy" medication was administered:

    define "No Antithrombotic Therapy":
      not exists (
        ["MedicationAdministration": "Antithrombotic Therapy"] AntithromboticTherapy
          where AntithromboticTherapy.status = 'completed'
            and AntithromboticTherapy.category = "Inpatient Setting"
      )

#### 4.8.1.3 Negation Rationale
{: #negation-rationale}

Evidence that "Antithrombotic Therapy" medication administration did not occur for an acceptable medical reason as
defined by a value set referenced by the eCQM (i.e., negation rationale):

    define "Antithrombotic Not Administered":
      ["MedicationAdministration": "Antithrombotic Therapy"] NotAdministered
        where NotAdministered.notGiven is true
          and NotAdministered.reasonNotGiven in "Medical Reason"

In this example for negation rationale, the logic looks for a member of the value set "Medical Reason" as the rationale
for not administering any of the anticoagulant and antiplatelet medications specified in the "Antithrombotic Therapy"
value set. To report Antithrombotic Therapy Not Administered, this is done by referencing uri of the "Antithrombotic
Therapy" value set using the [value set extension](http://hl7.org/fhir/extension-valueset-reference.html) to indicate
providers did not administer any of the medications in the "Antithrombotic Therapy" value set. By referencing the value
set uri to negate the entire value set rather than reporting a specific member code from the value set, clinicians are
not forced to having to arbitrarily select a specific medication from the "Antithrombotic Therapy" value set that they
did not administer in order to negate.

Similarly, to report "Procedure, Not Performed": "Cardiac Surgery" with a reason, the uri of "Cardiac Surgery" value set
is referenced by using the value set extension to indicate providers did not perform any of the cardiac surgery
specified in the "Cardiac Surgery" value set.

### 4.9 Attribute Names
{: #attribute-names}

All attributes referenced in the CQL follow Conformance Requirement 30.

**Conformance Requirement 30 (Attribute Names):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-30)
{: #conformance-requirement-30}

1. Data model attributes referenced in the CQL:<br/>
      a. SHALL NOT Use quoted identifiers<br/>
      b. SHALL Use camelCase

Examples of attributes conforming to Conformance Requirement 30 are given below. For a full list of valid of attributes, refer to an appropriate data model specification such as QI-Core.

```cql
period
authoredOn
result
```

### 4.10 Aliases and Argument Names
{: #aliases-and-argument-names}

Aliases are used in CQL as local variable names to refer to sections of code. When defining a function, argument names
are used to create scoped variables that refer to the function inputs. Both aliases and argument names conform to
Conformance Requirement 31.

**Conformance Requirement 31 (Aliases and Argument Names):** [<img src="assets/images/conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-31)
{: #conformance-requirement-31}

1. Aliases and argument names referenced in the CQL:<br/>
      a. SHALL NOT Use quoted identifiers<br/>
      b. SHALL Use PascalCase<br/>
      c. SHOULD Use descriptive names (no abbreviations)

For example:

```cql
define "Encounters During Measurement Period":
    "Valid Encounters" QualifyingEncounter
        where QualifyingEncounter.period during "Measurement Period"

define function "ED Stay Time"(Encounter "Encounter"):
    duration in minutes of Encounter.period
```

## 4.11 Translation to ELM
{: #translation-to-elm}

Tooling exists to support translation of CQL to ELM for distribution in XML or JSON formats. These distributions are
included with eCQMs to facilitate implementation. The existing translator tooling applies to both measure and decision
support development, and has several options available to make use of different data models in different environments.
For measure development with FHIR, the following options are recommended:

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
