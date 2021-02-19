---
layout: default
title: Measure Terminology Service
---

# Overview
This page describes documents the use cases and conformance expectations of a terminology service to support authoring, distribution, and evaluation of FHIR-based quality measure specifications as described in this implementation guide.

## Code Systems

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
identified by the code system. For SNOMED-CT, this means the version string
is required to specify the edition and the version:

```
http://snomed.info/sct/731000124108/version/20150301
```

The edition identifier for the US Edition is `731000124108`, and the version in the
above example is the March 2015 release, specified as YYYYMMDD, `20150301`.

## Value Sets

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
    7. SHOULD support the `manifest` parameter (defined in the [cqfm-valueset-expand](OperationDefinition-cqfm-valueset-expand.html))

9. TODO: Determine whether eCQM content development will ever need to be able to reference FHIR-defined value sets.

## Quality Programs (Binding Parameters Specification)

1. SHALL Represent basic quality program release information, as specified by the [CQFMQualityProgram](StructureDefinition-quality-program-cqfm.html) profile, which includes identifier, title, type, date, useContext, effectivePeriod, measure, library, and terminology references

2. For published quality programs, SHALL represent publishable quality program information as specified by the [CQFMPublishableLibrary](StructureDefinition-publishable-library-cqfm.html) profile.

3. SHALL support Quality Program (Library) read, by the server-defined id for the quality program library

4. SHALL support Quality Program (Library) searches by:
    1. SHALL url: Returning all versions of the quality program matching that url
    2. SHALL version: Returning the quality program matching that version (can appear only in combination with a url search)
    3. SHALL identifier: Returning any quality program matching the identifier
    4. SHALL name: Returning any quality program matching the name, according to the string-matching semantics in FHIR
    5. SHALL title: Returning any quality program matching the title, according to the string-matching semantics in FHIR
    6. SHOULD status: Returning quality programs that match the given status
    7. SHALL description: Returning any quality programs matching the search description, according to string-matching semantics in FHIR
    8. SHALL composed-of: Returning any quality program that includes the given measure canonical
    9. SHALL depends-on: Returning any quality program that references the given code system or value set canonical

5. SHALL support quality program value set packaging: [Library/$package](OperationDefinition-Library-package.html) operation
    1. SHALL support the url parameter
    2. SHALL support the version parameter
    3. SHOULD support the offset parameter
    4. SHOULD support the count parameter
    5. SHOULD support system-version parameter (overrides code system versions specified in the quality program release)
    6. SHOULD support check-system-version parameter (overrides code system versions specified in the quality program release)
    7. SHOULD support force-system-version parameter (overrides code system versions specified in the quality program release)

## Capability Statement

The above capabilities are formally captured in the following capability statement:

[CQFMMeasureTerminologyService](CapabilityStatement-measure-terminology-service.html)

TODO: Support paged operations for: Code lookup, validation, expansion
TODO: Consider how Measure value set and terminology usage is determined by the Terminology Service

## Examples

### Expansion of a value set that contains "legacy codes"

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

#### Current expand

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

#### Current expand, activeOnly

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

#### Version-specific expand

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
bound to the 2019-09 version of the US Edition of the SNOMED code system (http://snomed.info/sct/731000124108/version/201909).

### Quality Program Release (i.e. Version Manifest, or Binding Parameters Specification)

The following example illustrates an unversioned quality program specification,
referencing a single version and providing no version dependency bindings:

* [QualityProgramExample](Library-quality-program-example.html)

Specifically, the `composed-of` element of the library resource is used to identify
the measures included in the quality program:

```
"relatedArtifact": [
  {
    "type": "composed-of",
    "resource": "http://hl7.org/fhir/us/cqfmeasures/Measure/measure-exm",
    "display": "Example Measure"
  }
]
```

For the version binding information, the following _release_ of the quality program
illustrates specifying the versions of codesystem, valueset, and library dependencies
used by the measure in the quality program:

* [QualityProgramExample202005](Library-quality-program-example-2020-05.html)

Specifically, the `composed-of` element of the library resource now includes the version
of the measure, and the `depends-on` elements are used to specify version bindings
for the SNOMED-CT code system, and the library and value set dependencies of the
measure:

```
"relatedArtifact": [
  {
    "type": "composed-of",
    "resource": "http://hl7.org/fhir/us/cqfmeasures/Measure/measure-exm|2.0.0",
    "display": "Example Measure"
  },
  {
    "type": "depends-on",
    "resource": "http://hl7.org/fhir/Library/FHIR-ModelInfo|4.0.1"
  },
  {
    "type": "depends-on",
    "resource": "http://hl7.org/fhir/Library/FHIRHelpers|4.0.1"
  },
  {
    "type": "depends-on",
    "resource": "http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20190901"
  },
  {
    "type": "depends-on",
    "resource": "http://hl7.org/fhir/us/cqfmeasures/ValueSet/chronic-liver-disease-legacy-example|2020-05"
  }
]
```

Given the use of this _version manifest_, then the _manifest_ parameter can be used
in the `$expand` operation to provide values for the relevant parameters:

```
[base]/ValueSet/chronic-liver-disease-legacy-example/$expand?manifest=http://hl7.org/fhir/us/cqfmeasures/Library/quality-program-example-2020-05
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
      "valueUri": "http://hl7.org/fhir/us/cqfmeasures/Library/quality-program-example-2020-05"
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
