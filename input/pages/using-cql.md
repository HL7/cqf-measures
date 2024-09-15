{:toc}

This topic discusses the use of Clinical Quality Language (CQL) to provide computable and/or executable representation of the various criteria of a measure through the expression-valued elements of the Measure resource. The [CQLMeasure](StructureDefinition-cql-measure-cqfm.html) and [ELMMeasure](StructureDefinition-elm-measure-cqfm.html) profiles define the expectations for measures that make use of CQL and/or ELM. Support for the use of other expression languages is possible, but is out of scope for this implementation guide.

Measures that use CQL do so with libaries to contain the logic used to define the various criteria of the measure. CQL libraries are used in accordance with the [Using CQL With FHIR]({{site.data.fhir.ver.cql}}) (UCWF) implementation guide, as well as additional conformance requirements specific to the use of measures, as detailed in the following sections.

> For ease of reference, conformance requirements from the Using CQL With FHIR IG are referred to with the following notation: UCWF:2.1, which refers to Conformance Requirement 2.1 in the Using CQL With FHIR implementation guide.

### Libraries
{: #libraries}

Consistent with the UCWF IG, Measures that make use of CQL use [Libraries]({{site.data.fhir.ver.cql}}/using-cql.html#libraries).

**Conformance Requirement 4.1 (Library Usage):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-1)
{: #conformance-requirement-4-1}
  1. CQL used by a Measure SHALL be contained in a CQL library
  2. CQL libraries used by Measures SHALL conform to [UCWF:2.1 (Library Declaration)]({{site.data.fhir.ver.cql}}/using-cql.html#conformance-requirement-2-1)

For example:

```cql
library EXM146 version '4.0.0'
```

Snippet 4-1: Library line from [EXM146.cql](Library-EXM146-FHIR.html#cql-content)

#### Library Versioning
{: #library-versioning}

Consistent with the UCWF IG, this IG recommends an approach to [Library Versioning]({{site.data.fhir.ver.cql}}/using-cql.html#library-versioning) used within Measures to help track and manage dependencies.
The approach recommended here is based on the [Semantic Versioning Scheme](https://semver.org/).

**Conformance Requirement 4.2 (Library Versioning):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-2)
{: #conformance-requirement-4-2}
  1. CQL libraries used by Measures SHALL include a version as part of the library declaration
  1. CQL libraries used by Measures SHALL conform to [UCWF:2.2 (Library Versioning)]({{site.data.fhir.ver.cql}}/using-cql.html#conformance-requirement-2-2)
  2. In addition, CQL libraries used by Measures SHALL follow the convention :
    < major >.< minor >.< patch >
  3. For measures in _draft_ status, a version label MAY be included
    1. If a version label is included, it SHALL follow the convention:
      < major >.< minor >.< patch >-< label >

For example:

```cql
library EXM146 version '3.0.0'
```

This would indicate the first major version of the EXM146 library. A minor change could be released by incrementing the
minor version:

```cql
library EXM146 version '3.1.0'
```

And a major change could be released by incrementing the major version, and resetting the minor version: Minor changes
are expected to retain backwards-compatibility, but may introduce new features and functionality, while patch changes
are expected to retain forward and backwards-compatibility, and may only be used to fix issues.

```cql
library EXM146 version '4.0.0'
```

Snippet 4-2: Library line from [EXM146.cql](Library-EXM146-FHIR.html#cql-content), the fourth major version.

#### Nested Libraries
{: #nested-libraries}

Consistent with the UCWF IG, this IG allows measures to use [Nested Libraries]({{site.data.fhir.ver.cql}}/using-cql.html#nested-libraries). However, this IG requires that all expressions referenced from a Measure be included in a single library to ensure that expression identifiers used in the Measure need not be qualified identifiers.

**Conformance Requirement 4.3 (Nested Libraries):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-3)
{: #conformance-requirement-4-3}
  1. CQL libraries used by measures SHALL conform to [UCWF:2.3 (Nested Libraries)]({{site.data.fhir.ver.cql}}/using-cql.html#conformance-requrement-2-3)
  2. In addition, CQL libraries used by measures SHALL be structured such that all CQL expressions referenced by the Measure are contained within a single library.

For example:

```cql
include Common version '2.0.0' called Common
```

Snippet 4-3: Nested library within [EXM146.cql](Library-EXM146-FHIR.html#cql-content)

#### Library Namespaces
{: #library-namespaces}

Consistent with the UCWF IG, this IG recommends the use of [Library Namespaces]({{site.data.fhir.ver.cql}}/using-cql.html#library-namespaces).

**Conformance Requirement 4.4 (Library Namespaces):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-4)
{: #conformance-requirement-4-4}
  1. CQL libraries used by Measures SHALL conform to [UCWF:2.4 (Library Namespaces)]({{site.data.fhir.ver.cql}}/using-cql.html#conformance-requirement-2-4)

For example, the following library declaration illustrates the use of a namespace:

```cql
library CMS.Common version '2.0.0'
```

Snippet 4-4: Library namespace

### Data Model
{: #data-model}

CQL can be used with any [Data Model]({{site.data.fhir.ver.cql}}/using-cql#data-model). In the context of a Measure, any referenced CQL library must identify the same data model.

**Conformance Requirement 4.5 (CQL Data Model):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-5)
{: #conformance-requirement-4-5}
1. CQL libraries used by Measures SHALL conform to [UCWF:2.5 (Data Models)]({{site.data.fhir.ver.cql}}/using-cql.html#conformance-requirement-2-5)
1. All libraries and CQL expressions used directly or indirectly within a measure SHALL use FHIR based data models. For example, one could use QI Core and SDOH IGs.
2. Data Model declarations SHALL include a version declaration.

For example:

```cql
using FHIR version '4.0.1'
```

Snippet 4-5: Data Model line from [EXM146.cql](Library-EXM146-FHIR.html#cql-content)

### Code Systems
{: #code-systems}

Consistent with the UCWF IG, [Code Systems]({{site.data.fhir.ver.cql}}/using-cql.html#code-systems) referenced within CQL expressions make use of the `codesystem` declaration in CQL.

**Conformance Requirement 4.6 (Code System Specification):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-6)
{: #conformance-requirement-4-6}
1. CQL libraries used by Measures SHALL conform to [UCWF:2.6 (Code System Specification)]({{site.data.fhir.ver.cql}}/using-cql.html#conformance-requirement-2-6)

For example:

```cql
codesystem "SNOMED CT:2017-09": 'http://snomed.info/sct'
  version 'http://snomed.info/sct/731000124108/version/201709'
```

Snippet 4-6: codesystem definition line from [Terminology.cql](Library-Terminology-FHIR.html#cql-content).

#### Representation in a Library
{: #representation-in-a-library}

The representation of codesystem declarations in a Library is discussed in the [Terminology](measure-conformance.html#terminology) topic of Measure Conformance in this IG.

### Value Sets
{: #value-sets}

Consistent with the UCWF IG, [Value Sets]({{site.data.fhir.ver.cql}}/using-cql.html#value-sets) referenced within CQL expressions make use of the `valueset` declaration in CQL.

**Conformance Requirement 4.7 (Value Set Specification):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-7)
{: #conformance-requirement-4-7}
1. CQL libraries used by Measures SHALL conform to [UCWF:2.7 (Value Set Specification)]({{site.data.fhir.ver.cql}}/using-cql.html#conformance-requirement-2-7)

For example:

```cql
valueset "Acute Pharyngitis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.102.12.1011'
```

Snippet 4-7: Valueset reference from [EXM146.cql](Library-EXM146-FHIR.html#cql-content)

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

Snippet 4-8: Valueset declarations for different value sets with the same name

Note carefully that although this URL may be resolveable for some terminology implementations, this is not necessarily the
case. This use of a canonical URL can be resolved as a search by the `url` element:

```
GET fhir/ValueSet?url=http%3A%2F%2Fcts.nlm.nih.gov%2Ffhir%2FValueSet%2F2.16.840.1.113883.3.464.1003.102.12.1011.1
```

Snippet 4-9: FHIR API query to retrieve a value set by it's canonical identifier using the url search parameter

#### Value Set Version
{: #value-set-version}

Consistent with the UCWF IG, [Value Set Version]({{site.data.fhir.ver.cql}}/using-cql#value-set-version) information is not required to be included. As a best-practice, terminology versioning information is specified externally using a version manifest. However, if versioning information is included, it must be done in accordnace with terminology usage specified by FHIR.

**Conformance Requirement 4.8 (Value Set Specification By Version):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-8)
{: #conformance-requirement-4-8}
1. CQL libraries used by Measures SHALL conform to [UCWF:2.8 (Value Set Specification Including Version)]({{site.data.fhir.ver.cql}}/using-cql.html#conformance-requirement-2-8)

For example:

```cql
valueset "Encounter Inpatient SNOMEDCT Value Set":
   'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.7.307|20160929'
```

Snippet 4-10: valueset definition from [Terminology.cql](Library-Terminology-FHIR.html#cql-content).

This is a _version specific value set reference_, and can be resolved as a search by the `url` and `version` elements:

```
GET fhir/ValueSet?url=http%3A%2F%2Fcts.nlm.nih.gov%2Ffhir%2FValueSet%2F2.16.840.1.113883.3.666.7.307&version=20160929
```

Snippet 4-11: FHIR API query to retrieve a value set by it's url and version

#### Value Set Expansion

Measures that make use of CQL must do so in accordance with [Value Set Expansion]({{site.data.fhir.ver.cql}}/using-cql#value-set-expansion) as described in the UCWF IG.

**Conformance Requirement 4.9 (Value Set Expansion):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-9)
{: #conformance-requirement-4-9}
1. CQL libraries used by Measures SHALL conform to [UCWF:2.9 (Value Set Expansion)]({{site.data.fhir.ver.cql}}/using-cql.html#conformance-requirement-2-9)

#### Representation in a Library
{: #representation-in-a-library}

The representation of `valueset` declarations in a Library is discussed in the [Terminology](measure-conformance.html#terminology) topic of Measure Conformance in this IG, consistent with the [Representation in Narrative]({{site.data.fhir.ver.cql}}/using-cql.html#valueset-representation-in-narrative) topic in the UCWF IG.

#### String-based Membership Testing
{: #string-based-membership-testing}

Consistent with the UCWF IG, this implementation guide recommends against the use of [_string-based membership testing_]({{site.data.fhir.ver.cql}}/using-cql.html#string-based-membership-testing).

**Conformance Requirement 4.10 (String-based Membership Testing):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-10)
{: #conformance-requirement-4-10}
1. CQL libraries used by Measures SHALL conform to [UCWF:2.10 (String-based Membership Testing)]({{site.data.fhir.ver.cql}}/using-cql.html#conformance-requirement-2-10)

### Codes
{: #codes}

Consistent with the UCWF IG, CQL used with Measures can make use of [_direct-reference codes_]({{site.data.fhir.ver.cql}}/using-cql.html#codes).

**Conformance Requirement 4.11 (Direct-reference Codes):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-11)
{: #conformance-requirement-4-11}
1. CQL libraries used by Measures SHALL conform to [UCWF:2.11 (Direct-reference Codes)]({{site.data.fhir.ver.cql}}/using-cql.html#conformance-requirement-2-11)

For example:

```cql
code "Venous foot pump, device (physical object)": '442023007' from "SNOMED CT"
```

Snippet 4-12: code definition from [Terminology.cql](Library-Terminology-FHIR.html#cql-content).

#### Representation in a Library
{: #representation-in-a-library}

The representation of code declarations in a Library is discussed in [Terminology](measure-conformance.html#terminology) of Measure Conformance in this IG, consistent with the [Representation in Narrative]({{site.data.fhir.ver.cql}}/using-cql.html#code-representation-in-narrative) topic in the UCWF IG.

### UCUM Best Practices
{: #ucum-best-practices}

This implementation guide recommends the [UCUM Best Practices]({{site.data.fhir.ver.cql}}/using-cql.html#ucum-best-practices) found in the UCWF IG.

### Concepts
{: #concepts}

Consistent with the UCWF IG, CQL used with Measures may make use of the CQL [_concept_]({{site.data.fhir.ver.cql}}/using-cql.html#concepts) declaration, but care must be taken to ensure that it is not used as a surrogate for proper value set definition.

**Conformance Requirement 4.12 (Concepts):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-12)
{: #conformance-requirement-4-12}

1. CQL libraries used by Measures SHALL conform to [UCWF:2.12 (Concepts)]({{site.data.fhir.ver.cql}}/using-cql#conformance-requirement-2-12)

### Library-level Identifiers
{: #library-level-identifiers}

Consistent with the UCWF IG, CQL used by Measures should use descriptive and meaningful library-level identifiers, as discussed in the [Library-level Identifiers](using-cql.html#library-level-identifiers) topic

**Conformance Requirement 4.13 (Library-level Identifiers):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-13)
{: #conformance-requirement-4-13}
1. CQL libraries used by Measures SHALL conform to [UCWF:2.13 (Library-level Identifiers)]({{site.data.fhir.ver.cql}}/using-cql#conformance-requirement-2-13)

### Data Type Names
{: #data-type-names}

Consistent with the UCWF IG, CQL used by Measures must refer to [Data Type Names]({{site.data.fhir.ver.cql}}/using-cql.html#data-type-names) as dictated by the CQL specification, as well as the Data Models in use. For FHIR-based Quality Measures using QI-Core profiles, these will be the author-friendly identifiers for the QI-Core profiles.

**Conformance Requirement 4.14 (Data Type Names):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-14)
{: #conformance-requirement-4-14}
1. CQL libraries used by Measures SHALL conform to [UCWF:2.14 (Data Type Names)]({{site.data.fhir.ver.cql}}/using-cql#conformance-requirement-2-14)

For example:

```cql
define "Flexible Sigmoidoscopy Performed":
  [Procedure: "Flexible Sigmoidoscopy"] FlexibleSigmoidoscopy
    where FlexibleSigmoidoscopy.status = 'completed'
      and FlexibleSigmoidoscopy.performed ends 5 years or less on or before end of "Measurement Period"
```

Snippet 4-13: Expression definition from [EXM130.cql](Library-EXM130-FHIR.html#cql-content)

`Procedure` is the name of the model data type (FHIR resource type) in this example.

### Element Names
{: #element-names}

Consistent with the UCWF IG, CQL used by Measures must refer to [Element Names]({{site.data.fhir.ver.cql}}/using-cql.html#element-names) as dictated by the CQL specification, as well as the Data Models in use.

Note that when FHIR and FHIR IGs are used as the data model, the term "element" is synonymous with "attribute". Some data models, such as QDM, use the "attribute".

**Conformance Requirement 4-15 (Element Names):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-15)
{: #conformance-requirement-4-15}
1. CQL libraries used by Measures SHALL conform to [UCWF:2.15 (Element Names)]{{site.data.fhir.ver.cql}}/using-cql#conformance-requirement-2-15)

Examples of elements (i.e. attributes) conforming to Conformance Requirement 4.15 are given below. For a full list of valid of attributes, refer to an appropriate data model specification such as QI-Core.

```cql
period
authoredOn
result
```

Snippet 4-14: Example element names

### Aliases and Argument Names
{: #aliases-and-argument-names}

Consistent with the UCWF IG, CQL used by Measures must follow conventions for naming of [Aliases and Arguments](({{site.data.fhir.ver.cql}}/using-cql.html#aliases-and-argument-names).

**Conformance Requirement 4.16 (Aliases and Argument Names):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-16)
{: #conformance-requirement-4-16}
1. CQL libraries used by Measures SHALL conform to [UCWF:2.16 (Aliases and Argument Names)]({{site.data.fhir.ver.cql}}/using-cql#conformance-requirement-2-16)

For example:

```cql
define "Encounters During Measurement Period":
    "Valid Encounters" QualifyingEncounter
        where QualifyingEncounter.period during "Measurement Period"

define function "ED Stay Time"(Encounter "Encounter"):
    duration in minutes of Encounter.period
```

Snippet 4-15: Example alias and argument names

`QualifyingEncounter` is the _alias_ in this example, while `Encounter` is the _argument name_.

### Library Resources
{: #library-resources}

Inclusion of CQL content used within quality measures is accomplished through the use of [Library Resources]({{site.data.fhir.ver.cql}}/conformance.html) as described by the Using CQL With FHIR implementation guide. These libraries are then referenced from Measure resources using the `library` element. The content of the CQL library is included using the `content` element of the Library. Conformance requirements for Library resources included with Measure content are discussed in the [Related Documents](measure-conformance.html#related-documents) topic of Measure Conformance in this IG.

### Patterns
{: #patterns}

Additional guidance and best-practices for the use of CQL in measures can be found in the [Patterns]({{site.data.fhir.ver.cql}}/patterns.html) topic of the Using CQL With FHIR implementation guide, including guidance on:

* [Profile-informed authoring]({{site.data.fhir.ver.cql}}/patterns.html#profile-informed-authoring)
* [Use of terminologies]({{site.data.fhir.ver.cql}}/patterns.html#use-of-terminologies)
* [Time-valued quantities]({{site.data.fhir.ver.cql}}/patterns.html#time-valued-quantities)
* [Missing information]({{site.data.fhir.ver.cql}}/patterns.html#missing-information)
* [Negation in FHIR]({{site.data.fhir.ver.cql}}/patterns.html#negation-in-fhir)

### Translation to ELM
{: #translation-to-elm}

The use of Expression Logical Model (ELM) as a basis for sharing logic is discussed in the [Using ELM]({{site.data.fhir.ver.cql}}/using-elm.html) topic of the Using CQL With FHIR implementation guide, including guidance on:

* [Inclusion of ELM content in measure packages]({{site.data.fhir.ver.cql}}/using-elm.html#conformance-requirement-5-1)
* [Recommended translator options]({{site.data.fhir.ver.cql}}/using-elm.html#conformance-requirement-5-2)
* [Specifying and exchanging translator options]({{site.data.fhir.ver.cql}}/using-elm.html#specifying-translator-options)
* [Determining ELM suitability based on context]({{site.data.fhir.ver.cql}}/using-elm.html#elm-suitability)

