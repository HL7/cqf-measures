{:toc}

Measure developers should review the Using CQL with FHIR IG for specific guidance on CQL use.  Please note the following exceptions that guidance listed below:

### Libraries
{: #libraries}

For information on libraries, please reference section 2.1 in the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#libraries).

 1.	In addition to the conformance statements listed in section 2.1 of the Using CQL with FHIR IG, these two additional conformance statements need to be considered:

#### Library Versioning
{: #library-versioning}

This IG recommends an approach to versioning libraries used in section 2.2 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#library-versioning).  

#### Library Namespaces
{: #library-namespaces}
For guidance on library namespaces, refer to section 2.1.3 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#library-namespaces).

### Data Model
{: #data-model}

CQL can be used with any data model. In the context of a Measure, any referenced CQL library must identify the same data model. Additional information can be found in the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#data-model).


### Code Systems
{: #code-systems}

Please reference the [Using CQL with FHIR IG Section 2.3](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#code-systems).

### Value Sets
{: #value-sets}

For information on value sets, referecnce section 2.4 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#value-sets).

#### Value Set Version
{: #value-set-version}

Information on value set versioning can be found in the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#value-set-version).

#### Value Set Expansion

For information on value set expansion, reference the [Using CQL with FHIR IG section 2.4.2](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#value-set-expansion).

#### Representation in a Library
{: #representation-in-a-library}

The representation of valueset declarations in a Library is discussed in the [Measure Conformance Chapter](measure-conformance.html) of this IG.

#### String-based Membership Testing
{: #string-based-membership-testing}

Please reference section 2.4.4 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#string-based-membership-testing).

### Codes
{: #codes}

Please reference section 2.5 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#codes).

#### Representation in a Library
{: #representation-in-a-library}

Please reference section 2.5.1 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#code-representation-in-narrative).

The representation of code declarations in a Library is discussed in [Measure Conformance Chapter](measure-conformance.html) of this IG.

### UCUM Best Practices
{: #ucum-best-practices}

Please reference section 2.6 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#ucum-best-practices).

### Concepts
{: #concepts}

Please reference section 2.7 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#concepts)

### Library-level Identifiers
{: #library-level-identifiers}

Please reference section 2.8 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#library-level-identifiers).

### Data Type Names
{: #data-type-names}

Please reference section 2.9 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#data-type-names).

For information on Missing information and how to model that using CQL, please reference section 2.10 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#missing-information).

#### Negation in FHIR
{: #negation-in-fhir}

For information on the various uses of negation in FHIR, please review section 2.11 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#negation-in-fhir).

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

Please reference section 2.13 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#aliases-and-argument-names).

### Library Resources
{: #library-resources}

Please reference the [Using CQL with FHIR IG section 2.14.1](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#library-name-and-url).  
 
In addition, please consider the following conformance statement:

**Conformance Requirement 4.17 (Library Resources):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-17)
{: #conformance-requirement-4-17}

1. Content conforming to this implementation guide SHALL use at least the [CQFMLibrary](StructureDefinition-library-cqfm.html), [CQLLibrary](https://build.fhir.org/cqllibrary.html), and [CRMIShareableLibrary](https://build.fhir.org/ig/HL7/crmi-ig/StructureDefinition-crmi-shareablelibrary.html) profile for Library resources. If the library is active and published, conform to [CRMIPublishableLibrary](https://build.fhir.org/ig/HL7/crmi-ig/StructureDefinition-crmi-publishablelibrary.html).


#### FHIR Type Mapping
{: #fhir-type-mapping}

Please refer to section 2.14.2 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#fhir-type-mapping).

#### Parameters and Data Requirements
{: #parameters-and-data-requirements}

Please reference section 2.14.3 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#parameters-and-data-requirements)

#### RelatedArtifacts
{: #relatedartifacts}

Please reference section 2.14.4 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#relatedartifacts).

#### MIME Type version

Please reference section 2.14.5 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#mime-type-version).

### Use of Terminologies
{: #use-of-terminologies}

Please reference section 2.15 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#use-of-terminologies)

### Time Valued Quantities
{: #time-valued-quantities}

Please reference section 2.16 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#time-valued-quantities).

### Translation to ELM
{: #translation-to-elm}

Please reference section 2.17 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#translation-to-elm).

#### Specifying Options

<div class="new-content" markdown="1">
This implementation guide defines the [cqlOptions](StructureDefinition-cqfm-cqlOptions.html) extension to support defining the expected translator options used with a given Library, or set of Libraries. When this extension is not used, the recommended options above, including SignatureLevel, SHOULD be used. When this extension is present on a [CQFComputableLibrary](StructureDefinition-computable-library-cqfm.html), it SHALL be used to provide options to the translator when translating CQL for that library. When this extension is present on a [CQFMQualityProgram](StructureDefinition-quality-program-cqfm.html), it SHALL be used to provide options to the translator unless the options are provided directly by the library.
</div>
**Conformance Requirement 4.22 (Translator Options):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-22)
{: #conformance-requirement-4-22}

1. Translator options SHOULD be provided in either a [CRMIComputableLibrary](https://build.fhir.org/ig/HL7/crmi-ig/StructureDefinition-crmi-computablelibrary.html) or a [CRMIManifestLibrary](https://build.fhir.org/ig/HL7/crmi-ig/branches/master/StructureDefinition-crmi-manifestlibrary.html).
2. Translator options specified in a [CRMIComputableLibrary](https://build.fhir.org/ig/HL7/crmi-ig/StructureDefinition-crmi-computablelibrary.html) take precedence over options defined in a [CRMIManifestLibrary](https://build.fhir.org/ig/HL7/crmi-ig/branches/master/StructureDefinition-crmi-manifestlibrary.html).
3. If no translator options are provided, the recommended options above SHOULD be used.
4. If translator options are provided in a Library that is both computable and executable, the options SHALL be consistent with the translator options reported by the ELM content.

#### ELM Suitability

Please refer to section 2.17.2 of the [Using CQL with FHIR IG](https://hl7.org/fhir/uv/cql/2024Jan/using-cql.html#elm-suitability).