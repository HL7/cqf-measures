
{:toc}

{: #composite-measures}
<div class='new-content' markdown='1'>
Composite measures make use of multiple component measures to produce a combined score. In the most general case, a composite measure is akin to a continuous variable measure, where the measure observation for each population member is some combination of the individual's component measure scores. However, the calculation logic involved is detailed, and a higher-level representation of the most common composite measure calculation approaches enables a much simpler representation to work with and understand. Note that composite measures must be constructed from existing component measures. Composites do not introduce any new measure logic beyond the composite score calculation. If a composite needs to introduce new logic, a new component measure must be developed that can then be included in the composite.

**Conformance Requirement 5.1 (Composite Measures):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-5-1)
{: #conformance-requirement-5-1}
    1. Composite Measures SHALL conform to the CQFMCompositeMeasure profile
    2. Composite Measures SHALL specify a composite measure scoring method

The example illustrates the use of these elements of a measure to specify a composite measure:

```xml
<scoring>
   <coding>
      <system value="http://terminology.hl7.org/CodeSystem/measure-scoring"/>
      <code value="composite"/>
      <display value="Composite"/>
   </coding>
</scoring>
<compositeScoring>
   <coding>
      <system value="http://terminology.hl7.org/CodeSystem/composite-measure-scoring"/>
      <code value="all-or-nothing"/>
      <display value="All-or-nothing"/>
   </coding>
</compositeScoring>
 ```

Snippet 22: Sample Risk Adjustment Variable from TestRiskAdj eCQM.xml

Broadly speaking, composite measure scoring methods fall into two categories:

1. Individual-Based: Scoring methods that operate at the individual level by combining members of component populations and then calculating the measure score using standard measure scoring techniques on the combined populations.
2. Component-Based: Scoring methods that operate at the population level by combining the summary scores of component measures.

Architecturally, environments that are already capable of calculating measures using the measure scoring methods already described in this implementation guide can readily consume composite measure specifications that use the first approach (individual-based) but would require additional support in order to calculate component-based measures. Specifically, completely generic support for component-based calculation methods would require that an environment be able to evaluate CQL logic in the Population context. However, by restricting composite calculation support to those methods specified by this implementation guide, environments can calculate composites by operating on the results of individual-level scores.

To illustrate the different composite scoring methods, an example Annual Wellness assessment measure for Eligible Clinicians (EC) is used. Note that although the scoring methods are described in terms applicable to ECs, the concepts apply in general to composites that could be built for any setting.

### All-or-nothing Scoring
{: #all-or-nothing-scoring}

**Conformance Requirement 5.2 (All-or-nothing Scoring):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-5-2)
{: #conformance-requirement-5-2}
    1. Calculation logic for all-or-nothing composite measures SHALL be functionally equivalent to the calculation formulas defined in this section.
    2. Calculation logic for all-or-nothing composite measures SHOULD be written in the same way as the calculation formulas defined in this section.
    3. Narrative descriptions of population criteria for all-or-nothing composite measures SHOULD include the narrative descriptions of the corresponding population criteria for each component measure.

All-or-nothing scoring includes an individual in the numerator of the composite measure if they are in the numerators of all of the component measures in which they are in the denominator.


<details open>
<summary>
<b>Figure 5-1. All-or-none method</b>

</summary>

<i>Interpretation:</i> For each Eligible Clinician (EC), the percentage of patients who received all preventive services for which they were eligible within the specified time interval. Gives EC numerator credit only if a patient meets the criteria for all of the components of the measure for which the patient is eligible. <br>
<i>Example:</i> X% of an EC’s patients received all preventive services for which they were eligible.


{% include img.html img="composite-measure-all-or-nothing-scoring.png" %}

</details>

An example of an “All-or-nothing” scored composite measure has been included in [Preventive Care and Wellness (All-or-nothing)](Measure-PreventiveCareandWellnessAllOrNothingComposite.html). This measure specifies the composite, and references the component measures using `relatedArtifact` elements with a type of `composed-of` as shown in Snippet 23:

```xml
<relatedArtifact>
   <type value="composed-of"/>
   <display value="Breast Cancer Screening"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/BCSComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <type value="composed-of"/>
   <display value="High Blood Pressure Screening"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/HBPComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <type value="composed-of"/>
   <display value="Colorectal Cancer Screening"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/CCSComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <type value="composed-of"/>
   <display value="Pneumococcal Vaccination Status"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/PVSComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-groupId">
      <valueId value="Group1"/>
   </extension>
   <type value="composed-of"/>
   <display value="Tobacco Use Screening and Cessation, Group1"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/TSCComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-groupId">
      <valueId value="Group2"/>
   </extension>
   <type value="composed-of"/>
   <display value="Tobacco Use Screening and Cessation, Group2"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/TSCComponent|0.0.001"/>
</relatedArtifact>
 ```

Snippet 23: Components of an example All-or-nothing scored composite measure from Preventive Care and Wellness (All-or-nothing).

Computationally, this method amounts to expressing each population criteria for the composite measure as the union (logical ‘or’ for patient-based measures) of the respective population criteria for each component measure, except for the numerator, which is expressed as the intersection (logical ‘and’ for patient-based measures) of the numerators of the component measures. Note that in this requires that an individual is considered for the numerator only if they meet the denominator, which is accomplished using an `implies` operator in the component measure numerator membership criteria.

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
  ComponentMeasure1."Denominator Membership"
   implies ComponentMeasure1."Numerator Membership"

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

Consider this example of a composite that includes a breast cancer screening measure and a colorectal cancer screening measure. For an individual that is male, they are only eligible for the colorectal cancer screening measure, so the fact that they do not appear in the denominator or numerator of the breast cancer screening measure should not remove them from the numerator of the composite measure.

*Note that `implies` is a logical operator within CQL. "X implies Y" roughly translates to narrative text as "if X is true, then Y must be as well"

Refer to the definition of ["implies" in CQL](https://cql.hl7.org/09-b-cqlreference.html#implies) for more information.

### Opportunity Scoring
{: opportunity-scoring}

**Conformance Requirement 5.3 (Opportunity Scoring):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-5-3)
{: #conformance-requirement-5-3}
    1. Calculation logic for opportunity composite measures SHALL be functionally equivalent to the calculation formulas defined in this section.
    2. Calculation logic for opportunity composite measures SHOULD be written in the same way as the calculation formulas defined in this section.
    3. Narrative descriptions of population criteria for opportunity composite measures SHOULD include the narrative descriptions of the corresponding population criteria for each component measure.

Opportunity scoring considers the appearance of a patient in a denominator of a component measure as an opportunity to provide a service, and the appearance of that patient in the numerator of each component as the fulfillment of that opportunity. This means that each component measure is considered a “case” in the composite population. The denominator is then the set of cases in which patients appeared in the denominator for the component measures, and so on for each population criteria. This allows the composite to then be calculated as a standard proportion measure where the basis for the population criteria is membership in the population for each component.

<details open>
<summary>
<b>Figure 5-2. Opportunity scoring method</b>

</summary>

<em>Interpretation:</em> For each Eligible Clinician (EC), the percentage of opportunities to provide preventive services that were completed.<br>

<em>Example:</em> X% of preventive service opportunities for the EC were completed.

{% include img.html img="composite-measure-opportunity-scoring.png" %}

</details>

Formally, this is done by describing a "service" for each component measure as illustrated in the following general logic:

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

### Patient-level Linear Combination Scoring
{: patient-level-linear-combination-scoring}

**Conformance Requirement 5.4 (Patient-level Linear Combination Scoring):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-5-4)
{: #conformance-requirement-5-4}
    1. Calculation logic for patient-level linear combination composite measures SHALL be functionally equivalent to the calculation formulas defined in this section.
    2. Calculation logic for patient-level linear combination composite measures SHOULD be written in the same way as the calculation formulas defined in this section.
    3. Narrative descriptions of population criteria for patient-level linear combination composite measures SHOULD include the narrative descriptions of the corresponding population criteria for each component measure.

Patient-level linear combination scoring is modeled as a continuous variable measure that gives numerator credit for the proportion of patients in the numerators of composite measures.

<details open>
<summary>
<b>Figure 5-3. Patient-level linear combination method</b>
</summary>

<em>Interpretation:</em> For each Eligible Clinician (EC), the percentage of completed preventive services, which gives EC partial numerator credit for meeting the criteria for some but not all components of the measure.<br>

<em>Example:</em> On average, each patient was provided X% of services for which the patient was eligible.

{% include img.html img="composite-measure-patient-level-linear-combination-scoring.png" %}

</details>

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

### Weighted Scoring
{: weighted-scoring}

Weighted scoring combines component measure scores using a weighting factor for each component. In the special case that the weighting factor for each component measure is 1, this is also called component-level linear combination scoring.

Note that as discussed in the section on composite scoring methods, this method is a component-based composite measure scoring method, meaning that the calculation of the composite is performed on the population-level result of the component measures.

<details open>
<b>Figure 5-4. Component-level linear combination method</b>

<summary>

<em>Interpretation:</em> For each Eligible Clinician (EC), percentage of patients who received preventive services, which gives EC partial numerator credit for meeting the criteria for some but not all components of the measure. <br>

<em>Example:</em> On average, each preventive service was provided to X% of patients.
</summary>

{% include img.html img="composite-measure-component-level-linear-combination-scoring.png" %}

</details>

Computationally, this method is simply the weighted average of the component measure scores. In the simplest case where the weights are all 1, this method is simply the average score of the component measures.

A "weighted" score composite measure specifies the weights of each component using the [weight](StructureDefinition-cqfm-weight.html) extension on each component measure, as in the example below:

```xml
<relatedArtifact>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-weight">
      <valueDecimal value="0.2"/>
   </extension>
   <type value="composed-of"/>
   <display value="Breast Cancer Screening"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/BCSComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-weight">
      <valueDecimal value="0.2"/>
   </extension>
   <type value="composed-of"/>
   <display value="High Blood Pressure Screening"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/HBPComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-weight">
      <valueDecimal value="0.2"/>
   </extension>
   <type value="composed-of"/>
   <display value="Colorectal Cancer Screening"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/CCSComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-weight">
      <valueDecimal value="0.2"/>
   </extension>
   <type value="composed-of"/>
   <display value="Pneumococcal Vaccination Status"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/PVSComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-groupId">
      <valueId value="Group1"/>
   </extension>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-weight">
      <valueDecimal value="0.1"/>
   </extension>
   <type value="composed-of"/>
   <display value="Tobacco Use Screening and Cessation, Group1"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/TSCComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-groupId">
      <valueId value="Group2"/>
   </extension>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-weight">
      <valueDecimal value="0.1"/>
   </extension>
   <type value="composed-of"/>
   <display value="Tobacco Use Screening and Cessation, Group2"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/TSCComponent|0.0.001"/>
</relatedArtifact>
 ```

Snippet 29: Weighted composite measure relatedArtifact elements

### Measure Types
{: #measure-types}

**Conformance Requirement 5.5 (Composite Measure Scoring):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-5-5)
{: #conformance-requirement-5-5}
    1. For composite measures using Opportunity scoring
        a. The measure scoring method SHALL be Composite
        b. All component measures SHALL use Proportion or Ratio scoring
    2. For composite measures using All-or-nothing scoring
        a. The measure scoring method SHALL be Composite
        b. All component measures SHALL use Proportion or Ratio scoring
    3. For composite measures using Patient-level linear scoring
        a. The measure scoring method SHALL be Composite
        b. All component measures SHALL use Proportion, Ratio, or Continuous Variable Scoring
    4. For composite measures using Component-level scoring
        a. The measure scoring method SHALL be Composite
        b. All component measures SHALL use Proportion, Ratio, or Continuous Variable Scoring

For composite measures, the composite score calculation method specifies the measure scoring. The component measures in a composite can also be proportion, ratio, or continuous variable measures.

The following table summarizes the allowable measure scoring for each of the composite scoring methods:

| Composite Scoring Method | Scoring Method | Component Measure Scoring |
|:----:|:----:|:----:|
| Opportunity | Composite | Proportion/Ratio |
| All-or-nothing | Composite | Proportion/Ratio |
| Patient-level Linear | Composite | Proportion/Ratio/Continuous Variable |
| Component-level | Composite | Proportion/Ratio/Continuous Variable |

Note that these requirements are about ensuring that the population criteria expressions among the components use similar sets of population criteria. This means that all the components of a given composite measure don’t necessarily have to use the same scoring type, just that they have to have similar population criteria. For example, a Proportion composite may use a Proportion component and a Ratio component.

### Measure Basis
{: #measure-basis}

**Conformance Requirement 5.6 (Composite Measure Basis):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-5-6)
{: #conformance-requirement-5-6}
    1. All component measures used within a composite measure SHALL have the same measure subject type
    2. All component measures used within an individual-level composite measure SHALL use the same measure basis, except that
        a. Patient-based composite measures MAY reference non-patient-based components, but the scoring method
           will determine how non-patient-based components are included, typically by converting the component
           criteria to a boolean using an exists operation.
    3. Component measures of component-level composite measures MAY have the same measure basis

As with single measures, composite measures may be patient-based, or use some other element as the measure basis such as encounters or procedures. However, individual membership in each component measure of an individual-level composite must be able to be determined on the same basis. This means that when an individual-level composite includes non-individual-based components, criteria for those components must be converted to an individual membership test using an exists operation. Consider the example composites included in this implementation guide. When considering membership of an individual in the criteria of the encounter-based Tobacco Screening and Cessation component measure, the existence of encounters in each population criteria determine the membership of the individual in that criteria. In other words, the encounter-based component is "demoted" to a patient-based measure for inclusion in the composite.

### Stratification
{: #stratification}

**Conformance Requirement 5.7 (Composite Measure Stratification):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-5-7)
{: #conformance-requirement-5-7}
    1. Stratifiers of components in a composite measure SHALL NOT be used to stratify the composite measure

Because composite measure scoring for individual-based composites effectively ignores component scores, stratifiers defined on component measures are not applicable to the composite measure score. As such, stratifiers are supported in composite measures, just as they are with non-composites, but stratifiers of the component measures are ignored.

### Multiple Populations
{: #multiple-populations}

**Conformance Requirement 5.8 (Composite Measure Population Groups):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-5-8)
{: #conformance-requirement-5-8}
    1. Component measures used in a composite SHOULD contain a single population group
    2. For component measures that contain multiple population groups, the composite measure SHALL specify the specific group to be used in the composite using the [groupId](StructureDefinition-cqfm-groupId) extension

To simplify expression and implementation of composite measures, all component measures used within a composite SHOULD have a single population group. In addition, the composite measure itself SHOULD only contain a single composite specification (using the _relatedArtifact_ elements of the Measure directly). Note that for ratio measures with two initial populations, the initial population would have to be constructed using the appropriate initial population from the component measures.

### Supplemental Data Elements and Risk Adjustment Variables
{: #supplemental-data-elements-and-risk-adjustment-variables}

**Conformance Requirement 5.9 (Composite Measure Supplemental Data Elements and Risk Adjustment Variables):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-5-9)
{: #conformance-requirement-5-9}
    1. Composite measure results SHALL include supplemental data elements and risk adjustment variables from all component measures, as well as those defined in the composite directly.
    2. Supplemental data elements and risk adjustment variables that appear in the multiple components or a component and the composite by name SHALL be of the same type

For individual-based composite scoring methods, additional data elements are collected from all component measures, but could also be defined at the composite level. The name of the supplemental data element or risk adjustment element is used to determine uniqueness across components and the composite. If a supplemental data element or risk adjustment element appears in more than one component, it must be of the same type.

### Component Quality Measures
{: #component-quality-measures}

**Conformance Requirement 5.10 (Component Quality Measures):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-5-10)
{: #conformance-requirement-5-10}
    1. Component quality measures SHALL be referenced using a relatedArtifact element with a type of _composed-of_
    2. Component quality measures SHALL be referenced using the canonical URL of the Measure resource
        a. A composite measure MAY point to a group in the same Measure resource
        b. If the component measure contains multiple groups, the [groupId] extension SHALL be used to reference a specific group
        c. Multiple groups within the same measure may be referenced as different components of the same composite
    3. A composite eCQM SHALL have at least two components

Regardless of the scoring method, a composite eCQM will include any number of component measures to be included in the composite calculations. Each component results in the appearance of a relatedArtifact element referencing a Measure by _url_, possibly including the _version_ and, if necessary, specifying the particular _group_ that should be used as the component, and the _weight_ of that component's contribution to the composite score (for weighted composite scoring methods). The following example illustrates a simple composite:

```xml
<relatedArtifact>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-weight">
      <valueDecimal value="0.2"/>
   </extension>
   <type value="composed-of"/>
   <display value="Breast Cancer Screening"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/BCSComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-weight">
      <valueDecimal value="0.2"/>
   </extension>
   <type value="composed-of"/>
   <display value="High Blood Pressure Screening"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/HBPComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-weight">
      <valueDecimal value="0.2"/>
   </extension>
   <type value="composed-of"/>
   <display value="Colorectal Cancer Screening"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/CCSComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-weight">
      <valueDecimal value="0.2"/>
   </extension>
   <type value="composed-of"/>
   <display value="Pneumococcal Vaccination Status"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/PVSComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-groupId">
      <valueId value="Group1"/>
   </extension>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-weight">
      <valueDecimal value="0.1"/>
   </extension>
   <type value="composed-of"/>
   <display value="Tobacco Use Screening and Cessation, Group1"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/TSCComponent|0.0.001"/>
</relatedArtifact>
<relatedArtifact>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-groupId">
      <valueId value="Group2"/>
   </extension>
   <extension url="http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-weight">
      <valueDecimal value="0.1"/>
   </extension>
   <type value="composed-of"/>
   <display value="Tobacco Use Screening and Cessation, Group2"/>
   <resource value="http://hl7.org/fhir/us/cqfmeasures/Measure/TSCComponent|0.0.001"/>
</relatedArtifact>
 ```

Snippet 30: Composite measure relatedArtifacts
</div>
