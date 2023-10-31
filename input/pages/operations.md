{: #operations}

## Operations
* [**[base]/$cqfm.package**](OperationDefinition-cqfm-package.html)
* [**Library/$cqfm.package**](OperationDefinition-cqfm-package.html)
* [**Library/[id]/$cqfm.package**](OperationDefinition-cqfm-package.html)
* [**Library/$data-requirements**](OperationDefinition-Library-data-requirements.html)
* [**Measure/[id]/$cqfm.package**](OperationDefinition-cqfm-package.html)
* [**Measure/$data-requirements**](OperationDefinition-Measure-data-requirements.html)
* [**MeasureReport/$cqfm.package**](OperationDefinition-cqfm-package.html)
* [**MeasureReport/[id]/$cqfm.package**](OperationDefinition-cqfm-package.html)
* [**ValueSet/$expand**](OperationDefinition-ValueSet-expand.html)


#### Artifact Repository Operations

To support content authoring, searching, publication, and distribution, the following general operations are defined:

* [**Retrieve**](#retrieve): Get a specific artifact by its server-specific identity
* [**Search**](#search): Search for an artifact according to specific criteria
* [**Package**](#package): Package an artifact for a particular environment (regardless of status)
* [**Requirements**](#requirements): Determine the data requirements and dependencies for a particular artifact (regardless of status)
* [**Submit**](#submit): Post a new artifact in _draft_ status
* [**Draft**](#draft): Draft a new version of an existing artifact in _active_ status
* [**Clone**](#clone): Clone a new artifact based on an existing artifact (regardless of status)
* [**Revise**](#revise): Update an existing artifact in _draft_ status
* [**Withdraw**](#withdraw): Delete a _draft_ artifact
* [**Review**](#review): Review and provide comments on an existing artifact (regardless of status)
* [**Approve**](#approve): Approve and provide comments on an existing artifact (regardless of status)
* [**Publish**](#publish): Post a new artifact with _active_ status
* [**Release**](#release): Update an existing _draft_ artifact to _active_
* [**Retire**](#retire): Post an update that sets status to _retired_ on an existing _active_ artifact
* [**Archive**](#archive): Delete a _retired_ artifact

### Server Operations

1. SHALL support the `metadata?mode=terminology`, returning a list of all supported code systems, whether they are explicitly made available as CodeSystem resources or not
