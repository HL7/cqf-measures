{:toc}

## Overview
This page describes and documents the use cases and conformance expectations of a terminology service to support authoring, distribution, and evaluation of FHIR-based quality measure specifications as described in this implementation guide.

This implementation guide is not advocating for any particular central authority for terminology content, rather the intent is to propose a capability statement that enables publishers to build consistent and interoperable terminology services that support authoring, distribution, and implementation of FHIR-based knowledge artifacts.

This implementation guide is not prescriptive about authentication or authorization, but strongly recommends that these capabilities be addressed through standard mechanisms, as described in [FHIR standard security mechanisms](https://www.hl7.org/fhir/security.html).

### Use Cases
Beyond the basic required use cases of searching, retrieving, and expanding value sets, applications that reference value sets that are defined in terms of code systems from different authorities and with different publishing timelines face common challenges related to stable expansion of those value sets. To address that general problem, this implementation guide proposes to use the Library resource as an _artifact collection_. Artifact collections are libraries of knowledge artifacts used to package sets of artifacts for development and release. From the perspective of a terminology service, artifact collections provide two main capabilities:

1. They act as a _version manifest_ to specify the versions of dependencies used by artifacts in the collection
2. They allow _expansion rules_ to be specified for value sets used by artifacts in the collection

Note that during the authoring phase, the value sets referenced by artifacts will change, but once released, the set is stable. Throughout this process, the focus of the capabilities supported by this service description are intended to ensure stable expansion of the value sets referenced by the artifacts.

#### Version Manifest
As a version manifest, an artifact collection specifies versioned canonical references for dependencies using `relatedArtifact` elements with a type of `depends-on`.

> NOTE: If the version of an artifact is specified explicitly as part of the declaration in the artifact, the manifest approach cannot be used to override that version. For example, if a measure explicitly references the version of a value set, the manifest cannot override that version.

#### Expansion Rules
Artifact collections can specify _expansion rules_ for value sets referenced by artifacts in the collection. This is done using the [cqfm-expansionParameters](StructureDefinition-cqfm-expansionParameters.html) extension to reference a contained Parameters resource, where the parameter elements provide a default value for parameters to the $expand operation, consistent with the conformance requirements for the $expand operation supported by a measure terminology service, including support for the following parameters:

1. `activeOnly`
2. `system-version`
3. `check-system-version`
4. `force-system-version`
5. `expansion` parameter (defined in the [cqfm-valueset-expand](OperationDefinition-ValueSet-expand.html))
6. `includeDraft` parameter (defined in the [cqfm-valueset-expand](OperationDefinition-ValueSet-expand.html))

Because this capability results in the potential for parameter values to be supplied in multiple places, the following rules apply:

1. If a parameter is specified as part of the $expand operation directly, it takes precedence
2. If a ValueSet dependency is specified as part of the version manifest (and no version for the value set is specified in the artifact reference), the version has the same meaning as the `valueSetVersion` parameter to the $expand
3. If a CodeSystem dependency is specified as part of the version manifest (and no version for the code system is specified in the artifact reference), the version has the same meaning as the `system-version` parameter to the $expand
4. Version information specified in the expansion parameters takes precedence over version information specified as part of the version manifest (i.e. as a relatedArtifact dependency in the artifact collection library)

#### Quality Programs
To support organization of releases, the Quality Program profile can also be used to define quality programs that contain multiple releases over multiple years. This usage is represented by an overall Quality Program that is then referenced by each release using the [partOf](StructureDefinition-cqfm-partOf.html) extension.

#### Hosted Content
Terminology services may act as a repository for content that is managed and created elsewhere (i.e. hosted content AKA a convenience copy), or they may provide features to author and manage content directly, or any combination. When hosting content that is managed elsewhere, the service must ensure that the content of the resource is materially the same (i.e. the values for all elements are the same where those elements are specified in the Shareable and Publishable profiles) as the source of truth.
In particular, for systems that provide both management and hosting of externally managed content, the status element for hosted content SHALL be the same as the status of the content in the source of truth.

### Code Systems

1. SHALL Represent basic CodeSystem information, as specified by the [ShareableCodeSystem](http://hl7.org/fhir/shareablecodesystem.html) profile, which includes url, version, name, status, experimental, publisher, description, caseSensitive, content, and concept.

2. For published CodeSystems, SHALL represent publishable CodeSystem information, as specified by the [CQFMPublishableCodeSystem](StructureDefinition-publishable-codesystem-cqfm.html) profile.

3. For hosted content, the [data-absent-reason](https://hl7.org/fhir/extension-data-absent-reason.html) extension with a value of [unknown](https://hl7.org/fhir/codesystem-data-absent-reason.html#data-absent-reason-unknown) MAY be used to satisfy required cardinality constraints of the ShareableCodeSystem and PublishableCodeSystem profiles when an element is not present in the source of truth for the content.

4. CodeSystem resources returned by the repository SHALL use the meta.profile element to indicate which profiles the CodeSystem resource conforms to, Shareable, Publishable

5. SHALL support CodeSystem read by the server-defined id for the CodeSystem

6. SHALL support CodeSystem searches by:
    1. url: Returning all versions of the codesystem matching that url
    2. version: Returning the codesystem matching that version (can appear only in combination with a url search)
    3. identifier: Returning any codesystem matching the identifier
    4. name: Returning any codesystem matching the name, according to the string-matching semantics in FHIR
    5. title: Returning any codesystem matching the title, according to the string-matching semantics in FHIR
    6. description: Returning any codesystem matching the search description, according to string-matching semantics in FHIR
    7. code: Returning any codesystem with the given code

7. SHOULD support CodeSystem searches by:
    1. status: Returning codesystems that match the given status
    2. valueset: Returning any codesystem that is referenced by the given value set url (optionally versioned)
    3. measure: Returning any codesystem that is referenced by the given measure url (optionally versioned)
    4. library: Returning any codesystem that is referenced by the given library url (optionally versioned)
    4. artifact: Returning any codesystem that is referenced by the given artifact url (optionally versioned)

8. SHALL support [CodeSystem/$lookup](http://hl7.org/fhir/codesystem-operation-lookup.html)

9. SHALL support [CodeSystem/$validate-code](http://hl7.org/fhir/codesystem-operation-validate-code.html)

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

3. For hosted content, the [data-absent-reason](https://hl7.org/fhir/extension-data-absent-reason.html) extension with a value of [unknown](https://hl7.org/fhir/codesystem-data-absent-reason.html#data-absent-reason-unknown) MAY be used to satisfy required cardinality constraints of the ShareableValueSet and PublishableValueSet profiles when an element is not present in the source of truth for the content.

4. ValueSet resources returned by the repository SHALL use the meta.profile element to indicate which profiles the ValueSet resource conforms to, Shareable, Publishable, Computable, Executable.

5. SHALL Represent executable ValueSet information, as specified by the [CQFMExecutableValueSet](StructureDefinition-executable-valueset-cqfm.html) profile, which specifies the complete content of a value set using the `expansion` element, including inactive codes specified in the compose.

6. For published ValueSets, SHALL represent publishable ValueSet information, as specified by the [CQFMPublishableValueSet](StructureDefinition-publishable-valueset-cqfm.html) profile.

7. SHALL support ValueSet read, by the server-defined id for the ValueSet

8. SHALL support ValueSet searches by:
    1. url: Returning all versions of the valueset matching that url
    2. version: Returning the valueset matching that version (can appear only in combination with a url search)
    3. identifier: Returning any valueset matching the identifier
    4. name: Returning any valueset matching the name, according to the string-matching semantics in FHIR
    5. title: Returning any valueset matching the title, according to the string-matching semantics in FHIR
    6. status: Returning valuesets that match the given status
    7. description: Returning any valueset matching the search description, according to string-matching semantics in FHIR
    8. code: Returning any valueset with the given code
    9. keyword: Returning any valueset that has a valueset-keyword extension  matching the given keyword

9. SHOULD support ValueSet searches by:
    1. expansion: Used in combination with url or identifier (and optionally version), returning a ValueSet instance with the given expansion identifier.
    2. context: Returning all artifacts with a use context value matching the given context
    3. context-type: Returning all artifacts with a use context type matching the given context type
    4. context-type-quantity: Returning all artifacts with a use context quantity or range matching the given quantity
    5. context-type-value: Returning all artifacts with a given use context type and value
    6. codesystem: Returning any valueset that directly references the given codesystem url (optionally versioned)
    7. valueset: Returning any valueset that references or is referenced by the given valueset url (optionally versioned)
    8. library: Returning any valueset that is referenced by the given library url (optionally versioned)
    9. measure: Returning any valueset that is referenced by the given measure url (optionally versioned)
    10. artifact: Returning any valueset that directly or indirectly references or is referenced by the given artifact url (optionally versioned)

10. SHALL Support [ValueSet/$validate-code](http://hl7.org/fhir/R4/valueset-operation-validate-code.html)
    1. SHALL support the url parameter
    2. SHALL support the valueSetVersion parameter
    3. SHALL support the activeOnly parameter
    4. SHALL support the displayLanguage parameter
    5. SHALL support the code parameter
    6. SHALL support the system parameter
    7. SHALL support the systemVersion parameter
    8. SHALL support the coding parameter
    9. SHALL support the codeableConcept parameter

11. Support [ValueSet/$expand](http://hl7.org/fhir/R4/valueset-operation-expand.html)
    1. SHALL support the url parameter
    2. SHALL support the valueSetVersion parameter
    3. SHALL support the activeOnly parameter
    4. SHALL support the displayLanguage parameter
    5. SHALL support the limitedExpansion parameter
    6. SHALL support the default-to-latest-version parameter
    7. SHALL support the system-version parameter
    8. SHALL support the check-system-version parameter
    9. SHALL support the force-system-version parameter
    10. SHOULD support includeDesignation parameter
    11. SHOULD support designation parameter
    12. SHOULD support paging parameters
    13. SHOULD support the `manifest` parameter (defined in the [cqfm-valueset-expand](OperationDefinition-ValueSet-expand.html))
    14. SHOULD support the `expansion` parameter (defined in the [cqfm-valueset-expand](OperationDefinition-ValueSet-expand.html))
    15. SHOULD support the `includeDraft` parameter (defined in the [cqfm-valueset-expand](OperationDefinition-ValueSet-expand.html))

### Quality Programs (Artifact Collections)

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

5. SHALL support specifying expansion rules for the following $expand parameters
    1. SHALL support the activeOnly parameter
    2. SHALL support the system-version parameter
    3. SHALL support the check-system-version parameter
    4. SHALL support the force-system-version parameter
    5. SHOULD support other parameters
    6. SHOULD support the `expansion` parameter (defined in the [cqfm-valueset-expand](OperationDefinition-ValueSet-expand.html))
    7. SHOULD support the `includeDraft` parameter (defined in the [cqfm-valueset-expand](OperationDefinition-ValueSet-expand.html))

6. Because this capability results in the potential for parameter values to be supplied in multiple places, the following rules apply:
    1. If a parameter is specified as part of the $expand operation directly, it takes precedence
    2. If a ValueSet dependency is specified as part of the version manifest (and no version for the value set is specified in the artifact reference), the version has the same meaning as the `valueSetVersion` parameter to the $expand
    3. If a CodeSystem dependency is specified as part of the version manifest (and no version for the code system is specified in the artifact reference), the version has the same meaning as the `system-version` parameter to the $expand
    4. Version information specified in the expansion parameters takes precedence over version information specified as part of the version manifest (i.e. as a relatedArtifact dependency in the artifact collection library)

7. SHALL support version manifest and release value set packaging: [Library/$package](OperationDefinition-Library-package.html) operation
    1. SHALL support the url parameter
    2. SHALL support the version parameter
    3. SHOULD support the offset parameter
    4. SHOULD support the count parameter
    5. SHOULD support system-version parameter (overrides code system versions specified in the quality program release)
    6. SHOULD support check-system-version parameter (overrides code system versions specified in the quality program release)
    7. SHOULD support force-system-version parameter (overrides code system versions specified in the quality program release)

8. SHALL support operations to enable maintenance of release specifications for quality programs for Library resources that conform to the Quality Program profile:
    1. SHALL support creating a Library in "draft" status (using POST)
    2. SHALL support updating a Library in "draft" status (using PUT)
    3. SHALL support updating the status of a Library in "draft" status to "active" using (PUT)
    4. SHALL support updating the status of a Library in "active" status to "retired" using (PUT)
    5. SHALL reject attempts to update elements of a Library other than status if the Library is not in "draft" status
    6. SHALL reject attempts to create Libraries that have the same "url" and "version" as another Library

### Server Operations

1. SHALL support the `metadata?mode=terminology`, returning a list of all supported code systems, whether they are explicitly made available as CodeSystem resources or not

2. To ensure performant operations with large code systems and value sets, a measure terminology service SHALL support [batch](https://hl7.org/fhir/http.html#transaction) operations for at least the following:
    1. CodeSystem read
    2. CodeSystem search
    3. CodeSystem/$validate-code
    4. ValueSet read
    5. ValueSet search
    6. ValueSet/$validate-code

3. Services MAY require authentication. If authentication is required, it SHALL be in the form of an authentication header (usually a bearer token) that the user can determine in advance and provide to their FHIR tooling in some configuration.

### Capability Statement

The above capabilities are formally captured in the following capability statement:

[CQFMMeasureTerminologyService](CapabilityStatement-measure-terminology-service.html)

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

From the perspective of quality measurement, artifact collections are used to represent Quality Programs in 2 different ways:

1. As an organizer for an overall quality program that contains version manifests and releases over time.
2. As a program definition that provides version bindings and expansion rules for the measures in the program.

Note that as the measures in the program definition are developed, different aspects of the definition will be specified at different points of the process. For example, the initial program definition will typically include a set of measures, as well as an initial set of proposed code system versions to be used. This provides for stable expansion of value sets while the measures are being developed. As development progresses, more and more aspects of the program definition are finalized, resulting in more versions being pinned down. To illustrate these usages, we provide three quality program examples, one to illustrate the overall definition of a quality program, one to illustrate the selection of code systems at the beginning of a program development cycle, and one to illustrate a final release of a program definition with measure versions, value set versions, and code system versions completely specified.

##### Quality Program Example

The following example illustrates an overall quality program that contains multiple version manifests and releases over time:

* [eCQM Quality Program](Library-ecqm-quality-program.html)

Note that as an organizer, this library just contains the program-level information. Version manifests and releases over time use the [part-of](StructureDefinition-cqfm-partOf.html) extension to indicate that they are part of a quality program.

##### Draft Quality Program Example

This example illustrates the use of a draft quality program description to specify the version of SNOMED to be used for valuesets used by measures in the quality program.

```
"contained": [
  {
    "resourceType": "Parameters",
    "id": "exp-params",
    "parameter": [
      {
        "name" : "system-version",
        "valueUri" : "http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20190901"
      },
      {
        "name": "activeOnly",
        "valueBoolean": true
      },
      {
        "name": "includeDraft",
        "valueBoolean": true
      }
    ]
  }
],
"extension": [
  {
    "url": "http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-expansionParameters",
    "valueReference": {
      "reference": "#exp-params"
    }
  }
],
```

This example indicates that unless specified explicitly by artifacts in the collection, the 2019-09-01 version of SNOMED SHALL be used when expanding value sets that reference SNOMED.

Note that the version of SNOMED in use is still listed as a dependency in the artifact collection to support providing a complete listing of dependencies in the version manifest. When this is done, the version provided in the expansion parameters SHALL take precedence (though the version manifest SHOULD be consistent with the expansion parameters).

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

* [eCQM Version Manifest, 2020](Library-ecqm-update-2020.html)

##### Release Quality Program

The following example illustrates a program release that is an _active_ instance of a quality program release used to provide stable extensions for the released artifacts in a quality program.

Specifically, the program release uses the `expansion` parameter in the contained expansion parameters at the artifact collection level to indicate that all value sets used with artifacts in the program should expand using this expansion identifier:

```
{
  "name": "expansion",
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
  "display": "Colorectal Cancer Screening"
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

Given this use of an artifact collection, the _manifest_ parameter can be used in the `$expand` operation to provide values for the relevant parameters:

```
[base]/ValueSet/chronic-liver-disease-legacy-example/$expand?manifest=http://hl7.org/fhir/us/cqfmeasures/Library/ecqm-update-2020
```

This is effectively an alternative mechanism for expressing the same value set and code system version specific expansion above, and results in the same expansion, with the additional `manifest` parameter:

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
