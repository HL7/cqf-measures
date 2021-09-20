{:toc}

<div class="new-content" markdown="1">

## Overview
This page describes documents the use cases and conformance expectations of a terminology service to support authoring, distribution, and implementation of FHIR-based quality measure specifications as described in this implementation guide.

This implementation guide is not advocating for any particular central authority for terminology content, rather the intent is to propose a capability statement that enables publishers to build consistent and interoperable terminology services that support authoring, distribution, and implementation of FHIR-based knowledge artifacts.

This implementation guide is not prescriptive about authentication or authorization, but strongly recommends that these capabilities be addressed through standard mechanisms, as described in [FHIR standard security mechanisms](https://www.hl7.org/fhir/security.html).

### Use Cases
Beyond the basic required use cases of searching, retrieving, and expanding value sets, applications that reference value sets that are defined in terms of code systems from different authorities and with different publishing timelines face common challenges related to stable expansion of those value sets. To address that general problem, this implementation guide proposes a _manifest_ that allows the dependencies for a collection of artifacts to be bound to specific versions, enumerated as part of the manifest, rather than requiring the artifacts to be constructed with versioned references. This approach is captured in the [CQFMQualityProgram](StructureDefinition-quality-program-cqfm.html) profile, and is designed around two central use cases:

1. Supporting the authoring of a collection of related artifacts that make use of a shared pool of value sets
2. Supporting the stable expansion of value sets referenced in a _release_ of those artifacts.

#### Quality Program Version Manifest (Expansion Profile)
The first use case is used while the collection of related artifacts is being authored. During this period, the set of code system versions that will be used by value sets referenced by the artifacts is selected and identified in a quality program version manifest (sometimes referred to as an "expansion profile" because it provides expansion rules for expanding value sets used by the artifacts). When authoring value sets and the artifacts that make use of them, this version manifest can be used to ensure stable expansions. Note that this definition will often evolve over the course of the development of collection of artifacts. Quality programs in this state are indicated with a status of _draft_.

#### Quality Program Release
The second use case applies when a _release_ of the artifact collection is established, and the content is effectively _locked_ to a particular set of code system versions, value set definition versions and in some cases expansion versions. The same profile is used, but quality programs in this state are indicated with a status of _active_. To support this use case, in addition to the code system version rules introduced by the manifest, a _release_ may also provide an _expansionUri_, either at the root of the quality program (if all the value sets use the same _expansion identifier_), or per value set by providing an _expansionUri_ on the relatedArtifact. The _expansionUri_ capability may also be used selectively to override expansions for specific value sets, with the behavior falling back to the manifest's expansion calculation rules if no expansionUri is specified for the value set.

#### Quality Program Profile
To support organization of version manifests and releases, the Quality Program profile can also be used to
define quality programs that contain multiple manifests and releases over multiple years. This usage is represented
by an overall Quality Program that then contains multiple "component-of" version manifests and releases. In addition, each version manifest or release indicates that it is "part-of" the Quality Program overall.

### Code Systems

1. SHALL Represent basic CodeSystem information, as specified by the [ShareableCodeSystem](http://hl7.org/fhir/shareablecodesystem.html) profile, which includes url, version, name, status, experimental, publisher, description, caseSensitive, content, and concept.

2. For published CodeSystems, SHALL represent publishable CodeSystem information, as specified by the [CQFMPublishableCodeSystem](StructureDefinition-publishable-codesystem-cqfm.html) profile.

3. SHALL support CodeSystem read by the server-defined id for the CodeSystem

4. SHALL support CodeSystem searches by:
    1. SHALL url: Returning all versions of the codesystem matching that url
    2. SHALL version: Returning the codesystem matching that version (can appear only in combination with a url search)
    3. SHALL identifier: Returning any codesystem matching the identifier
    4. SHALL name: Returning any codesystem matching the name, according to the string-matching semantics in FHIR
    5. SHALL title: Returning any codesystem matching the title, according to the string-matching semantics in FHIR
    6. SHOULD status: Returning codesystems that match the given status
    7. SHALL description: Returning any codesystem matching the search description, according to string-matching semantics in FHIR
    8. SHALL code: Returning any codesystem with the given code

5. SHALL support [CodeSystem/$lookup](http://hl7.org/fhir/codesystem-operation-lookup.html)

6. SHALL support [CodeSystem/$validate-code](http://hl7.org/fhir/codesystem-operation-validate-code.html)

7. TODO: Identify CodeSystems required for eCQM Development (CodeSystems referenced by ValueSets used in eCQM Development and/or referenced by bindings in QICore profiles)

When determining the URI for a code system, the [HL7 Universal Terminology Governance (UTG)](http://terminology.hl7.org)
site is the source of truth. If a code system is not identified there, submit a request with the
HL7 Terminology Authority to identify an appropriate URL. For example, HCPCS Level II codes
are not specified yet, discussion can be found [here](https://chat.fhir.org/#narrow/stream/179202-terminology/topic/HCPCS.20Level.20II.20External.20Code.20System.20Information).

In accordance with the FHIR specification, CodeSystem resources, and references to code systems SHALL use the URI as specified by
the HL7 terminology authority. In addition, version identifiers for code systems are specified according to the rules
identified by the code system authority. For example, for SNOMED-CT, this means the version string
is required to specify the edition and the version:

```
http://snomed.info/sct/731000124108/version/20150301
```

The edition identifier for the US Edition is `731000124108`, and the version in the
above example is the March 2015 release, specified as YYYYMMDD, `20150301`.

Note that when a code system authority has not established a versioning system, terminology servers may, as a practical matter, determine an appropriate versioning system to enable consistent use of content from that code system. However, in this case, the selected versioning scheme SHALL be brought to the [HL7 Terminology Authority](https://confluence.hl7.org/display/TA/Terminology+Authority) for consideration as the standard versioning scheme for that code system.

### Value Sets

1. SHALL Represent basic ValueSet information, as specified by the [ShareableValueSet](http://hl7.org/fhir/shareablevalueset.html) profile, which includes url, version, name, status, experimental, publisher, and description.
    1. To support the ability to include specific codes that are inactive in their code systems, the following types of include elements SHALL be supported
        1. Concepts in a system (unspecified version)
        2. Concepts in a system (specified version)
        3. Value Sets

2. SHALL Represent computable ValueSet information, as specified by the [CQFMComputableValueSet](StructureDefinition-computable-valueset-cqfm.html) profile, which specifies the definition of a value set using established extensions, or with the `compose` element, including in particular the ability to use the `inactive` element of the `include` to indicate that a specific code is inactive in the code system but should still be included in the expansion.

3. SHALL Represent executable ValueSet information, as specified by the [CQFMExecutableValueSet](StructureDefinition-executable-valueset-cqfm.html) profile, which specifies the complete content of a value set using the `expansion` element, including inactive codes specified in the compose.

4. For published ValueSets, SHALL represent publishable ValueSet information, as specified by the [CQFMPublishableValueSet](StructureDefinition-publishable-valueset-cqfm.html) profile.

5. SHALL support ValueSet read, by the server-defined id for the ValueSet

6. SHALL support ValueSet searches by:
    1. url: Returning all versions of the valueset matching that url
    2. version: Returning the valueset matching that version (can appear only in combination with a url search)
    3. identifier: Returning any valueset matching the identifier
    4. name: Returning any valueset matching the name, according to the string-matching semantics in FHIR
    5. title: Returning any valueset matching the title, according to the string-matching semantics in FHIR
    6. status: Returning valuesets that match the given status
    7. description: Returning any valueset matching the search description, according to string-matching semantics in FHIR
    8. code: Returning any valueset with the given code

7. SHOULD support ValueSet searches by:
    1. expansion: Used in combination with url or identifier (and optionally version), returning a ValueSet instance with the given expansion identifier.
    2. usage-user: Typically used in combination with usage-use, returning any value sets that are used by the given user (e.g. CMS)
    3. usage-use: Typically used combination with usage-user, returning any value sets that have the specified use (e.g. CMS124)

7. SHALL Support [ValueSet/$validate-code](http://hl7.org/fhir/R4/valueset-operation-validate-code.html)
    1. SHALL support the url parameter
    2. SHALL support the valueSetVersion parameter
    3. SHALL support the code parameter
    4. SHALL support the system parameter
    5. SHALL support the systemVersion parameter
    6. SHALL support the coding parameter
    7. SHALL support the codeableConcept parameter
    8. SHOULD support other parameters

8. Support [ValueSet/$expand](http://hl7.org/fhir/R4/valueset-operation-expand.html)
    1. SHALL support the url parameter
    2. SHALL support the valueSetVersion parameter
    3. SHALL support the system-version parameter
    4. SHALL support the check-system-version parameter
    5. SHALL support the force-system-version parameter
    6. SHOULD support other parameters
    7. SHOULD support the `manifest` parameter (defined in the [cqfm-valueset-expand](OperationDefinition-ValueSet-expand.html))
    8. SHOULD support the `expansion` parameter (defined in the [cqfm-valueset-expand](OperationDefinition-ValueSet-expand.html))
    9. SHOULD support the `preview` parameter (defined in the [cqfm-valueset-expand](OperationDefinition-ValueSet-expand.html))

9. TODO: Determine whether eCQM content development will ever need to be able to reference FHIR-defined value sets.

### Quality Programs (Binding Parameters Specification)

1. SHALL Represent basic quality program release information, as specified by the [CQFMQualityProgram](StructureDefinition-quality-program-cqfm.html) profile, which includes identifier, title, type, date, useContext, effectivePeriod, measure, library, and terminology references

2. For published quality programs, SHALL represent publishable quality program information as specified by the [CQFMPublishableLibrary](StructureDefinition-publishable-library-cqfm.html) profile.

3. SHALL support Quality Program (Library) read, by the server-defined id for the quality program library

4. SHALL support Quality Program (Library) searches by:
    1. url: Returning all versions of the quality program matching that url
    2. version: Returning the quality program matching that version (can appear only in combination with a url search)
    3. identifier: Returning any quality program matching the identifier
    4. name: Returning any quality program matching the name, according to the string-matching semantics in FHIR
    5. title: Returning any quality program matching the title, according to the string-matching semantics in FHIR
    6. status: Returning quality programs that match the given status
    7. description: Returning any quality programs matching the search description, according to string-matching semantics in FHIR
    8. composed-of: Returning any quality program that includes the given measure canonical or quality program version manifest or release
    9. depends-on: Returning any quality program that references the given code system or value set canonical
    10. part-of: Returning any version manifest or release that is part of the given quality program

5. SHALL support version manifest and release value set packaging: [Library/$package](OperationDefinition-Library-package.html) operation
    1. SHALL support the url parameter
    2. SHALL support the version parameter
    3. SHOULD support the offset parameter
    4. SHOULD support the count parameter
    5. SHOULD support system-version parameter (overrides code system versions specified in the quality program release)
    6. SHOULD support check-system-version parameter (overrides code system versions specified in the quality program release)
    7. SHOULD support force-system-version parameter (overrides code system versions specified in the quality program release)

### Capability Statement

The above capabilities are formally captured in the following capability statement:

[CQFMMeasureTerminologyService](CapabilityStatement-measure-terminology-service.html)

TODO: Support paged operations for: Code lookup, validation, expansion
TODO: Consider how Measure value set and terminology usage is determined by the Terminology Service

### Examples

#### Expansion of a value set that contains "legacy codes"

This is the computable representation of an example Chronic Liver Disease value set. It
contains two concepts that are active (as of the 2019-09 release of the US Edition of
SNOMED-CT) and one concept that was last active in the 2015-03 release).

* [ChronicLiverDiseaseLegacyExample](ValueSet-chronic-liver-disease-legacy-example.html)

The `compose` element of this value set is:

```
"compose": {
  "include": [
    {
      "system": "http://snomed.info/sct",
      "concept": [
        {
          "code": "1116000",
          "display": "Chronic aggressive type B viral hepatitis (disorder)"
        },
        {
          "code": "10295004",
          "display": "Chronic viral hepatitis (disorder)"
        }
      ]
    },
    {
      "system": "http://snomed.info/sct",
      "version": "http://snomed.info/sct/731000124108/version/20150301",
      "concept": [
        {
          "code": "111370006",
          "display": "Cirrhosis of liver not due to alcohol (disorder)"
        }
      ]
    }
  ]
}
```

Note specifically the use of the `inactive` element to indicate that the
value set definition contains inactive codes, and the use of separate
`include` elements, one for the codes that do not specify a code system version,
and one for the _legacy_ code from version `http://snomed.info/sct/731000124108/version/20150301`.

##### Current expand

Given the following `$expand`:

```
[base]/ValueSet/chronic-liver-disease-legacy-example/$expand
```

The expected [result](ValueSet-chronic-liver-disease-legacy-example-current.html) expansion is:

```
"expansion": {
  "timestamp": "2021-02-05T08:57:00-06:00",
  "contains": [
    {
      "system": "http://snomed.info/sct",
      "code": "1116000",
      "display": "Chronic aggressive type B viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "code": "10295004",
      "display": "Chronic viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "inactive": true,
      "code": "111370006",
      "display": "Cirrhosis of liver not due to alcohol (disorder)"
    }
  ]
}
```

Note the use of the `inactive` element to indicate the code `111370006` is inactive in the
current version of SNOMED (i.e. the version of SNOMED that was active when this
expansion was produced, and the use of the `timestamp` to ensure that date is known).

##### Current expand, activeOnly

Given the following `$expand`:

```
[base]/ValueSet/chronic-liver-disease-legacy-example/$expand?activeOnly=true
```

The expected [result](ValueSet-chronic-liver-disease-legacy-example-current-active.html) expansion is:

```
"expansion": {
  "timestamp": "2021-02-05T08:57:00-06:00",
  "parameter": [
    {
      "name": "activeOnly",
      "valueBoolean": true
    }
  ],
  "contains": [
    {
      "system": "http://snomed.info/sct",
      "code": "1116000",
      "display": "Chronic aggressive type B viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "code": "10295004",
      "display": "Chronic viral hepatitis (disorder)"
    }
  ]
}
```

The result of the `activeOnly` parameter is to exclude the inactive code, even
though it was explicitly included in the value set definition.

##### Version-specific expand

Given the following `$expand`:

```
[base]/ValueSet/chronic-liver-disease-legacy-example/$expand?valueSetVersion=2020-05&system-version=http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20150301
```

The expected [result](ValueSet-chronic-liver-disease-legacy-example-2019-09.html) expansion is:

```
"expansion": {
  "timestamp": "2021-02-05T08:57:00-06:00",
  "parameter": [
    {
      "name": "valueSetVersion",
      "valueString": "2020-05"
    },
    {
      "name": "system-version",
      "valueUri": "http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20190901"
    }
  ],
  "contains": [
    {
      "system": "http://snomed.info/sct",
      "code": "1116000",
      "display": "Chronic aggressive type B viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "code": "10295004",
      "display": "Chronic viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "inactive": true,
      "code": "111370006",
      "display": "Cirrhosis of liver not due to alcohol (disorder)"
    }
  ]
}
```

Note this expansion contains the same codes as the `current` example, but is explicitly
bound to the 2019-09 version of the US Edition of the SNOMED code system (http://snomed.info/sct/731000124108/version/20190901).

#### Quality Programs

A Quality Program has 3 different manifestations:

1. As an organizer for an overall quality program that contains version manifests and releases over time.
2. As a version manifest (also called an expansion profile) that specifies expansion rules for a set of value sets (supporting the authoring use case).
3. As a program release that provides stable expansions for a set of value sets (supporting the distribution use case)

##### Quality Program Example

The following example illustrates an overall quality program that contains multiple version manifests and releases over time:

* [eCQM Quality Program](Library-ecqm-quality-program.html)

Note that as an organizer, this library just contains the program-level information. Version manifests and releases over time use the [part-of](StructureDefinition-cqfm-partOf.html) extension to indicate that they are part of a quality program.

##### Version Manifest (Expansion Profile)

The following example illustrates a version manifest (or expansion profile) that is a _draft_ of a quality program release used to provide expansion rules while the artifacts for a program are being authored. Specifically, the manifest uses the `relatedArtifact` element to declare the version of the SNOMED-CT code system to be used:

```
"relatedArtifact": [
  {
    "type": "depends-on",
    "resource": "http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20190901",
    "display": "SNOMED-CT US Edition, 2019-09-01"
  }
]
```

The full example is available here:

* [eCQM Version Manifest (Expansion Profile), 2020](Library-ecqm-update-2020.html)

##### Program Release

The following example illustrates a program release that is an _active_ instance of a quality program release used to provide stable extensions for the released artifacts in a quality program.

Specifically, the program release uses the `expansionUri` extension at the library level to indicate that all value sets used with artifacts in the program should expand using this expansion identifier:

```
{
  "url": "http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-expansionUri",
  "valueUri": "eCQM%20Update%202020-05-07"
}
```

In addition, the program release specifies versions of code systems, value sets, and measures included in the release:

```
{
  "type": "depends-on",
  "resource": "http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20190901",
  "display": "SNOMED-CT US Edition, 2019-09-01"
},
{
  "type": "depends-on",
  "resource": "http://hl7.org/fhir/us/cqfmeasures/ValueSet/chronic-liver-disease-legacy-example|2020-05",
  "display": "Chronic Liver Disease, Legacy Example (2020-05)"
},
{
  "type": "composed-of",
  "resource": "http://hl7.org/fhir/us/cqfmeasures/Measure/measure-exm124-FHIR|9.0.0",
  "display": "Cervical Cancer Screening"
},
{
  "type": "composed-of",
  "resource": "http://hl7.org/fhir/us/cqfmeasures/Measure/measure-exm125-FHIR",
  "display": "Breast Cancer Screening"
},
{
  "type": "composed-of",
  "resource": "http://hl7.org/fhir/us/cqfmeasures/Measure/measure-exm130-FHIR",
  "display":"Colorectal Cancer Screening"
},
{
  "type": "composed-of",
  "resource": "http://hl7.org/fhir/us/cqfmeasures/Measure/measure-exm146-FHIR",
  "display": "Appropriate Testing for Children with Pharyngitis"
}
```

The full example is available here:

* [eCQM Release, 2020-05-07](Library-ecqm-update-2020-05-07.html)

##### Expansion with manifests and releases:

Given the use of a _version manifest_ as well as a _program release_, then the _manifest_ parameter can be used
in the `$expand` operation to provide values for the relevant parameters:

```
[base]/ValueSet/chronic-liver-disease-legacy-example/$expand?manifest=http://hl7.org/fhir/us/cqfmeasures/Library/ecqm-update-2020
```

This is effectively an alternative mechanism for expressing the same value set and code system version specific expansion above,
and results in the same expansion, with the additional `manifest` parameter:

```
"expansion": {
  "timestamp": "2021-02-05T08:57:00-06:00",
  "parameter": [
    {
      "name": "valueSetVersion",
      "valueString": "2020-05"
    },
    {
      "name": "system-version",
      "valueUri": "http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20190901"
    },
    {
      "name": "manifest",
      "valueUri": "http://hl7.org/fhir/us/cqfmeasures/Library/ecqm-update-2020"
    }
  ],
  "contains": [
    {
      "system": "http://snomed.info/sct",
      "code": "1116000",
      "display": "Chronic aggressive type B viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "code": "10295004",
      "display": "Chronic viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "inactive": true,
      "code": "111370006",
      "display": "Cirrhosis of liver not due to alcohol (disorder)"
    }
  ]
}
```

Similarly, when using a release for the manifest parameter:

```
[base]/ValueSet/chronic-liver-disease-legacy-example/$expand?manifest=http://hl7.org/fhir/us/cqfmeasures/Library/ecqm-update-2020-05-07
```

This is effectively the same as providing the `expansion` parameter to the value set expand, and results in the expansion with the specified expansion identifier:

```
"expansion": {
  "identifier": "eCQM%20Update%202020-05-07",
  "timestamp": "2021-02-05T08:57:00-06:00",
  "parameter": [
    {
      "name": "valueSetVersion",
      "valueString": "2020-05"
    },
    {
      "name": "system-version",
      "valueUri": "http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20190901"
    },
    {
      "name": "manifest",
      "valueUri": "http://hl7.org/fhir/us/cqfmeasures/Library/ecqm-update-2020-05-07"
    }
  ],
  "contains": [
    {
      "system": "http://snomed.info/sct",
      "code": "1116000",
      "display": "Chronic aggressive type B viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "code": "10295004",
      "display": "Chronic viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "inactive": true,
      "code": "111370006",
      "display": "Cirrhosis of liver not due to alcohol (disorder)"
    }
  ]
}
```

#### Value Set Searches

##### Expansion Search

In addition to the use of the `expansion` parameter of the `$expand` operation, terminology services SHOULD support searching for a particular ValueSet expansion using the `expansion` search parameter:

```
[base]/ValueSet?url=http://hl7.org/fhir/us/cqfmeasures/ValueSet/chronic-liver-disease-legacy-example&expansion=eCQM%20Update%202020-05-07
```

The result of this search is the same as requesting an `$expand` with the `expansion` parameter.

##### Usage Search

The `usage-user` and `usage-use` search parameters can be used to search for valuesets that have been used in particular contexts and by particular users:

```
[base]/ValueSet?usage-user=CMS&usage-use=CMS124
```

</div>
