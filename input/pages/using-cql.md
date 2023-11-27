{:toc}

### Libraries
{: #libraries}

A CQL artifact is referred to as a library.

**Conformance Requirement 4.1 (Library Declaration):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-1)
{: #conformance-requirement-4-1}
  1. Any CQL library referenced by a Measure must contain a library declaration line as the first line of the library.
  2. The library identifier SHALL be a valid un-quoted identifier and SHALL NOT contain underscores
  3. The library declaration line SHALL contain a version number.
  4. The library version number SHALL follow the convention :  
       < major >.< minor >.< patch >

#### Library Versioning
{: #library-versioning}

This IG recommends an approach to versioning libraries used within Measures to help track and manage dependencies.
The approach recommended here is based on the [Semantic Versioning Scheme.](https://semver.org/)

**Conformance Requirement 4.2 (Library Versioning):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-2)
{: #conformance-requirement-4-2}
  1. For artifacts in draft status, the versioning scheme SHALL NOT apply, and there is no expectation that artifact contents are stable
  2. The versioning scheme SHALL apply when an artifact moves to active status.

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

```xml
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

Snippet 4-1: Library line from EXM146.cql, the second major version.

#### Nested Libraries
{: #nested-libraries}

CQL allows libraries to re-use logic already defined in other libraries. This is accomplished by utilizing the
include line as in Snippet 4-2.

```cql
includes Common version '2.0.0' called Common
```

Snippet 4-2: Nested library within [EXM146.cql](Library-EXM146-FHIR.html#cql-content)

The set of all CQL libraries used to define a Measure must adhere to Conformance Requirement 4.3.

**Conformance Requirement 4.3 (Nested Libraries):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-3)
{: #conformance-requirement-4-3}

1. CQL libraries SHALL be structured such that all CQL expressions referenced by the Measure population criteria are
contained within a single library.
2. CQL libraries SHALL use a `called` clause for all included libraries
3. The `called`-alias for an included library SHOULD be consistent for usages across libraries

Because of this conformance statement, the primary library for a measure can always be determined by looking at the
library referenced by the initial population criteria for the measure.

#### Library Namespaces
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

**Conformance Requirement 4.4 (Library Namespaces):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-4)
{: #conformance-requirement-4-4}

1. CQL libraries SHOULD use namespaces.
2. When a namespace is not used, the library SHALL be considered part of a "public" global namespace for the purposes of resolution within a given environment.

In addition, because the namespace of a library is part of the text, changing the namespace of a library requires a new version, just like any other change to the text of the library. However, because a change to the namespace is not a material change to the library itself, changing the namespace does not require a different version-independent identifier to be used for the library.

### Data Model
{: #data-model}

CQL can be used with any data model. In the context of a Measure, any referenced CQL library must identify the same data model.


**Conformance Requirement 4.5 (CQL Data Model):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-5)
{: #conformance-requirement-4-5}

1. All libraries and CQL expressions used directly or indirectly within a measure SHALL use FHIR based data models. For example, one could use QI Core and SDOH IGs.
2. Data Model declarations SHALL include a version declaration.

For example:

```cql
using FHIR version '3.0.0'
```

Snippet 4-3: Data Model line from [EXM146.cql](Library-EXM146-FHIR.html#cql-content)

### Code Systems
{: #code-systems}

Conformance Requirement 4.6 describes how to specify a code system within a CQL library.

**Conformance Requirement 4.6 (Code System Specification):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-6)
{: #conformance-requirement-4-6}

1. Within CQL, the identifier of any code system reference SHALL be specified using a URI for the code system.
2. The URI SHALL be the canonical URL for the code system
3. The Code System declaration MAY include a version, consistent with the URI specification for FHIR and the code system

For example:

```cql
codesystem "SNOMED CT:2017-09": 'http://snomed.info/sct'
  version 'http://snomed.info/sct/731000124108/version/201709'
```

Snippet 4-4: codesystem definition line from [Terminology.cql](Library-Terminology-FHIR.html#cql-content).

The canonical URL for a code system is a globally unique, stable, version-independent identifier for the code system.
The base FHIR specification defines canonical URLs for most common code systems
[here](http://hl7.org/fhir/R4/terminologies-systems.html).

The local identifier for the codesystem ("SNOMED CT:2017-09" in this case) should include the friendly name of the code system
and optionally, an indication of the version, separated with a colon.

Version information for code systems is not required to be included in QMs; terminology versioning information may be
specified externally. However, if versioning information is included, it must be done in accordance with the terminology
usage specified by FHIR.

If no version is specified, then the default behavior for a FHIR terminology server is to use the most recent code
system version available on the server.

### Value Sets
{: #value-sets}

Conformance Requirement 4.7 describes how to specify a valueset within a CQL library.

**Conformance Requirement 4.7 (Value Set Specification):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-7)
{: #conformance-requirement-4-7}

1. Within CQL, the identifier of any value set reference SHALL be specified using a URI for the value set.
2. The URI SHALL be the canonical URL for the value set
3. The URI MAY include a version, consistent with versioned canonical URL references in FHIR

For example:

```cql
valueset "Acute Pharyngitis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.102.12.1011'
```

Snippet 4-5: Valueset reference from [EXM146.cql](Library-EXM146-FHIR.html#cql-content)

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

```
GET fhir/ValueSet?url=http%3A%2F%2Fcts.nlm.nih.gov%2Ffhir%2FValueSet%2F2.16.840.1.113883.3.464.1003.102.12.1011.1
```

#### Value Set Version
{: #value-set-version}

Version information for value sets is not required to be included in QMs; terminology versioning information may be
specified externally. However, if versioning information is included, it must be done in accordance with the terminology
usage specified by FHIR.

Conformance Requirement 4.8 describes how to retrieve an expansion of a value set by version.

**Conformance Requirement 4.8 (Value Set Specification By Version):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-8)
{: #conformance-requirement-4-8}

1. When retrieving the expansion of a value set by version, append the version identifier to the canonical URL of the
value set, separated by a pipe (`|`)

For example:

```cql
valueset "Encounter Inpatient SNOMEDCT Value Set":
   'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.7.307|20160929'
```

Snippet 4-6: valueset definition from [Terminology.cql](Library-Terminology-FHIR.html#cql-content).

This is a _version specific value set reference_, and can be resolved as a search by the `url` and `version` elements:

```
GET fhir/ValueSet?url=http%3A%2F%2Fcts.nlm.nih.gov%2Ffhir%2FValueSet%2F2.16.840.1.113883.3.666.7.307&version=20160929
```

#### Value Set Expansion

It is important to maintain the distinction between the _definition_ of a value set and the _expansion_ of a value set. The searches
described in previous sections all retrieve the definition of a value set. For the purposes of local evaluation, implementations may
wish to retrieve the _expansion_ of a value set, or the set of all codes that are defined to be in the value set by the _definition_.

Because the definition of a value set can, and often does, include codes from a code system based on properties of that code system, the
expansion of a value set is sensitive to the versions of the code systems used in the definition. This means that in general, the expansion
of a value set is version-specific, and care must be taken to ensure that version considerations are taken into account when using the
results of an expansion.

**Conformance Requirement 4.9 (Value Set Expansion):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-9)
{: #conformance-requirement-4-9}

1. Valueset membership testing SHOULD use the terminology membership operation in CQL (`in(ValueSet)`), as opposed to requiring computation on the lists of codes in a value set.  Please reference [here](http://cql.hl7.org/02-authorsguide.html#terminology-operators) for more information.

#### Representation in a Library
{: #representation-in-a-library}

The representation of valueset declarations in a Library is discussed in the
[Measure Conformance Chapter](measure-conformance.html) of this IG.

#### String-based Membership Testing
{: #string-based-membership-testing}

Although CQL allows the use of strings as input to membership testing in value sets, this capability should be
disallowed in measure CQL as it can lead to incorrect matching if the code system is ignored.

**Conformance Requirement 4.10 (String-based Membership Testing):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-10)
{: #conformance-requirement-4-10}

1. String-based membership testing SHALL NOT be used in CQL libraries

For example, given a valueset named `"Administrative Gender"`, the following CQL expression would be non-conformant:

```cql
'female' in "Administrative Gender"
```

### Codes
{: #codes}

When direct-reference codes are represented within CQL, the logical identifier is not recommended to be a URI. Instead,
the logical identifier is the code from the code system.

**Conformance Requirement 4.11 (Direct Referenced Codes):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-11)
{: #conformance-requirement-4-11}

1. When direct-reference codes are represented within CQL, the logical identifier:<br/>
     a. MUST NOT be a URI.<br/>
     b. SHALL be a code from the code system.

```cql
code "Venous foot pump, device (physical object)": '442023007' from "SNOMED CT"
```

Snippet 4-7: code definition from [Terminology.cql](Library-Terminology-FHIR.html#cql-content).

Note that for direct-reference code usage, the local identifier (in Snippet 4-7 the local identifier is "Venous foot pump,
device (physical object)") should be the same as the description of the code within the terminology in order to avoid
conflicting with any usage or license agreements with the referenced terminologies, but can be different to allow for
potential naming conflicts, as well as simplification of longer names when appropriate.

CQL supports both version-specific and version-independent specification of and comparison to direct-reference codes. The best practice is for measure authors to use version-independent direct-reference codes and comparisons unless there is a specific reason not to (such as the code is retired in the current version). Even in the case that version-specific direct-reference codes are required, best practice is still to use the equivalent (~) operator in CQL for the comparison (again, unless there is a specific reason to do version-specific comparison)

#### Representation in a Library
{: #representation-in-a-library}

When direct-reference codes are used within QMs, they will be represented in the narrative (Human-readable) as:

```html
"Assessment, Performed: Assessment of breastfeeding"
using "Venous foot pump, device (physical object) SNOMED CT Code (442023007)"
```

The representation of code declarations in a Library is discussed in [Measure Conformance Chapter](measure-conformance.html) of this IG.

### UCUM Best Practices
{: #ucum-best-practices}

Although the Unified Code for Units of Measure (UCUM) is a code system, it requires specific handling for two reasons. First, it is a grammar-based code system with an effectively infinite number of codes, so membership tests must be performed computationally, rather than just by checking for existence of a code in a list; and second, because UCUM codes are so commonly used as part of quantity values, healthcare contexts typically provide direct mechanisms for using UCUM codes.

For these reasons, within quality artifacts in general, and quality measures specifically, UCUM codes should make use of the direct mechanisms wherever possible. In CQL logic, this means using the Quantity literal, rather than declaring UCUM codes as direct-reference codes as is recommended when using codes from other code systems. For example, when accessing a Body Mass Index (BMI) observation in CQL:

```html
define "BMI in Measurement Period":
  [Observation: "BMI"] BMI
    where BMI.status in {'final', 'amended', 'corrected'}
      and BMI.effective during "Measurement Period"
      and BMI.value is not null
      and BMI.value.code = 'kg/m2'
```

Notice the use of the UCUM code directly, as opposed to declaring a CQL code for the unit:

```html
codesystem UCUM: 'http://unitsofmeasure.org'
code "kg/m2": 'kg/m2' from UCUM

define "BMI in Measurement Period":
  [Observation: "BMI"] BMI
    where BMI.status in {'final', 'amended', 'corrected'}
      and BMI.effective during "Measurement Period"
      and BMI.value is not null
      and BMI.value.code = "kg/m2"
```

### Concepts
{: #concepts}

In addition to codes, CQL supports a concept construct, which is defined as a set of codes that are all semantically
equivalent. CQL Concepts are not currently used within measure development and SHALL NOT be used within FHIR-based
QMs, except to the extent that individual codes will be implicitly converted to concepts for the purposes of
comparison with the Concept-value elements in FHIR resources.

**Conformance Requirement 4.12 (Concepts):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-12)
{: #conformance-requirement-4-12}

1. The CQL concept construct SHALL NOT be used.

### Library-level Identifiers
{: #library-level-identifiers}

A "library-level identifier" is any named expression, function, parameter, code system, value set, concept, or code
defined in the CQL. The library name referenced in the library-line, the data model, and any referenced external library
should not be considered "library-level identifiers". Library-level identifiers ought to be given a descriptive
meaningful name (avoid abbreviations) and conform to Conformance Requirement 4.13.

**Conformance Requirement 4.13 (Library-level Identifiers):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-13)
{: #conformance-requirement-4-13}

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

Snippet 4-8: Function definition from [Common.cql](Library-Common.html#cql-content)

### Data Type Names
{: #data-type-names}

A "data type" in CQL refers to any named type used within CQL expressions. They may be primitive types, such as the
system-defined "Integer" and "DateTime", or they may be model-defined types such as "Encounter" or "Medication". For
FHIR-based QMs using the QI-Core profiles, these will be the author-friendly identifiers for the QI-Core profile. Data
types referenced in CQL libraries to be included in a Measure must conform to Conformance Requirement 4.14.

**Conformance Requirement 4.14 (Data Type Names):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-14)
{: #conformance-requirement-4-14}

1. Data type names referenced in CQL SHALL:<br/>
       a. Use quoted identifiers only if necessary (i.e. the data type name includes spaces)<br/>
       b. Use PascalCase plus appropriate spacing

For example:

```cql
define "Flexible Sigmoidoscopy Performed":
  [Procedure: "Flexible Sigmoidoscopy"] FlexibleSigmoidoscopy
    where FlexibleSigmoidoscopy.status = 'completed'
      and FlexibleSigmoidoscopy.performed ends 5 years or less on or before end of "Measurement Period"
```

Snippet 4-9: Expression definition from [EXM130.cql](Library-EXM130-FHIR.html#cql-content)

#### Negation in FHIR
{: #negation-in-fhir}

Two commonly used patterns for negation in quality measurement are:

* Absence of evidence for a particular event
* Documentation of an event not occurring, together with a reason

For the purposes of quality measurement, when looking for documentation that a particular event did not occur, it must
be documented with a reason in order to meet the intent. If a reason is not part of the intent, then the absence of
evidence pattern should be used, rather than documentation of an event not occurring.

To address the reason an action did not occur (negation rationale), the QM must define the event it expects to occur
using appropriate terminology to identify the kind of event (using a value set or direct-reference code), and then use
additional criteria to indicate that the event did not occur, as well as identifying a reason.

The following examples differentiate methods to indicate (a) presence of evidence of an action, (b) absence of evidence
of an action, and (c) negation rationale for not performing an action. In each case, the "action" is an administration
of medication included within a value set for "Antithrombotic Therapy".

##### Presence
{: #presence}

Evidence that "Antithrombotic Therapy" (defined by a medication-specific value set) was administered:

```cql
define "Antithrombotic Administered":
  ["MedicationAdministration": "Antithrombotic Therapy"] AntithromboticTherapy
    where AntithromboticTherapy.status = 'completed'
      and AntithromboticTherapy.category = "Inpatient Setting"
```

##### Absence
{: #absence}

No evidence that "Antithrombotic Therapy" medication was administered:

```cql
define "No Antithrombotic Therapy":
  not exists (
    ["MedicationAdministration": "Antithrombotic Therapy"] AntithromboticTherapy
      where AntithromboticTherapy.status = 'completed'
        and AntithromboticTherapy.category = "Inpatient Setting"
  )
```

##### Negation Rationale
{: #negation-rationale}

Evidence that "Antithrombotic Therapy" medication administration did not occur for an acceptable medical reason as
defined by a value set referenced by the QM (i.e., negation rationale):

```cql
define "Antithrombotic Not Administered":
  ["MedicationAdministration": "Antithrombotic Therapy"] NotAdministered
    where NotAdministered.notGiven is true
      and NotAdministered.reasonNotGiven in "Medical Reason"
```

In this example for negation rationale, the logic looks for a member of the value set "Medical Reason" as the rationale
for not administering any of the anticoagulant and antiplatelet medications specified in the "Antithrombotic Therapy"
value set. To report Antithrombotic Therapy Not Administered, this is done by referencing the URI of the "Antithrombotic
Therapy" value set using the [value set extension](http://hl7.org/fhir/extension-valueset-reference.html) to indicate
providers did not administer any of the medications in the "Antithrombotic Therapy" value set. By referencing the value
set URI to negate the entire value set rather than reporting a specific member code from the value set, clinicians are
not forced to having to arbitrarily select a specific medication from the "Antithrombotic Therapy" value set that they
did not administer in order to negate.

Similarly, to report "Procedure, Not Performed": "Cardiac Surgery" with a reason, the URI of "Cardiac Surgery" value set
is referenced by using the value set extension to indicate providers did not perform any of the cardiac surgery
specified in the "Cardiac Surgery" value set.

### Attribute Names
{: #attribute-names}

All attributes referenced in the CQL follow Conformance Requirement 4.15.

**Conformance Requirement 4-15 (Attribute Names):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-15)
{: #conformance-requirement-4-15}

1. Data model attributes referenced in the CQL:<br/>
      a. SHALL NOT Use quoted identifiers<br/>
      b. SHALL Use camelCase

Examples of attributes conforming to Conformance Requirement 4.15 are given below. For a full list of valid of attributes, refer to an appropriate data model specification such as QI-Core.

```cql
period
authoredOn
result
```

### Aliases and Argument Names
{: #aliases-and-argument-names}

Aliases are used in CQL as local variable names to refer to sections of code. When defining a function, argument names
are used to create scoped variables that refer to the function inputs. Both aliases and argument names conform to
Conformance Requirement 4.16.

**Conformance Requirement 4.16 (Aliases and Argument Names):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-16)
{: #conformance-requirement-4-16}

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

### Library Resources
{: #library-resources}

Inclusion of CQL content used within quality measures is accomplished through the use of a Library resource. These libraries are then referenced from Measure resources using the `library` element. The content of the CQL library is included using the `content` element of the Library.

**Conformance Requirement 4.17 (Library Resources):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-17)
{: #conformance-requirement-4-17}

1. Content conforming to this implementation guide SHALL use at least the [CQFMLibrary](StructureDefinition-library-cqfm.html) profile for Library resources.

#### Library Name and URL
{: #library-name-and-url}

**Conformance Requirement 4.18 (Library Name and URL):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-18)
{: #conformance-requirement-4-18}

1. The identifying elements of a library SHALL conform to the following requirements:
* Library.url SHALL be `<CQL namepsace url>/Library/<CQL library name>`
* Library.name SHALL be `<CQL library name>`
* Library.version SHALL be `<CQL library version>`

2. For libraries included in FHIR implementation guides, the CQL namespace is defined by the implementation guide as follows:
* CQL namespace name SHALL be IG.packageId
* CQL namespace url SHALL be IG.canonicalBase

For CQL library source files, the convention SHOULD be:

```
filename = <CQL library name>.cql
```

3. To avoid issues with characters between web ids and names, library names SHALL NOT have underscores.

#### FHIR Type Mapping
{: #fhir-type-mapping}

**Conformance Requirement 4.19 (FHIR Type Mapping):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-19)
{: #conformance-requirement-4-19}

1. CQL defined types SHALL map to types in FHIR according to the following mapping:

|CQL System Type |FHIR Type |
|---|---|
|`System.Boolean`|`FHIR.boolean`|
|`System.Integer`|`FHIR.integer`|
|`System.Decimal`|`FHIR.decimal`|
|`System.Date`|`FHIR.date`|
|`System.DateTime`|`FHIR.dateTime`|
|`System.Time`|`FHIR.time`|
|`System.String`|`FHIR.string`|
|`System.Quantity`|`FHIR.Quantity`|
|`System.Ratio`|`FHIR.Ratio`|
|`System.Any`|`FHIR.Any`|
|`System.Code`|`FHIR.Coding`|
|`System.Concept`|`FHIR.CodeableConcept`|
|`Interval<System.Date>`|`FHIR.Period`|
|`Interval<System.DateTime>`|`FHIR.Period`|
|`Interval<System.Quantity>`|`FHIR.Range`|

2. In addition:
* List types SHALL be lists of element types that map to FHIR
* Tuple types SHALL consist only of elements of types that map to FHIR

#### Parameters and Data Requirements
{: #parameters-and-data-requirements}

**Conformance Requirement 4.20 (FHIR Type Mapping):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-20)
{: #conformance-requirement-4-20}

1. Parameters to CQL libraries SHALL be either CQL-defined types that map to FHIR types, or FHIR resource types, optionally with profile designations.
2. Top level expressions in CQL libraries SHALL return either CQL-defined types that map to FHIR types, or FHIR resources types, optionally with profile designations
3. Tuple types are represented with Parameters that have `part` elements corresponding to the elements of the tuple. List types are represented with Parameters that have a cardinality of 0..*.
4. Libraries used in computable guideline content SHALL use the `parameter` element to identify input parameters as well as the type of all top-level expressions as output parameters.
5. Libraries used in computable guideline content SHALL use the `dataRequirement` element to identify any retrieves present in the CQL:

|Retrieve Element|DataRequirement Element|
|---|---|
|dataType|type|
|templateId|profile|
|context|subject|
|codeProperty|codeFilter.path or codeFilter.searchParam|
|codes (Concept)|codeFilter.code (for each Code present in the Concept)|
|codes (Code)|codeFilter.code|
|codes (ValueSetRef)|codeFilter.valueSet (as specified by the `id` of the ValueSetDef referenced by the ValueSetRef)|
|dateProperty|dateFilter.path|
|dateLowProperty,dateHighProperty|dateFilter.path (resolved to an interval-valued property)|
|dateRange|dateFilter.path or dateFilter.searchParam|

#### RelatedArtifacts
{: #relatedartifacts}

**Conformance Requirement 4.21 (Related Artifacts):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-21)
{: #conformance-requirement-4-21}

1. Libraries used in computable guideline content SHALL use the `relatedArtifact` element to identify includes, code systems, value sets, and data models used by the CQL library:

|Dependency|RelatedArtifact representation|
|Data Model (using declaration)|`depends-on` with `url` of the ModelInfo Library (e.g. `http://hl7.org/fhir/Library/FHIR-ModelInfo|4.0.1`)|
|Library (include declaration)|`depends-on` with `url` of the Library (e.g. `http://hl7.org/fhir/Library/FHIRHelpers|4.0.1`)|
|Code System|`depends-on` with `url` of the CodeSystem (e.g. `http://loing.org`)|
|Value Set|`depends-on` with `url` of the ValueSet (e.g. `http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1116.89`)|

#### MIME Type version
The version of CQL/ELM used for content in a library should be specified using the version parameter of the text/cql and application/elm+xml, application/elm+json media types.

* `text/cql; version=1.4`
* `application/elm+xml; version=1.4`
* `application/elm+json; version=1.4`

Resource narratives for Libraries and Measures that use CQL should include the CQL version if it is specified in the MIME type as shown above.

### Use of Terminologies
{: #use-of-terminologies}

FHIR supports various types of terminology-valued elements, including:

* [code](http://hl7.org/fhir/datatypes.html#code)<br/>
* [Coding](http://hl7.org/fhir/datatypes.html#Coding)<br/>
* [CodeableConcept](http://hl7.org/fhir/datatypes.html#CodeableConcept)<br/>

These types correspond directly to the CQL primitive types:

* [String](https://cql.hl7.org/09-b-cqlreference.html#string-1)<br/>
* [Code](https://cql.hl7.org/09-b-cqlreference.html#code-1)<br/>
* [Concept](https://cql.hl7.org/09-b-cqlreference.html#concept-1)<br/>

In addition to the type of element, FHIR provides the ability to bind these elements to specific codes, in the form of a direct-reference code (constraint to a specific code in a [CodeSystem](http://hl7.org/fhir/codesystem.html)), or a binding to a [ValueSet](http://hl7.org/fhir/valueset.html). These bindings can be different [binding strengths](http://hl7.org/fhir/codesystem-binding-strength.html)

* [required](http://hl7.org/fhir/terminologies.html#required) - To be conformant, the concept in this element SHALL be from the specified value set.<br/>
* [extensible](http://hl7.org/fhir/terminologies.html#extensible) - To be conformant, the concept in this element SHALL be from the specified value set if any of the codes within the value set can apply to the concept being communicated. If the value set does not cover the concept (based on human review), alternate codings (or, data type allowing, text) may be included instead.</br>
* [preferred](http://hl7.org/fhir/terminologies.html#preferred) - Instances are encouraged to draw from the specified codes for interoperability purposes but are not required to do so to be considered conformant.<br/>
* [example](http://hl7.org/fhir/terminologies.html#example) - Instances are not expected or even encouraged to draw from the specified value set. The value set merely provides examples of the types of concepts intended to be included.<br/>

Within CQL, references to terminology code systems, value sets, codes, and concepts are directly supported, and all such usages are declared within CQL libraries, as described in the  [Terminology](https://cql.hl7.org/02-authorsguide.html#terminology) section of the CQL Author's Guide.

When referencing terminology-valued elements within CQL, the following comparison operations are supported:

* [Equal (`=`)](https://cql.hl7.org/09-b-cqlreference.html#equal-3)<br/>
* [Equivalent (`~`)](https://cql.hl7.org/09-b-cqlreference.html#equivalent-3)<br/>
* [In (`in`)](https://cql.hl7.org/09-b-cqlreference.html#in-valueset)<br/>

### Time Valued Quantities
{: #time-valued-quantities}

For time-valued quantities, in addition to the definite duration UCUM units, CQL defines calendar duration keywords to support calendar-based durations and arithmetic. For example, UCUM defines an annum ('a') as 365.25 days, whereas the year ('year') duration in CQL is specifically a calendar year. This difference is important, especially when performing calendar arithmetic.

For example if we take a datetime and subtract a calendar year
```cql
@2019-01-01T05:00:00 - 1 year
```
This would resolve to 2018-01-01T05:00:00

However, if we take the same datetime and subtract a UCUM annum
```cql
@2019-01-01T05:00:00 - 1 'a'
```
This would resolve to 2017-12-31T23:00:00

See the definition of the [Quantity](https://cql.hl7.org/2020May/02-authorsguide.html#quantities) type in the CQL Author's Guide, as well as the [Date/Time Arithmetic](https://cql.hl7.org/2020May/02-authorsguide.html#datetime-arithmetic) discussion for more information.

### Translation to ELM
{: #translation-to-elm}

Tooling exists to support translation of CQL to ELM for distribution in XML or JSON formats. These distributions are
included with QMs to facilitate implementation. [The existing translator tooling](https://github.com/cqframework/clinical_quality_language/blob/master/Src/java/cql-to-elm/OVERVIEW.md) applies to both measure and decision
support development, and has several options available to make use of different data models in different environments.
For measure development with FHIR, the following options are recommended:

| Option                                         | Description                                                                                                                                                                                   | Recommendation                                                                                                                                                                                                                                 |
|------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| EnableAnnotations                              | This instructs the translator to include the source CQL as an annotation within the ELM.                                                                                                      | This option should be used to ensure that the distributed ELM could be linked back to the source CQL.                                                                                                                                          |
| EnableLocators                                 | This instructs the translator to include line number and character information for each ELM node.                                                                                             | This option should be used to ensure that distributed ELM could be tied directly to the input source CQL.                                                                                                                                      |
| DisableListDemotion                            | This instructs the translator to disallow demotion of list-valued expressions to singletons. The list demotion feature of CQL is used to enable functionality related to use with FHIRPath.   | This option should be used with Measures to ensure list demotion does not occur unexpectedly.                                                                                                                                                  |
| DisableListPromotion                           | This instructs the translator to disallow promotion of singletons to list-valued expressions. The list promotion feature of CQL is used to enable functionality related to use with FHIRPath. | This option should be used with Measures to ensure list promotion does not occur unexpectedly.                                                                                                                                                 |
| DisableMethodInvocation                        | This instructs the translator to disallow method-style invocation. The method-style invocation feature of CQL is used to enable functionality related to use with FHIRPath.                   | This option should not be used with FHIR-based measures because it prevents the use of the fluent functions feature of CQL 1.5, which can be used to significantly improve readability of measure logic, especially when accessing extensions. |
| EnableDateRangeOptimization                    | This instructs the translator to optimize date range filters by moving them inside retrieve expressions.                                                                                      | This feature may be used with Measures.                                                                                                                                                                                                        |
| EnableResultTypes                              | This instructs the translator to include inferred result types in the output ELM.                                                                                                             | This feature may be used with Measures.                                                                                                                                                                                                        |
| EnableDetailedErrors                           | This instructs the translator to include detailed error information. By default, the translator only reports root-cause errors.                                                               | This feature should not be used with Measures.                                                                                                                                                                                                 |
| DisableListTraversal                           | This instructs the translator to disallow traversal of list-valued expressions. With Measures, disabling this feature would prevent a useful capability.                                      | This feature should not be used with Measures.                                                                                                                                                                                                 |
| <span class="bg-success">SignatureLevel</span> | <span class="bg-success">The SignatureLevel setting controls whether the `signature` element of a FunctionRef will be populated.</span>                                                       | <span class="bg-success">The SignatureLevel should be `Overloads` or `All` {} </span>                                                                                                                                                                                   |

#### Specifying Options

This implementation guide defines the [cqlOptions](StructureDefinition-cqfm-cqlOptions.html) extension to support defining the expected translator options used with a given Library, or set of Libraries. When this extension is not used, the recommended options above, <span class="bg-success">including SignatureLevel,</span> SHOULD be used. When this extension is present on a [CQFComputableLibrary](StructureDefinition-computable-library-cqfm.html), it SHALL be used to provide options to the translator when translating CQL for that library. When this extension is present on a [CQFMQualityProgram](StructureDefinition-quality-program-cqfm.html), it SHALL be used to provide options to the translator unless the options are provided directly by the library.

**Conformance Requirement 4.22 (Translator Options):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-22)
{: #conformance-requirement-4-22}

1. Translator options SHOULD be provided in either a CQFMComputableLibrary or a CQFMQualityProgram
2. Translator options specified in a CQFMComputableLibrary take precedence over options defined in a CQFMQualityProgram
3. If no translator options are provided, the recommended options above SHOULD be used
4. If translator options are provided in a Library that is both computable and executable, the options SHALL be consistent with the translator options reported by the ELM content

The `cqlOptions` extension references a contained `Parameters` resource that contains a parameter for each option specified, as well as a `translatorVersion` parameter that indicates the version of the translator used to produce the ELM. For example:

```json
{
  "resourceType": "Library",
  "id": "FHIRCommon",
  "meta": {
    "profile": [ "http://hl7.org/fhir/uv/crmi/StructureDefinition/crmi-computablelibrary" ]
  },
  "contained": [ {
    "resourceType": "Parameters",
    "id": "options",
    "parameter": [ {
      "name": "translatorVersion",
      "valueString": "2.9.0-SNAPSHOT"
    }, {
      "name": "option",
      "valueString": "EnableAnnotations"
    }, {
      "name": "option",
      "valueString": "EnableLocators"
    }, {
      "name": "option",
      "valueString": "DisableListDemotion"
    }, {
      "name": "option",
      "valueString": "DisableListPromotion"
    }, {
      "name": "format",
      "valueString": "XML"
    }, {
      "name": "format",
      "valueString": "JSON"
    }, {
      "name": "analyzeDataRequirements",
      "valueBoolean": true
    }, {
      "name": "collapseDataRequirements",
      "valueBoolean": true
    }, {
      "name": "compatibilityLevel",
      "valueString": "1.5"
    }, {
      "name": "enableCqlOnly",
      "valueBoolean": false
    }, {
      "name": "errorLevel",
      "valueString": "Info"
    }, {
      "name": "signatureLevel",
      "valueString": "None"
    }, {
      "name": "validateUnits",
      "valueBoolean": true
    }, {
      "name": "verifyOnly",
      "valueBoolean": false
    } ]
  } ],
  "extension": [ {
    "url": "http://hl7.org/fhir/StructureDefinition/cqf-cqlOptions",
    "valueReference": {
      "reference": "#options"
    }
  } ],
  "url": "http://ecqi.healthit.gov/ecqms/Library/FHIRCommon",
  "version": "4.1.000",
  "name": "FHIRCommon",
  ...
}
```

#### ELM Suitability

Because certain translator options impact language features and functionality, translated ELM may not be suitable for use in all contexts if the options used to produce the ELM are inconsistent with the options in use in the evaluating environment. To determine suitability of ELM for use in a given environment, the following guidance should be followed:

**Conformance Requirement 4.23 (ELM Suitability):** [<img src="conformance.png" width="20" class="self-link" height="20"/>]
{: #conformance-requirement-4-23}

1. If the library has function overloads (i.e. function definitions with the same name and different argument lists), the ELM SHALL <span class="bg-success">be</span> translated with a SignatureLevel other than `None` <span class="bg-success">(recommend OVERLOADS)</span>
2. If the evaluation environment or the ELM translator options have a compatibility level set, the compatibility level of the environment SHALL be consistent with the compatibility level used to produce the ELM
3. If the ELM has a compatibility level set, it SHALL be consistent with the version of the translator used in the evaluation environment
4. The translator version used to produce the ELM SHOULD be consistent with the translator version used in the evaluation environment
5. The translator options used in the evaluation environment SHALL be consistent with the translator options used to produce the ELM for at least the following options:
    * DisableListTraversal
    * DisableListDemotion
    * DisableListPromotion
    * EnableIntervalDemotion
    * EnableIntervalPromotion
    * DisableMethodInvocation
    * RequireFromKeyword
6. For authoring environments, the following additional translator options MAY be used to determine suitability of available ELM:
    * EnableAnnotations
    * EnableLocators
    * EnableResultTypes
