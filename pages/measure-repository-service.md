---
layout: default
title: Measure Repository Service
---

## Overview
This page documents the use cases and conformance expectations of a knowledge repository service to support authoring, publishing, and distribution of FHIR-based quality measure specifications as described in this implementation guide.

This implementation guide is not advocating for any particular central authority for content repositories but a rather the intent is to provide guidance to stewards/publishers in building content repositories.

This implementation guide is not prescribing specifications regarding authentication/authorization security, they would be addressable through the [FHIR standard security mechanisms](https://www.hl7.org/fhir/security.html).

Requests for ballot comment, specifically for implementer feedback can be made [here](https://jira.hl7.org/projects/FHIR/summary)

### Knowledge Artifact Management

Quality measures (eCQMs) are a specific type of knowledge artifact, and share common attributes with other knowledge artifact types. This section describes the general use case of knowledge artifact management as a special case of _content management_. Specifically, we apply _semantic versioning_ and apply controls through the use of _status_, as described in the artifact lifecycle topic. The use cases for artifact management are then described in artifact operations.

#### Artifact Lifecycle

Knowledge artifacts as represented within FHIR follow a general, high-level content development work flow, as represented by the possible values of the _status_ element of the artifact:

* **draft**: The artifact is under development and not yet considered to be ready for normal use. In particular, there is no guarantee that the version element associated with the artifact is established, and the actual content of the artifact may change.
* **active**: The artifact is ready for normal use. In particular, the content of the artifact related to the version element is stable and SHALL NOT change. Changes to the artifact require a new version to be introduced in draft status.
* **retired**: The artifact has been withdrawn or superseded and should no longer be used.

In addition, the _experimental_ element may be used to indicate that the artifact is intended for testing/experimental usage only and should not be used in production settings.

#### Artifact Identity

Knowledge artifacts represented as FHIR resources have multiple ways of identifying the artifact:

1. _logical id_: As FHIR resources, knowledge artifacts have a server-specific logical id for the artifact, as defined by the _id_ element of the resource. This id is typically managed by the specific server in which a resource appears, and so can change depending on the server it is accessed from. See the [Logical ID](http://hl7.org/fhir/resource.html#id) topic in FHIR for more information.
2. _business identifiers_: All knowledge artifacts have an _identifier_ element that can be used to provide additional identifiers that are unique within a defined scope (or _system_) and remain fixed as the resource appears on different servers. See the [Business Identifiers](http://hl7.org/fhir/resource.html#identifiers) topic in FHIR for more information.
3. _canonical urls_: As _canonical_ resources in FHIR, knowledge artifacts have a special purpose business identifiers that is a globally unique, version-independent identifier for the resource, specified by the _url_ element. See the [Canonical URLs](http://hl7.org/fhir/resource.html#canonical) topic in FHIR for more information.

Knowledge artifacts SHALL provide and maintain a globally unique, version-independent identifier in the _url_ element. When referencing knowledge artifacts, a reference may be version-independent by providing only the canonical URL, or the reference may be version-specific, using the `|` notation to indicate the version of the artifact to be referenced:

```
http://example.org/fhir/Library/ExampleLibrary // A version-independent reference to the ExampleLibrary published at example.org/fhir
http://example.org/fhir/Library/ExampleLibrary|1.0.0 // A vesrion-specific reference to version 1.0.0 of the library
```

#### Artifact Versioning

As a best practice, content versions SHOULD follow [_semantic versioning_](https://semver.org/). To summarize this scheme as it applies to knowledge artifacts, there are three main types of changes that can be made to an artifact.

1. The artifact can be changed in a way that would alter the public use of its existing components.
2. An artifact can be changed by adding new components or functionality but without altering the public use of its existing components.
3. An artifact can be changed in a way that does not change existing components or add new components, but only corrects or improves the originally intended functionality.

By exposing version numbers that identify all three types of changes, artifacts can be versioned in a way that makes clear when a change will impact usage, versus when a change can potentially be safely incorporated as an update. Under this scheme, the first type of change is referred to as a _major_ change, and will require incrementing of the _major version number_. The second type of change will be referred to as a _minor_ change, and will only require incrementing of the _minor version number_. And finally, the third type of change will be referred to as a _patch_, and will only require incrementing the _patch version number_.

Version numbers for artifacts can then be represented as:

```
<major>.<minor>.<path>
```

For example:

```
1.0.0
```

Note that versioning content often involves _pre-release_ content, and this scheme supports that through the use of labels such as `SNAPSHOT`. This is indicated with a `-` following the version number:

```
1.0.0-SNAPSHOT
```

Content MAY use additional labels to support pre-release content or other versioning and build metadata use cases.

#### Artifact Repository Operations

To support content authoring, searching, publication, and distribution, the following general operations are defined:

* [**Retrieve**](#retrieve): Get a specific artifact by its server-specific identity
* [**Search**](#search): Search for an artifact according to specific criteria
* [**Package**](#package): Package an artifact for a particular environment (regardless of status)
* [**Requirements**](#requirements): Determine the data requirements and dependencies for a particular artifact (regardless of status)
* [**Submit**](#submit): Post a new artifact in _draft_ status
* [**Revise**](#revise): Update an existing artifact in _draft_ status
* [**Withdraw**](#withdraw): Delete a _draft_ artifact
* [**Review**](#review): Review and provide comments on an existing artifact (regardless of status)
* [**Approve**](#approve): Approve and provide comments on an existing artifact (regardless of status)
* [**Publish**](#publish): Post a new artifact with _active_ status
* [**Release**](#release): Update an existing _draft_ artifact to _active_
* [**Retire**](#retire): Post an update that sets status to _retired_ on an existing _active_ artifact
* [**Archive**](#archive): Delete a _retired_ artifact

##### Retrieve

An artifact repository SHALL support retrieval of an artifact by its server-specific id.

##### Search

Because artifacts in FHIR share consistent metadata attributes, searching can be defined across all artifacts.

###### Core Searches

Artifact repositories SHALL support searching for artifacts by the following parameters:

1. url: Returning all versions of the artifact matching a url
2. version: Returning the artifact matching a version (can appear only in combination with a url search)
3. identifier: Returning any artifact matching the identifier
4. name: Returning any artifact matching the name, according to the string-matching semantics in FHIR
5. title: Returning any artifact matching the title, according to the string-matching semantics in FHIR
6. status: Returning artifacts that match the given status
7. description: Returning any artifact matching the search description, according to string-matching semantics in FHIR

###### Metadata Searches

Artifact repositories SHOULD support searching for artifacts by the following parameters:

1. date: Returning all artifacts matching the given date
2. effective: Returning all artifacts matching the given effectivePeriod
3. jurisdiction: Returning all artifacts matching the given jurisdiction
4. context: Returning all artifacts with a use context value matching the given context
5. context-type: Returning all artifacts with a use context type matching the given context type
6. context-type-quantity: Returning all artifacts with a use context quantity or range matching the given quantity
7. context-type-value: Returning all artifacts with a given use context type and value
8. topic: Returning all artifacts matching the given topic

###### Related Artifact Searches

Artifact repositories MAY support searching for artifacts by the following parameters:

1. composed-of: Returning all artifacts that have the given artifact as a component
2. depends-on: Returning all artifacts that have the given artifact as a dependency
3. derived-from: Returning all artifacts that are derived from the given artifact
4. successor: Returning all artifacts that have the given artifact as a successor
5. predecessor: Returning all artifacts that have the given artifact as a predecessor

##### Package

The package operation supports the ability of a repository to package an artifact for a particular target environment, and with required components and dependencies included. The following parameters SHOULD be supported for packaging operations:

* **id**: The server-specific id of the artifact to be packaged
* **url**: The canonical url of the artifact to be packaged
* **version**: The version of the artifact to be packaged
* **identifier**: A business identifier of the artifact to be packaged
* **capability**: A desired capability of the resulting package. `computable` to include computable elements in packaged content, `executable` to include executable elements in packaged content, `publishable` to include publishable elements in packaged content.
* **offset**: Paging support - where to start if a subset is desired (default = 0). Offset is number of records (not number of pages)
* **count**: Paging support - how many resources should be provided in a partial page view. If count = 0, the client is asking how large the package is.
* **system-version**: Specifies a version to use for a system, if the library or value set does not already specify which one to use. The format is the same as a canonical URL: [system]|[version] - e.g. http://loinc.org|2.56
* **check-system-version**: Edge Case: Specifies a version to use for a system. If a library or value set specifies a different version, an error is returned instead of the package. The format is the same as a canonical URL: [system]|[version] - e.g. http://loinc.org|2.56
* **force-system-version**: Edge Case: Specifies a version to use for a system. This parameter overrides any specified version in the library and value sets (and any it depends on). The format is the same as a canonical URL: [system]|[version] - e.g. http://loinc.org|2.56. Note that this has obvious safety issues, in that it may result in a value set expansion giving a different list of codes that is both wrong and unsafe, and implementers should only use this capability reluctantly. It primarily exists to deal with situations where specifications have fallen into decay as time passes. If the value is override, the version used SHALL explicitly be represented in the expansion parameters
* **manifest**: Specifies an asset-collection library that defines version bindings for code systems referenced by the value set(s) being expanded. When specified, code systems identified as `depends-on` related artifacts in the library have the same meaning as specifying that code system version in the `system-version` parameter.
* **include-dependencies**: Specifies whether to include known dependencies of the artifact in the resulting package, recursively (default = true)
* **include-components**: Specifies whether to include components of the artifact in the resulting package, recursively (default = true)

The result of the packaging operation is a Bundle (or Bundles if there is a need to partition based on size) containing the artifact, tailored for content based on the requested capabilities, and any components/dependencies as specified in the parameters.

##### Requirements

The requirements operation supports the ability of a repository to determine the effective requirements of an artifact, including:

* terminology usage (code systems, value sets, and direct-reference codes)
* parameters
* dependencies (artifacts)
* data requirements

The following parameters SHOULD be supported for the requirements operations:

* **id**: The server-specific id of the artifact to be analyzed
* **url**: The canonical url of the artifact to be analyzed
* **version**: The version of the artifact to be analyzed
* **identifier**: A business identifier of the artifact to be analyzed
* **expression**: If appropriate for the type of artifact, specific expressions or components to be analyzed. If not specified, the analysis is performed for the entire artifact
* **parameters**: Any input parameters for the artifact. Parameters defined in this input will be bound by name to parameters defined in the CQL library (or referenced libraries). Parameter types are mapped to CQL as specified in the Using CQL section of this implementation guide. If a parameter appears more than once in the input Parameters resource, it is represented with a List in the input CQL. If a parameter has parts, it is represented as a Tuple in the input CQL.
* **manifest**: Specifies an asset-collection library that defines version bindings for code systems referenced by value set(s) or other artifacts used in the artifact. When specified, code systems identified as `depends-on` related artifacts in the library have the same meaning as specifying that code system version in the `system-version` parameter.
* **include-dependencies**: Specifies whether to follow known dependencies of the artifact as part of the analysis, recursively (default = true)
* **include-components**: Specifies whether to follow known components of the artifact as part of the analysis, recursively (default = true)

The result of the requirements operation is a _module-definition_ Library that returns the computed effective requirements of the artifact.

##### Submit

The _submit_ operation supports posting a new artifact in _draft_ status. This operation is defined as a `POST` (or `PUT` if the server supports client-defined ids) of the artifact resource, but the status of the posted resource is required to be _draft_.

##### Revise

The _revise_ operation supports updating an existing artifact in _draft_ status. This operation is defined as a `PUT` of the artifact resource, but the status of both the existing and updated resources is required to be _draft_.

##### Withdraw

The _withdraw_ operation supports deleting an existing artifact in _draft_ status. This operation is defined as a `DELETE` of the artifact resource, but the status of the deleted resource is required to be _draft_.

##### Review

The _review_ operation supports applying a review to an existing artifact, regardless of status. The operation sets the _date_ and _lastReviewDate_ elements of the reviewed artifact, and is otherwise only allowed to add _artifactComment_ elements to the artifact, and to add or update a _reviewer_.

##### Approve

The _approve_ operation supports applying an approval to an existing artifact, regardless of status. The operation sets the _date_ and _approvalDate_ elements of the approved artifact, and is otherwise only allowed to add _artifactComment_ elements to the artifact, and to add or update an _endorser_.

##### Publish

The _publish_ operation supports posting a new artifact with _active_ status. The operation is defined as a `POST` (or `PUT` if the server supports client-defined ids) of the artifact resource, but the status of the posted resource is required to be _active_.

##### Release

The _release_ operation supports updating the status of an existing _draft_ artifact to _active_. The operation sets the _date_ element of the resource, but is otherwise not allowed to change any other elements of the artifact.

##### Retire

The _retire_ operation supports updating the status of an existing _active_ artifact to _retired_. The operation sets the _date_ element of the resource, but is otherwise not allowed to change any other elements of the artifact.

* [**Archive**](#archive): Delete a _retired_ artifact

##### Archive

The _archive_ operation supports removing an existing _retired_ artifact from the repository. The operation is defined as a `DELETE` but the status of the deleted resource is required to be _retired_.

### Shareable Measure Repository

The ShareableMeasureRepository capability statement defines the minimum expectations for a measure repository that provides basic access to shareable measure content. It describes the minimum required functionality for sharing FHIR-based measure content.

The [CQFMShareableMeasureRepository](CapabilityStatement-shareable-measure-repository.html) capability statement captures these requirements formally, while the following sections provide a narrative description of them.

#### Libraries

A ShareableMeasureRepository:

1. SHALL Represent basic Library information, as specified by the [CQFMLibrary](StructureDefinition-library-cqfm.html) profile, which includes url, identifier, version, name, title, type, status, experimental, date, publisher, contact, description, useContext, and jurisdiction.

2. For computable libraries, SHALL represent computable Library information, as specified by the [CQFMComputableLibrary](StructureDefinition-computable-library-cqfm.html) profile.

3. For executable libraries, SHALL represent executable Library information, as specified by the [CQFMExecutableLibrary](StructureDefinition-executable-library-cqfm.html) profile.

2. For published libraries, SHALL represent publishable Library information, as specified by the [CQFMPublishableLibrary](StructureDefinition-publishable-library-cqfm.html) profile.

3. SHALL support Library read by the server-defined id for the Library

4. SHALL support Library searches by:
    1. SHALL url: Returning all versions of the library matching that url
    2. SHALL version: Returning the library matching that version (can appear only in combination with a url search)
    3. SHALL identifier: Returning any library matching the identifier
    4. SHALL name: Returning any library matching the name, according to the string-matching semantics in FHIR
    5. SHALL title: Returning any library matching the title, according to the string-matching semantics in FHIR
    6. SHALL status: Returning libraries that match the given status
    7. SHALL description: Returning any Library matching the search description, according to string-matching semantics in FHIR

#### Measures

A ShareableMeasureRepository:

1. SHALL Represent basic Measure information, as specified by the [CQFMMeasure](StructureDefinition-measure-cqfm.html) profile, which includes url, identifier, version, name, title, type, status, experimental, date, publisher, contact, description, useContext, and jurisdiction.

2. For computable measures, SHALL represent computable Measure information, as specified by the [CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html) profile.

2. For published measures, SHALL represent publishable Measure information, as specified by the [CQFMPublishableMeasure](StructureDefinition-publishable-measure-cqfm.html) profile.

3. SHALL support Measure read by the server-defined id for the Measure

4. SHALL support Measure searches by:
    1. SHALL url: Returning all versions of the measure matching that url
    2. SHALL version: Returning the measure matching that version (can appear only in combination with a url search)
    3. SHALL identifier: Returning any measure matching the identifier
    4. SHALL name: Returning any measure matching the name, according to the string-matching semantics in FHIR
    5. SHALL title: Returning any measure matching the title, according to the string-matching semantics in FHIR
    6. SHALL status: Returning measures that match the given status
    7. SHALL description: Returning any measure matching the search description, according to string-matching semantics in FHIR

### Publishable Measure Repository

The PublishableMeasureRepository capability statement expresses additional functionality that SHOULD be provided in support of providing published FHIR quality measures including additional searching and packaging capabilities.

The [CQFMPublishableMeasureRepository](CapabilityStatement-publishable-measure-repository.html) capability statement captures these requirements formally, while the following sections provide a narrative description of them.

#### Libraries

A PublishableMeasureRepository:

1. SHALL support library packaging: [Library/$package](OperationDefinition-Library-package.html) operation
    1. SHALL support the url parameter
    2. SHALL support the version parameter
    3. SHOULD support the offset parameter
    4. SHOULD support the count parameter
    5. SHOULD support system-version parameter (overrides code system versions specified in the manifest)
    6. SHOULD support check-system-version parameter (overrides code system versions specified in the manifest)
    7. SHOULD support force-system-version parameter (overrides code system versions specified in the manifest)
    8. SHOULD support manifest parameter (provides a reference to a manifest to be used for the packaging)
    9. SHOULD support include-components parameter
    10. SHOULD support include-dependencies parameter

2. SHALL support library requirements analysis: [Library/$data-requirements](OperationDefinition-Library-data-requirements.html) operation
    1. SHALL support the id parameter
    2. SHALL support the url parameter
    3. SHALL support the version parameter
    4. SHALL support the identifier parameter
    5. SHOULD support the expression parameter
    6. SHOULD support the parameters parameter
    7. SHOULD support system-version parameter (overrides code system versions specified in the manifest)
    8. SHOULD support check-system-version parameter (overrides code system versions specified in the manifest)
    9. SHOULD support force-system-version parameter (overrides code system versions specified in the manifest)
    10. SHOULD support manifest parameter (provides a reference to a manifest to be used for the packaging)
    11. SHOULD support include-components parameter
    12. SHOULD support include-dependencies parameter

3. SHOULD support library Metadata searches:
    1. date: Returning all libraries matching the given date
    2. effective: Returning all libraries matching the given effectivePeriod
    3. jurisdiction: Returning all libraries matching the given jurisdiction
    4. context: Returning all libraries with a use context value matching the given context
    5. context-type: Returning all libraries with a use context type matching the given context type
    6. context-type-quantity: Returning all libraries with a use context quantity or range matching the given quantity
    7. context-type-value: Returning all libraries with a given use context type and value
    8. topic: Returning all libraries matching the given topic

4. MAY support library RelatedArtifact searches:
    1. composed-of: Returning all libraries that have the given artifact as a component
    2. depends-on: Returning all libraries that have the given artifact as a dependency
    3. derived-from: Returning all libraries that are derived from the given artifact
    4. successor: Returning all libraries that have the given artifact as a successor
    5. predecessor: Returning all libraries that have the given artifact as a predecessor

#### Measures

A PublishableMeasureRepository:

1. SHALL support measure packaging: [Measure/$package](OperationDefinition-Measure-package.html) operation
    1. SHALL support the url parameter
    2. SHALL support the version parameter
    3. SHOULD support the offset parameter
    4. SHOULD support the count parameter
    5. SHOULD support system-version parameter (overrides code system versions specified in the manifest)
    6. SHOULD support check-system-version parameter (overrides code system versions specified in the manifest)
    7. SHOULD support force-system-version parameter (overrides code system versions specified in the manifest)
    8. SHOULD support manifest parameter (provides a reference to a manifest to be used for the packaging)

2. SHALL support measure requirements analysis: [Measure/$data-requirements](OperationDefinition-Measure-data-requirements.html) operation
    1. SHALL support the id parameter
    2. SHALL support the url parameter
    3. SHALL support the version parameter
    4. SHALL support the identifier parameter
    5. SHOULD support the expression parameter
    6. SHOULD support the parameters parameter
    7. SHOULD support system-version parameter (overrides code system versions specified in the manifest)
    8. SHOULD support check-system-version parameter (overrides code system versions specified in the manifest)
    9. SHOULD support force-system-version parameter (overrides code system versions specified in the manifest)
    10. SHOULD support manifest parameter (provides a reference to a manifest to be used for the packaging)
    11. SHOULD support include-components parameter
    12. SHOULD support include-dependencies parameter

3. SHOULD support measure Metadata searches:
    1. date: Returning all measures matching the given date
    2. effective: Returning all measures matching the given effectivePeriod
    3. jurisdiction: Returning all measures matching the given jurisdiction
    4. context: Returning all measures with a use context value matching the given context
    5. context-type: Returning all measures with a use context type matching the given context type
    6. context-type-quantity: Returning all measures with a use context quantity or range matching the given quantity
    7. context-type-value: Returning all measures with a given use context type and value
    8. topic: Returning all measures matching the given topic

4. MAY support library RelatedArtifact searches:
    1. composed-of: Returning all measures that have the given artifact as a component
    2. depends-on: Returning all measures that have the given artifact as a dependency
    3. derived-from: Returning all measures that are derived from the given artifact
    4. successor: Returning all measures that have the given artifact as a successor
    5. predecessor: Returning all measures that have the given artifact as a predecessor

#### MeasureReports

A PublishableMeasureRepository:

1. MAY support representation of test cases using the [CQFMTestCase](StructureDefinition-test-case-cqfm.html) profile.

1. MAY support retrieval of test cases by server-specific id through the MeasureReport/read interaction

1. MAY support searching of test cases by the `measure` search parameter

1. MAY support including test cases in measure packages.

1. MAY support test case packaging: [MeasureReport/$package](OperationDefinition-MeasureReport-package.html) operation

### Authoring Measure Repository

The AuthoringMeasureRepository capability statement defines additional capabilities that are required to support content authoring workflows in a shared environment. For systems that do not exchange in progress content, or support external review/approval processes, these capabilities are not required to be exposed.

The [CQFMAuthoringMeasureRepository](CapabilityStatement-authoring-measure-repository.html) capability statement captures these requirements formally, while the following sections provide a narrative description of them.

#### Libraries

An AuthoringMeasureRepository:

1. SHALL support [**Submit**](#submit): Post a new library in _draft_ status
2. SHALL support [**Revise**](#revise): Update an existing library in _draft_ status
3. SHOULD support [**Withdraw**](#withdraw): Delete a _draft_ library
4. SHOULD support [**Review**](#review): Review and provide comments on an existing library (regardless of status)
5. SHOULD support [**Approve**](#approve): Approve and provide comments on an existing library (regardless of status)
6. SHALL support [**Publish**](#publish): Post a new library with _active_ status
7. SHALL support [**Release**](#release): Update an existing _draft_ library to _active_
8. SHOULD support [**Retire**](#retire): Post an update that sets status to _retired_ on an existing _active_ library
9. SHOULD support [**Archive**](#archive): Delete a _retired_ library

#### Measures

An AuthoringMeasureRepository:

1. SHALL support [**Submit**](#submit): Post a new measure in _draft_ status
2. SHALL support [**Revise**](#revise): Update an existing measure in _draft_ status
3. SHOULD support [**Withdraw**](#withdraw): Delete a _draft_ measure
4. SHOULD support [**Review**](#review): Review and provide comments on an existing measure (regardless of status)
5. SHOULD support [**Approve**](#approve): Approve and provide comments on an existing measure (regardless of status)
6. SHALL support [**Publish**](#publish): Post a new measure with _active_ status
7. SHALL support [**Release**](#release): Update an existing _draft_ measure to _active_
8. SHOULD support [**Retire**](#retire): Post an update that sets status to _retired_ on an existing _active_ measure
9. SHOULD support [**Archive**](#archive): Delete a _retired_ measure
