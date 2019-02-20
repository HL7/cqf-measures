---
layout: default
title: Composite Measures
---
## 6 Composite Measure Development

Composite measures make use of multiple component measures to produce a combined score. In the most general case, a composite measure is akin to a continuous variable measure, where the measure observation for each population member is some combination of his or her component measure scores. However, the calculation logic involved is detailed, and a higher-level representation of the most common composite measure calculation approaches enables a much simpler representation to work with and understand. Note that composite measures must be constructed from existing component measures. Composites do not introduce any new measure logic beyond the composite score calculation. If a composite needs to introduce new logic, a new component measure must be developed that can then be included in the composite.

    Conformance Requirement 18 (Composite Measures):
    Composite Measures SHALL include a subjectOf/measureAttribute element for measure type (code = MSRTYPE) with a value of COMPOSITE from the appropriate code system as specified by HQMF
    Composite Measures SHALL include a subjectOf/measureAttribute element for for the composite measure scoring method (code = CMPMSRMTH) with a value from the appropriate code system as specified by HQMF.

The example illustrates the use of these measure attributes to indicate a composite measure:

```xml
<subjectOf>
    <code code="MSRTYPE" codeSystem="2.16.840.1.113883.5.4">
        <displayName value="Measure Type" />
    </code>
    <value code="COMPOSITE" codeSystem="2.16.840.1.113883.5.4">
        <displayName value="Composite" />
    </value>
</subjectOf><subjectOf>
    <code code="CMPMSRMTH" codeSystem="2.16.840.1.113883.5.4">
        <displayName value="Measure Type" />
    </code>
    <value code="ALLORNONESCR" codeSystem="2.16.840.1.113883.5.1063">
        <displayName value="All-or-nothing Scoring" />
    </value>
</subjectOf>
 ```

Snippet 22: Sample Risk Adjustment Variable from TestRiskAdj eCQM.xml

Broadly speaking, composite measure scoring methods fall into two categories:

1. Individual-Based: Scoring methods that operate at the individual level by combining members of component populations and then calculating the measure score using standard measure scoring techniques on the combined populations.
2. Component-Based: Scoring methods that operate at the population level by combining the summary scores of component measures.

Architecturally, environments that are already capable of calculating measures using the measure scoring methods already described in this implementation guide can readily consume composite measure specifications that use the first approach (individual-based) but would require additional support in order to calculate component-based measures. Specifically, generic support for component-based calculation methods would require that an environment be able to evaluate CQL logic in the Population context. As such, although this implementation guide describes four composite scoring methods, only the first three individual-based composite methods are supported at this time. Future versions of this implementation guide will consider population context expressions in general, and component-based composite scoring methods in particular.

To illustrate the different composite scoring methods, an example Annual Wellness assessment measure for Eligible Clinicians (EC) is used. Note that although the scoring methods are described in terms applicable to ECs, the concepts apply in general to composites that could be built for any setting.

### 6.1 All-or-nothing Scoring

    Conformance Requirement 19 (All-or-nothing Scoring):
    All-or-nothing scoring SHALL be indicated using a subjectOf element to define a with a CMPMSRMTH measure attribute with a code of ALLORNONESCR as defined by the base HQMF specification.
    Calculation logic for all-or-nothing composite measures SHALL be functionally equivalent to the calculation formulas defined in this section.
    Calculation logic for all-or-nothing composite measures SHOULD be written in the same way as the calculation formulas defined in this section.
    Narrative descriptions of population criteria for all-or-nothing composite measures SHOULD include the narrative descriptions of the corresponding population criteria for each component measure.

All-or-nothing scoring includes an individual in the numerator of the composite measure if they are in the numerators of all of the component measures in which they are in the denominator.

Figure 5. All-or-none method

Interpretation: For each Eligible Clinician (EC), the percentage of patients who received all preventive services for which they were eligible within the specified time interval. Gives EC numerator credit only if a patient meets the criteria for all of the components of the measure for which the patient is eligible.
Example: X% of an EC’s patients received all preventive services for which they were eligible.

Individual measure | A | B | C | D | E
|----|----|----|----|----|----|
Screening for breast cancer |  | N/A | | | |
Screening for colorectal cancer |  |  |  | |  |
Pneumococcal vaccination |  | |  |  | |

An example of an “All-or-nothing” scored composite measure has been in included in examples/TestComposite/. This directory contains the composite measure, Composite eCQM.xml, and the component measures in directories Test122v5 Artifacts/ and Test131v5 Artifacts/. From Composite eCQM.xml, note the component measures are referenced in using relatedDocument elements.  Within the metadata of the measure, a subjectOf element contains the details of the "Composite Measure Scoring" as shown in Snippet 22.

```xml
<subjectOf>
    <measureAttribute>
        <code code="CMPMSRMTH" codeSystem="2.16.840.1.113883.5.4">
            <displayName value="Composite Measure Scoring" />
        </code>
        <value xsi:type="CD" code="ALLORNONESCR" codeSystem="2.16.840.1.113883.5.1063">
            <displayName value="All-or-nothing Scoring" />
        </value>
    </measureAttribute>
</subjectOf>
 ```

Snippet 23: Example All-or-nothing scored composite measure from Composite eCQM.xml

Computationally, this method amounts to expressing each population criteria for the composite measure as the union (logical ‘or’ for patient-based measures) of the respective population criteria for each component measure, except for the numerator, which is expressed as the intersection (logical ‘and’ for patient-based measures) of the numerators of the component measures.

Formally, this means the population criteria for the composite measure are expressed in terms of the population criteria for each component measure, as in:

```cql
define "Initial Population":
  ComponentMeasure1."Initial Population"
    or ComponentMeasure2."Initial Population"
    or ComponentMeasure3"."Initial Population"

define "Denominator":
  ComponentMeasure1."Denominator"
    or ComponentMeasure2."Denominator"
    or ComponentMeasure3."Denominator"

define "Denominator Exclusion":
  ComponentMeasure1."Denominator Exclusion"
    or ComponentMeasure2."Denominator Exclusion"
    or ComponentMeasure3."Denominator Exclusion"

define "Denominator Exception":
  ComponentMeasure1."Denominator Exception"
    or ComponentMeasure2."Denominator Exception"
    or ComponentMeasure3."Denominator Exception"

define "ComponentMeasure1 Numerator Membership": // Repeat for each component
  ComponentMeasure1."Initial Population"
    and ComponentMeasure1."Denominator"
    and not ComponentMeasure1."Denominator Exclusion"
    and ComponentMeasure1."Numerator"
    and not ComponentMeasure1."Numerator Exclusion"

define "Numerator":
  "ComponentMeasure1 Numerator Membership"
    and "ComponentMeasure2 Numerator Membership"
    and "ComponentMeasure3 Numerator Membership"

define "Numerator Exclusion":
  ComponentMeasure1."Numerator Exclusion"
    or ComponentMeasure2."Numerator Exclusion"
    or ComponentMeasure3."Numerator Exclusion"
```

Snippet 24: Formal criteria for a patient-based All-or-nothing composite measure

### 6.2 Opportunity Scoring

    Conformance Requirement 20 (Opportunity Scoring):
    Opportunity scoring SHALL be indicated using a subjectOf element to define a with a CMPMSRMTH measure attribute with a code of OPPORSCR as defined by the base HQMF specification.
    Calculation logic for opportunity composite measures SHALL be functionally equivalent to the calculation formulas defined in this section.
    Calculation logic for opportunity composite measures SHOULD be written in the same way as the calculation formulas defined in this section.
    Narrative descriptions of population criteria for opportunity composite measures SHOULD include the narrative descriptions of the corresponding population criteria for each component measure.

Opportunity scoring considers the appearance of a patient in a denominator of a component measure as an opportunity to provide a service, and the appearance of that patient in the numerator of each component as the fulfillment of that opportunity. This means that each component measure is considered a “case” in the composite population. The denominator is then the set of cases in which patients appeared in the denominator for the component measures, and so on for each population criteria. This allows the composite to then be calculated as a standard proportion measure where the basis for the population criteria is membership in the population for each component.

Figure 4. Opportunity scoring method

Interpretation: For each Eligible Clinician (EC), the percentage of opportunities to provide preventive services that were completed.
Example: X% of preventive service opportunities for the EC were completed.

| Individual measure | A | B | C | D | E |
|----|----|----|----|----|----|
|Screening for breast cancer |  | N/A | | | |
| Screening for colorectal cancer |  |  |  | |  |
| Pneumococcal vaccination |  |  | | 

Formally, this is done by describing a “case” for each component measure as illustrated in the following general case logic:

```cql
define "Initial Population":
    ("Patient Record" P
        where ComponentMeasure1."Initial Population"
            return { service: 'Service 1' }
    )
        union ("Patient Record" P
            where ComponentMeasure2."Initial Population"
                return { service: 'Service 2' }
        )
        union ("Patient Record" P
            where ComponentMeasure3."Initial Population"
                return { service: 'Service 3' }

define "Denominator":
    ("Patient Record" P
        where ComponentMeasure1."Denominator"
            return { service: 'Service 1' }
    )
        union ("Patient Record" P
            where ComponentMeasure2."Denominator"
                return { service: 'Service 2' }
        )
        union ("Patient Record" P
            where ComponentMeasure3."Denominator"
                return { service: 'Service 3' }
        )

define "Numerator":
    ("Patient Record" P
        where ComponentMeasure1."Numerator"
            return { service: 'Service 1' }
    )
        union ("Patient Record" P
            where ComponentMeasure2."Numerator"
                return { service: 'Service 2' }
        )
        union ("Patient Record" P
            where ComponentMeasure3."Numerator"
            return { service: 'Service 3' }
        )
```

Snippet 25: Formal criteria for a service-based opportunity composite measure

The populations in an opportunity composite are then lists of “services” the patient was eligible for (in the initial population and denominator) and received (in the numerator). The approach for populations not depicted here (denominator exclusion, denominator exception, and numerator exclusion) is analogous.

Note that this approach is using component measures where the improvement notation for the component is that an increase in the score represents an improvement. If the improvement notation is decreasing for a component, its population criteria would be negated (i.e. the absence of a patient in the component numerator would represent fulfillment).

### 6.3 Patient-level Linear Combination Scoring

    Conformance Requirement 21 (Patient-level Linear Combination Scoring):
    Patient-level linear combination scoring SHALL be indicated using a subjectOf element to define a with a CMPMSRMTH measure attribute with a code of LINEARSCR as defined by the base HQMF specification.
    Calculation logic for patient-level linear combination composite measures SHALL be functionally equivalent to the calculation formulas defined in this section.
    Calculation logic for patient-level linear combination composite measures SHOULD be written in the same way as the calculation formulas defined in this section.
    Narrative descriptions of population criteria for patient-level linear combination composite measures SHOULD include the narrative descriptions of the corresponding population criteria for each component measure.

Patient-level linear combination scoring is modeled as a continuous variable measure that gives numerator credit for the proportion of patients in the numerators of composite measures.

Figure 6. Patient-level linear combination method
Interpretation: For each Eligible Clinician (EC), the percentage of completed preventive services, which gives EC partial numerator credit for meeting the criteria for some but not all components of the measure.
Example: On average, each patient was provided X% of services for which the patient was eligible.

| Individual measure | A | B | C | D | E |
|----|----|----|----|----|----|
| Screening for breast cancer |  | N/A | | | |
| Screening for colorectal cancer |  |  |  |  |  |
| Pneumococcal vaccination |  |  |  |  |

Computationally, this method is a continuous variable measure using average, where the measure observation for an individual is the number of numerators of component measures in which that member appears, over the number of denominators of component measures in which that member appears. To express this in a continuous variable measure, use the average aggregate method in HQMF.

Formally, this is done by considering the membership test for each component measure as a 0 (if the patient is not in the population) or a 1 (if the patient is in the population) and adding the values for each component:

```cql
define "Is In Component 1 Denominator":
    ComponentMeasure1."Initial Population"
        and ComponentMeasure1."Denominator"
        and not ComponentMeasure1."Denominator Exclusion"
        and not (ComponentMeasure1."Denominator Exception"
          and not ComponentMeasure1."Numerator")

define "Is In Component 1 Numerator":
    ComponentMeasure1."Initial Population"
        and ComponentMeasure1."Denominator"
        and not ComponentMeasure1."Denomniator Exclusion"
        and not ComponentMeasure1."Numerator Exclusion"

define "Is In Component 2 Denominator":
    ComponentMeasure2."Initial Population"
        and ComponentMeasure2."Denominator"
        and not ComponentMeasure2."Denominator Exclusion"
        and not (ComponentMeasure2."Denominator Exception"
          and not ComponentMeasure2."Numerator")

define "Is In Component 2 Numerator":
    ComponentMeasure2."Initial Population"
        and ComponentMeasure2."Denominator"
        and not ComponentMeasure2."Denominator Exclusion"
        and not ComponentMeasure2."Numerator Exclusion"
```

Snippet 26: Formal criteria for a service-based opportunity composite measure

With these definitions, we can then express the measure observation for each patient as a calculation of the proportion of measures in which they were in the numerator:

```cql
define "Denominator Score":
    ToScore("Is In Component 1 Denominator")
    + ToScore("Is In Component 2 Denominator")

define "Numerator Score":
    ToScore("Is In Component 1 Numerator")
    + ToScore("Is In Component 2 Numerator")

define function "Measure Observation"(patient "Patient Characteristic Birthdate"):
    "Numerator Score" / "Denominator Score"

define function "ToScore"(value Boolean):
    if value then 1 else 0
```

Snippet 27: Formal criteria for a service-based opportunity composite measure

And finally, the population criteria for the initial population is defined to return the patient record if the patient is in the initial population of any component measure; the measure population if the patient is in any component denominator; and the measure population exclusion if the patient is in all the denominator exclusions of the component measures:

```cql
define "Initial Population":
    "Patient Record" P
        where ComponentMeasure1."Initial Population"
            or ComponentMeasure2."Initial Population"

define "Measure Population":
    ComponentMeasure1."Denominator"
        or ComponentMeasure2."Denominator"

define "Measure Population Exclusion":
    ComponentMeasure1."Denominator Exclusion"
        and ComponentMeasure2."Denominator Exclusion"
```

Snippet 28: Formal criteria for a patient-based linear combination composite measure

Note that these definitions are based on component measures whose improvement notation is an increase in the measure score. If any component measure has an improvement notation of decrease in score, the denominator and numerator for that component would be reversed in the above calculations.

### 6.4 Weighted Scoring

Weighted scoring combines component measure scores using a weighting factor for each component. In the special case that the weighting factor for each component measure is 1, this is also called component-level linear combination scoring.

Note that as discussed in the section on composite scoring methods, this method is a component-based composite measure scoring method. The description of this method is included here for completeness, but component-based composite measure scoring methods are not supported at this time.

Figure 7. Component-level linear combination method

Interpretation: For each Eligible Clinician (EC), percentage of patients who received preventive services, which gives EC partial numerator credit for meeting the criteria for some but not all components of the measure.

Example: On average, each preventive service was provided to X% of patients.

| Individual measure | A | B | C | D | E |
|----|----|----|----|----|----|
| Screening for breast cancer |  | N/A |  | | |
Screening for colorectal cancer |  |  |  |  |  |
Pneumococcal vaccination |  |  |  |  | |

Computationally, this method is simply the weighted average of the component measure scores. In the simplest case where the weights are all 1, this method is simply the average score of the component measures.

A “Weighted” score composite measure would contain a subjectOf declaration indicating the measure scoring (see Snippet 22). Additionally, a composite measure using a weighted scoring scheme would need to include the weight of each measure within the relatedDocument elements, as in line 8 of Snippet 23:

```xml
<relatedDocument typeCode="XCRPT">
    <componentQualityMeasureDocument>
        <id root="40280381-537c-f767-0153-c378bd7207a5" />
        <setId root="9a031e24-3d9b-11e1-8634-00237d5bf174" />
        <versionNumber value="1.1" />
        <subjectOf>
            <measureAttribute>
                <code code="CMPMSRSCRWGHT" codeSystem="2.16.840.1.113883.5.4" />
                <value xsi:type="PQ" value="0.2" />
                </measureattibute>
        </subjectOf>
    </componentQualityMeasureDocument>
</relatedDocument><relatedDocument typeCode="XCRPT">
    <componentQualityMeasureDocument>
        <id root="40280381-51f0-825b-0152-22bd8ee41875" />
        <setId root="500e4792-7f94-4e34-8546-ee71c56fe463" />
        <versionNumber value="1.1" />
        <subjectOf>
            <measureAttribute>
                <code code="CMPMSRSCRWGHT" codeSystem="2.16.840.1.113883.5.4" />
                <value xsi:type="PQ" value="0.8" />
                </measureattibute>
        </subjectOf>
    </componentQualityMeasureDocument>
</relatedDocument>
 ```

Snippet 29: Weighted composite measure relatedDocuments

### 6.5 Measure Types

    Conformance Requirement 22 (Composite Measure Types):

    For composite measures using Opportunity scoring
    The measure scoring method SHALL be Proportion or Ratio
    All component measures SHALL use Proportion or Ratio scoring
    For composite measures using All-or-nothing scoring
    The measure scoring method SHALL be Proportion or Ratio
    All component measures SHALL use Proportion or Ratio scoring
    For composite measures using Patient-level linear scoring
    The measure scoring method SHALL be Continuous Variable
    All component measures SHALL use Proportion, Ratio, or Continuous Variable Scoring

    a composite eCQM SHALL have at least two componentQualityMeasureDocument elements
    the typeCode attribute of the relatedDocument element SHALL be XCRPT
    the id element of the componentQualityMeasureDocument element SHALL be present and
    SHALL have a root attribute that specifies the id of the component eCQM
    SHOULD have an identifierName attribute that specifies the title of the component eCQM

For composite measures, the composite score calculation method effectively determines the measure type. The component measures in a composite can also be proportion, ratio, or continuous variable measures. However, all the component measures of a composite must be of the same type.

The following table summarizes the allowable measure types for each of the composite scoring methods:

| Scoring Method | Composite Measure Type | Component Measure Types |
|:----:|:----:|:----:|
| Opportunity | Proportion/Ratio | Proportion/Ratio |
| All-or-nothing | Proportion/Ratio | Proportion/Ratio |
| Patient-level Linear | Continuous Variable | Proportion/Ratio/Continuous Variable |

Note that these requirements are about ensuring that the population criteria expressions among the components use similar sets of population criteria. This means that all the components of a given composite measure don’t necessarily have to use the same scoring type, just that they have to have similar population criteria. For example, a Proportion composite may use a Proportion component and a Ratio component. 

### 6.6 Measure Basis

    Conformance Requirement 23 (Composite Measure Basis):

    All component measures used within a composite measure SHALL use the same measure basis

As with single measures, composite measures may be patient-based, or use some other element as the measure basis such as encounters or procedures. However, each component measure of a composite must use the same basis. For example, a composite measure may not include both patient-based and episode-of-care measures as component measures.

### 6.7 Stratification

    Conformance Requirement 24 (Composite Measure Stratification):

    Stratifiers of components in a composite measure SHALL NOT be used to stratify the composite measure 

Because composite measure scoring for individual-based composites effectively ignores component scores, stratifiers defined on component measures are not applicable to the composite measure score. As such, stratifiers are supported in composite measures, just as they are with non-composites, but stratifiers of the component measures are ignored.

### 6.8 Multiple Populations

    Conformance Requirement 25 (Composite Measure Populations):

    Composite measure SHALL contain only one population group
    Component measures included in composite measure SHALL contain only one population group

To simplify expression and implementation of composite measures, all component measures used within a composite must have a single population group. In addition, the composite measure itself can only contain a single population group. Note that for ratio measures with two initial populations, the initial population would have to be constructed using the appropriate initial population from the component measures.

### 6.9 Supplemental Data Elements and Risk Adjustment Variables

    Conformance Requirement 26 (Composite Measure Supplement Data Elements and Risk Adjustment):

    Composite measures SHALL include supplemental data elements and risk adjustment variables from all component measures, as well as those defined in the composite directly.
    Supplemental data elements and risk adjustment variables that appear in the multiple components or a component and the composite by name SHALL be of the same type

For individual-based composite scoring methods, additional data elements are collected from all component measures, but could also be defined at the composite level. The name of the supplemental data element or risk adjustment element is used to determine uniqueness across components and the composite. If a supplemental data element or risk adjustment element appears in more than one component, it must be of the same type.

### 6.10 Component Quality Measures

    Conformance Requirement 27 (Component Quality Measures):
    Component quality measures SHALL be referenced using a relatedDocument element containing a componentQualityMeasureDocument element where:
    a composite eCQM SHALL have at least two componentQualityMeasureDocument elements
    the typeCode attribute of the relatedDocument element SHALL be XCRPT
    the id element of the componentQualityMeasureDocument element SHALL be present and
    SHALL have a root attribute that specifies the id of the component eCQM
    SHOULD have an identifierName attribute that specifies the title of the component eCQM
    the setId element of the componentQualityMeasureDocument SHOULD be present and
    if present, it SHALL have a root attribute that is the setId of the component eCQM
    the versionNumber element of the componentQualityMeasureDocument SHOULD be present and
    SHALL be present if the setId element is present and
    if present, it SHALL have a value attribute that is the versionNumber of the component eCQM

Regardless of the scoring method, a composite eCQM will include any number of component measures to be included in the composite calculations. Each component results in the appearance of a relatedDocument element containing a componentQualityMeasureDocument element that references at least the id, but also the title, setId, and version of the component eCQM, as illustrated in the following example:

```xml
<relatedDocument typeCode="XCRPT">
    <componentQualityMeasureDocument>
        <id root="40280582-5b4d-ee92-015b-97f1b0670264" identifierName="TestCMS122v5" />
        <setId root="449eb961-74e6-4e78-9723-9aa0ca4dd115" />
        <versionNumber value="0.0.001" />
    </componentQualityMeasureDocument>
</relatedDocument><relatedDocument typeCode="XCRPT">
    <componentQualityMeasureDocument>
        <id root=" 40280582-5b4d-ee92-015b-97f745990272" identifierName="Test131v5" />
        <setId root=" 447f098e-81ba-45e4-b296-5bb119d87762" />
        <versionNumber value="0.0.001" />
    </componentQualityMeasureDocument>
</relatedDocument>
 ```

Snippet 30: Composite measure relatedDocuments

