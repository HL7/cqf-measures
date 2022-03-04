# Quality Measure IG STU3 Change Log

This log details the changes that have occurred to the Quality Measure IG since the STU3 Ballot Publication (v2.1.0).
These changes will be published as part of the STU3 release (v3.0.0)

## Terminology Services Change Summary

### Changes to the CQFMExecutableValueSet profile:

* Changed the warning extension from cqfm-usageWarning to valueset-warning (base extension)
* Changed the fixed value of the warning extension to discuss conformance only (moved guidance to the IG)
* Changed expansion contains elements to require a version unless the parameters element has a system-version for the system

### Changes to the CQFMQualityProgram profile:

* Removed cqfm-activeOnly and cqfm-expansionUri extensions in favor of the more general cqfm-expansionParameters extension

### Changes to the ValueSet/$expand operation:

* Clarified semantics of the manifest parameter
* Clarified semantics of the expansion parameter
* Changed includePreview parameter to includeDraft

### Changes to the Measure Terminology Service:

* Added Expansion Rules to describe expected expansion behavior in the presence of a manifest
* Recommended support for useContext search parameters
* Recommended support for reference search parameters

#### Changes to align with FHIR publishing

* Added support for the `terminology` model of a server's capability statement
* Added support for batch operations for $validate-code
* Required support for `activeOnly` and `displayLanguage` in $validate-code
* Required support for `activeOnly`, `displayLanguage`, `limitedExpansion`, and `default-to-latest-version` parameters in $expand
* Recommended support for `includeDesignation`, `designation`, and `paging` parameters in $expand

### Outstanding Questions

* Search by URL should return all versions with that URL, otherwise there is no way to get the list of versions for a given value set URL
* If searches return a SUBSETTED resource by default, should the server should allow the _summary=false parameter to request full resources?
* Given the `id` of a ValueSet is the OID, how can I retrieve specific versions of a ValueSet?
* How can I retrieve a list of available expansions for a given ValueSet URL?
* Can I use a GET to invoke $expand with both the url and valueSetVersion parameters? (Connectathon testing resulted in an error)

## Measure Representation Change Summary

### Changes to the CQFMMeasure profile:

* Required CQFMMeasure Library reference to be a CQFMLibrary
* Changed Measure.type binding to use V3 codes

### Changes to the CQFMComputableMeasure profile:

* Changed cardinality of group to 0..*
* Changed the representation of effective data requirements on a measure to use a contained module definition library, rather than extensions in the measure
* Added fhirQueryPattern extension to communicate FHIR queries
* Added isSelective extension to dataRequirement
* Added valueFilter extension to support additional filtering in dataRequirement

### Changes to measure repository service:

* Removed the bundle-based packaging profiles in favor of artifact-based profiles to ensure artifact packaging can use paging when artifact packages contain a large number of components
* Added support for advertising CQL version support

### Changes to measure authoring:

* Allowed any number of models to be referenced, rather than requiring one and only one reference to QICore
* Recommended not disabling method invocation to allow fluent functions to be used
* Added support for mixed-basis ratio measure
* Added ability to associated stratifiers with specific populations
* Added the ability to specify scoringUnit for a measure

## Detailed Change Lists by Impact

### Non-Compatible Changes

* [**FHIR-33975**](https://jira.hl7.org/browse/FHIR-33975): Changed executable value set to use the warning extension from the base specification
* [**FHIR-33971**](https://jira.hl7.org/browse/FHIR-33971): Restricted the use of the content element in a quality program
* [**FHIR-33178**](https://jira.hl7.org/browse/FHIR-33178): Required CQFMMeasure library reference to be a CQFMLibrary
* [**FHIR-32748**](https://jira.hl7.org/browse/FHIR-32748): Changed cardinality of group to 0..*
* [**FHIR-32594**](https://jira.hl7.org/browse/FHIR-32594): Changed the representation of expansion parameters to use a contained parameters resource rather than specific extensions per parameter
* [**FHIR-32593**](https://jira.hl7.org/browse/FHIR-32593): Changed the representation of effective data requirements on a measure to use a contained module definition library, rather than extensions in the measure
* [**FHIR-32046**](https://jira.hl7.org/browse/FHIR-32046): Changed Measure.type binding to use V3 codes
* [**FHIR-30079**](https://jira.hl7.org/browse/FHIR-30079): Removed the bundle-based packaging profiles in favor of artifact-based profiles to ensure that artifact packaging can use paging when artifact packages contain a large number of components

### Compatible, Substantive Changes

* [**FHIR-34290**](https://jira.hl7.org/browse/FHIR-34290): Added capabilities to the measure terminology service to align with publishing terminology service capabilities
* [**FHIR-33970**](https://jira.hl7.org/browse/FHIR-33970): Added searching by useContext
* [**FHIR-33968**](https://jira.hl7.org/browse/FHIR-33968): Added searching for valuesets by artifacts that reference the value set
* [**FHIR-33458**](https://jira.hl7.org/browse/FHIR-33458): Added the fhirQueryPattern extension to support representing the FHIR query for a given data requirement
* [**FHIR-33045**](https://jira.hl7.org/browse/FHIR-33045): Added the ability to represent a mixed-basis population ratio measure (i.e. a ratio between encounters and procedures)
* [**FHIR-32970**](https://jira.hl7.org/browse/FHIR-32970): Relaxed conformance requirements on the use of QI Core from SHALL to SHOULD, to allow any FHIR IG(s) to be used for measure development
* [**FHIR-32969**](https://jira.hl7.org/browse/FHIR-32969): Added derivedFrom slice to support identifying previous versions of a measure
* [**FHIR-32808**](https://jira.hl7.org/browse/FHIR-32808): Added an invariant to ensure system-version is unambiguously communicated for all the codes in an expansion
* [**FHIR-32686**](https://jira.hl7.org/browse/FHIR-32686): Added an isSelective extension to support identifying "selective" data requirements (i.e. criteria that are positively indicative and likely to be selective of initial population membership)
* [**FHIR-32675**](https://jira.hl7.org/browse/FHIR-32675): Added the ability for a FHIR server to advertise the versions of CQL it supports
* [**FHIR-32671**](https://jira.hl7.org/browse/FHIR-32671): Added the ability to specify CQLOptions using a parameters resource
* [**FHIR-32668**](https://jira.hl7.org/browse/FHIR-32668): Added conformance expectations and guidance for specifying the version of CQL/ELM content in a library
* [**FHIR-32372**](https://jira.hl7.org/browse/FHIR-32372): Added a valueFilter extension to support representing additional filtering criteria in a data requirement
* [**FHIR-32334**](https://jira.hl7.org/browse/FHIR-32334): Added defaultValue extension to support representing default values for parameters
* [**FHIR-32231**](https://jira.hl7.org/browse/FHIR-32231): Updated measure narrative generation to display logic items in alphabetical order
* [**FHIR-31921**](https://jira.hl7.org/browse/FHIR-31921): Changed "preview" parameter in valueSet$expand operation to "includeDraft"
* [**FHIR-31680**](https://jira.hl7.org/browse/FHIR-31680): Added the ability to associated stratifiers with specific populations
* [**FHIR-31624**](https://jira.hl7.org/browse/FHIR-31624): Corrected all-or-none composite measure calculation formulas
* [**FHIR-31409**](https://jira.hl7.org/browse/FHIR-31409): Added quality domain and meaningful measure area to be specified for measures in a quality program
* [**FHIR-30875**](https://jira.hl7.org/browse/FHIR-30875): Added measure repository service capability statement and description
* [**FHIR-30874**](https://jira.hl7.org/browse/FHIR-30874): Added measure terminology service capability statement and description
* [**FHIR-30873**](https://jira.hl7.org/browse/FHIR-30873): Added support for composite measures both within and across FHIR Measure resources
* [**FHIR-30770**](https://jira.hl7.org/browse/FHIR-30770): Added a ModelDefinition profile to support the use of FHIR Library resources containing CQL ModelInfo content
* [**FHIR-30569**](https://jira.hl7.org/browse/FHIR-30569): Added conformance requirements for the use of FHIR Library resources containing CQL content
* [**FHIR-30506**](https://jira.hl7.org/browse/FHIR-30506): Added the ability to specify the scoringUnit of a measure
* [**FHIR-30395**](https://jira.hl7.org/browse/FHIR-30395): Added slices for version-independent, version-specific, short-name, publisher, and endorser identifiers for measures
* [**FHIR-30394**](https://jira.hl7.org/browse/FHIR-30394): Added a ComputableMeasure profile to represent the formal computation aspects common to all quality measures, regardless of the scoring method
* [**FHIR-28338**](https://jira.hl7.org/browse/FHIR-28338): Added criteriaReference extension to the Ratio measure profile to support dual initial populations
* [**FHIR-27878**](https://jira.hl7.org/browse/FHIR-27878): Relaxed conformance requirements on stratifier criteria to allow the use of codes and paths to elements
* [**FHIR-27795**](https://jira.hl7.org/browse/FHIR-27795): Added inputParameters extension to support identifying the input parameters for a test case
* [**FHIR-21107**](https://jira.hl7.org/browse/FHIR-21107): Added conformance requirement to support composite measure representation

### Non-substantive Changes

* [**FHIR-34882**](https://jira.hl7.org/browse/FHIR-34882): Added a data repository role to the quality reporting sequence diagram to make clear the separation between reporting capabilities and data repository capabilities
* [**FHIR-34197**](https://jira.hl7.org/browse/FHIR-34197): Changed guidance on the use of DisableMethodInvocation to ensure fluent functions can be used in quality measures going forward
* [**FHIR-33992**](https://jira.hl7.org/browse/FHIR-33992): Corrected broken hyperlink
* [**FHIR-33967**](https://jira.hl7.org/browse/FHIR-33967): Clarified behavior of expansions when expansion parameters are specified in both the expand operation and the manifest used
* [**FHIR-33966**](https://jira.hl7.org/browse/FHIR-33966): Clarified conformance requirements versus usage guidance in the executable value set profile
* [**FHIR-33016**](https://jira.hl7.org/browse/FHIR-33016): Added guidance on avoiding the use of direct reference codes for UCUM units
* [**FHIR-32884**](https://jira.hl7.org/browse/FHIR-32884): Corrected headings throughout
* [**FHIR-32747**](https://jira.hl7.org/browse/FHIR-32747): Corrected typographical error
* [**FHIR-32746**](https://jira.hl7.org/browse/FHIR-32746): Corrected typographical error
* [**FHIR-32745**](https://jira.hl7.org/browse/FHIR-32745): Corrected typographical error
* [**FHIR-32744**](https://jira.hl7.org/browse/FHIR-32744): Validated examples conform to expected profiles
* [**FHIR-32742**](https://jira.hl7.org/browse/FHIR-32742): Clarified documentation of the use of value sets during the authoring phase of the content management lifecycle
* [**FHIR-32741**](https://jira.hl7.org/browse/FHIR-32741): Corrected typographical error
* [**FHIR-32740**](https://jira.hl7.org/browse/FHIR-32740): Clarified that the measure repository services are represented with a focus on measures, but conceptually are broadly applicable to other types of knowledge artifacts
* [**FHIR-32739**](https://jira.hl7.org/browse/FHIR-32739): Clarified that the measure terminology service is represented with a focus on measures, but conceptually is broadly applicable to other types of knowledge artifacts
* [**FHIR-32738**](https://jira.hl7.org/browse/FHIR-32738): Added an introductory description for the quality reporting sequence diagram
* [**FHIR-32737**](https://jira.hl7.org/browse/FHIR-32737): Clarified quality program examples
* [**FHIR-32736**](https://jira.hl7.org/browse/FHIR-32736): Clarified quality program documentation
* [**FHIR-32735**](https://jira.hl7.org/browse/FHIR-32735): Clarified measure implementation as the focus of capabilities supported by this IG
* [**FHIR-32734**](https://jira.hl7.org/browse/FHIR-32734): Fixed typographical error
* [**FHIR-32733**](https://jira.hl7.org/browse/FHIR-32733): Clarified definition of a quality measure in the IG introduction
* [**FHIR-32732**](https://jira.hl7.org/browse/FHIR-32732): Clarified the metric development step in the quality improvement ecosystem discussion
* [**FHIR-32731**](https://jira.hl7.org/browse/FHIR-32731): Added registries as a stakeholder in the quality improvement ecosystem
* [**FHIR-32730**](https://jira.hl7.org/browse/FHIR-32730): Added internal quality improvement initiatives as a use case in the quality improvement ecosystem discussion
* [**FHIR-32729**](https://jira.hl7.org/browse/FHIR-32729): Clarified that payers are not primary developers of clinical guidelines
* [**FHIR-32728**](https://jira.hl7.org/browse/FHIR-32728): Clarified that improvement of clinical care is the focus of the quality improvement ecosystem
* [**FHIR-32727**](https://jira.hl7.org/browse/FHIR-32727): Clarified cyclic nature of the quality improvement ecosystem
* [**FHIR-32726**](https://jira.hl7.org/browse/FHIR-32726): Added internal quality improvement initiatives as a potential use case in the quality improvement ecosystem discussion
* [**FHIR-32725**](https://jira.hl7.org/browse/FHIR-32725): Highlighted the role of clinician judgement in the quality improvement ecosystem discussion
* [**FHIR-32722**](https://jira.hl7.org/browse/FHIR-32722): Added additional examples of stakeholders to the quality improvement ecosystem discussion
* [**FHIR-32688**](https://jira.hl7.org/browse/FHIR-32688): Noted that multiple versions of the same code system may be used in a single $expand
* [**FHIR-32687**](https://jira.hl7.org/browse/FHIR-32687): Clarified that expansion identifiers are server-specific
* [**FHIR-32651**](https://jira.hl7.org/browse/FHIR-32651): Added examples of expansions given the use of a manifest parameter
* [**FHIR-32596**](https://jira.hl7.org/browse/FHIR-32596): Added Must Support documentation
* [**FHIR-32199**](https://jira.hl7.org/browse/FHIR-32199): Corrected layout issue
* [**FHIR-32079**](https://jira.hl7.org/browse/FHIR-32079): Added discussion about referencing any FHIR type, as opposed to only FHIR types profiled by QI Core
* [**FHIR-31942**](https://jira.hl7.org/browse/FHIR-31942): Fixed a typographical error
* [**FHIR-31941**](https://jira.hl7.org/browse/FHIR-31941): Clarified description of Conformance Requirement 3.15
* [**FHIR-31940**](https://jira.hl7.org/browse/FHIR-31940): Fixed a typographical error
* [**FHIR-31592**](https://jira.hl7.org/browse/FHIR-31592): Clarified description of population criteria in the population scoring algorithm diagrams
* [**FHIR-30764**](https://jira.hl7.org/browse/FHIR-30764): Added trial-use note seeking feedback on the usefulness of a "Measure Source" metadata attribute
* [**FHIR-30401**](https://jira.hl7.org/browse/FHIR-30401): Added discussion of the use of Group resource to characterize attribution models, such as DaVinci Attribution (ATR)
* [**FHIR-29649**](https://jira.hl7.org/browse/FHIR-29649): Duplicate of 28239
* [**FHIR-28303**](https://jira.hl7.org/browse/FHIR-28303): Added mapping from V3 Aggregate Method to FHIR Aggregate Method
* [**FHIR-28302**](https://jira.hl7.org/browse/FHIR-28302): Added mapping from V3 Composite Measure Scoring to FHIR Composite Measure Scoring
* [**FHIR-28301**](https://jira.hl7.org/browse/FHIR-28301): Added mapping from V3 Measure Scoring to FHIR Measure Scoring
* [**FHIR-28300**](https://jira.hl7.org/browse/FHIR-28300): Added mapping from V3 Measure Types to FHIR Measure Types
* [**FHIR-28290**](https://jira.hl7.org/browse/FHIR-28290): Clarified the definition of population basis
* [**FHIR-28288**](https://jira.hl7.org/browse/FHIR-28288): Updated examples to use "citation" related artifact code, rather than "documentation" when they were citations of references
* [**FHIR-28239**](https://jira.hl7.org/browse/FHIR-28239): Corrected cardinality of CQFMMeasure.profile meta constraint
* [**FHIR-28238**](https://jira.hl7.org/browse/FHIR-28238): Corrected cardinality of CQFMLibrary.profile meta constraint
* [**FHIR-28210**](https://jira.hl7.org/browse/FHIR-28210): Corrected description of EXM146 as an encounter-based measure
* [**FHIR-28206**](https://jira.hl7.org/browse/FHIR-28206): Updated glossary terms
* [**FHIR-26331**](https://jira.hl7.org/browse/FHIR-26331): Corrected breadcrumbs display throughout the IG
* [**FHIR-26329**](https://jira.hl7.org/browse/FHIR-26329): Updated the IG to use the standard HL7 FHIR IG template
