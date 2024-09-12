{:toc}

## Overview
This page documents the use cases and conformance expectations of a measure repository service to support authoring, publishing, and distribution of FHIR-based quality measure specifications as described in this implementation guide.

The measure repository service described here is a specific case of the more general knowledge repository service and is built upon operations and capabilities defined in the [Canonical Resource Management Infrastructure Implementation Guide (CRMI IG)](http://hl7.org/fhir/uv/crmi).  

This implementation guide is not prescriptive about authentication or authorization, but strongly recommends that these capabilities be addressed through standard mechanisms, as described in [FHIR standard security mechanisms](https://www.hl7.org/fhir/security.html).

### Measure and Library Management

Quality measures (QMs) and libraries are specific types of knowledge artifacts, and share common attributes with other knowledge artifact typesand are expected to conform to general artifact management principles defined in [CRMI Knowledge Artifact Management](). This section describes how general artifact management is applied to quality measures and libraries.  

#### Lifecycle

Quality Measure and libraries following a general, high-level workflow for content development: draft, active, and retired as defined in [CRMI Artifact Lifecycle]()

#### Identity

Measure and library identity directly follows [CRMI Artifact Identity guidance]()

#### Versioning

As a best practice, measure and library versions SHOULD follow semantic versioning. This approach is summarized in [CRMI Artifact Versioning.]()

#### Metadata
In addition to identity, lifecycle, and versioning, measure and libraries typically have additional metadata such as descriptive content, documentation, justification, and source. This is especially true of _published_ measures and libraries, which make this type of information available to enable consumers to find, understand, and ultimately implement the content. In FHIR, measures and libraries generally follow the [Metadata Resource](https://hl7.org/fhir/clinicalreasoning-knowledge-artifact-representation.html#metadata) pattern. 

### Shareable Measure Repository

The ShareableMeasureRepository capability statement defines the minimum expectations for a measure repository that provides basic access to shareable measure content. It describes the minimum required functionality for sharing FHIR-based measure content. 

A ShareableMeasureRepository: 

1. SHALL Represent basic Library information, as specified by the [CRMIShareableLibrary]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablelibrary.html) profile, which includes url, identifier, version, name, title, type, status, experimental, date, publisher, contact, description, useContext, and jurisdiction. 
2. For computable libraries, SHALL represent computable Library information, as specified by the [CRMIComputableLibrary]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-computablelibrary.html) profile. 
3. For executable libraries, SHALL represent executable Library information, as specified by the [ELMLibrary]({{site.data.fhir.ver.cql}}/StructureDefinition-elm-json-library.html) profile. 
4. For published libraries, SHALL represent publishable Library information, as specified by the [CRMIPublishableLibrary]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-publishablelibrary.html) profile. 
5. SHALL Represent basic Measure information, as specified by the [CRMIShareableMeasure]({{site.data.fhir.ver.crmi}}/StructureDefinition-crmi-shareablemeasure.html) profile, which includes url, identifier, version, name, title, type, status, experimental, date, publisher, contact, description, useContext, and jurisdiction. 
6. For computable measures, SHALL represent computable Measure information, as specified by the [CQFMComputableMeasure](StructureDefinition-computable-measure-cqfm.html) profile. 
7. For published measures, SHALL represent publishable Measure information, as specified by the [CQFMPublishableMeasure](StructureDefinition-publishable-measure-cqfm.html) profile.

The CQFMShareableMeasureRepository capability statement captures these requirements formally.

### Publishable Measure Repository 

The PublishableMeasureRepository capability statement expresses additional functionality that is provided in support of providing published FHIR quality measures including additional searching and packaging capabilities. 

A PublishableMeasureRepository:  

1. SHALL support library packaging: Library/$package operation 
2. SHALL support library requirements analysis: Library/$data-requirements operation 
3. SHALL support measure packaging: Measure/$package operation 
4. SHALL support measure requirements analysis: Measure/$data-requirements operation
5. SHOULD support measure search using additional publishable metadata
6. SHOULD support library search using additional publishable metadata
7. SHOULD support minimum measure write capability (Publish, Retire, Archive)
8. SHOULD support minimum library write capability (Publish, Retire, Archive) 

The CQFMPublishableMeasureRepository capability statement captures these requirements formally. 

##### MeasureReports 

A PublishableMeasureRepository: 

1. MAY support representation of test cases using the [CQFMTestCase](StructureDefinition-test-case-cqfm.html) profile. 
2. MAY support retrieval of test cases by server-specific id through the MeasureReport/read interaction 
3. MAY support searching of test cases by the measure search parameter 
4. MAY support including test cases in measure packages. 
5. MAY support test case packaging: [MeasureReport/$cqfm.package](OperationDefinition-cqfm-package.html) operation 

### Authoring Measure Repository 

The AuthoringMeasureRepository capability statement defines additional capabilities that are required to support content authoring workflows in a shared environment. For systems that do not exchange in progress content, or support external review/approval processes, these capabilities are not required to be exposed. 

For libraries and measures, an AuthoringMeasureRepository: 

1. SHALL support **Submit**: Post a new library in draft status 
2. SHALL support **Revise**: Update an existing library in draft status 
3. SHALL support **Draft**: Draft a new version of an existing library in active status 
4. SHALL support **Release**: Update an existing draft library to active 
5. SHOULD support **Clone**: Clone a new library based on the contents of an existing library(regardless of status) 
6. SHOULD support **Withdraw**: Delete a draft library 
7. SHOULD support **Review**: Review and provide comments on an existing library (regardless of status) 
8. SHOULD support **Approve**: Approve and provide comments on an existing library (regardless of status) 


The [CRMIAuthoringArtifactReposiotry]({{site.data.fhir.ver.crmi}}/CapabilityStatement-crmi-authoring-artifact-repository.html) capability statement captures these requirements formally, while the following sections provide a narrative description of them. 

