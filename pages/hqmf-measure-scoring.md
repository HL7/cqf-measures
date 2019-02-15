---
layout: default
title: HQMF Measure Scoring
---
## 2.3 Population Criteria Section

The Population Criteria Section identifies a population using one or more Data Criteria elements. Populations can be of multiple types and are used in different ways by a variety of measure types. Each measure has a measure score that determines what population types may be used. Each population type has a normative definition stated within this HQMF standard (see Definitions).

Table 1: Allowed Population Criteria for Measure Scores

| Measure Score | Initial Population | Denominator | Denominator Exclusion | Denominator Exception | Numerator | Numerator Exclusion | Measure Population | Measure Population Exclusion |
|:----|:----:|:----:|:----:|:----:|:----:|:----:|:----:|:----:|
| Proportion | R |R | O | O | R | O | NP | NP |
| Ratio | R | R | O | NP | R | O | NP | NP |
| Continuous Variable | R | NP | NP | NP | NP | NP | R | O |
| Cohort | R | NP | NP | NP | NP | NP | NP | NP |

### 2.3.1 Population Criteria and Measure Scores

The following sections describe the expected result type for population criteria for each type of measure, as well as explicitly defining the measure score calculation formula.

In addition to the measure type, measures generally fall into two categories, patient-based, and non-patient-based, such as episode-of-care-based. In general, patient-based measures count the number of patients in each population, while non-patient-based measures count the number of items (such as encounters) in each population. Although the calculation formulas are conceptually the same for both categories, for ease of expression, population criteria for patient-based measures return true or false, while non-patient-based measures return the item to be counted such as an encounter or procedure.

The measure calculation examples use Clinical Quality Language (CQL) to express the formulas, however this is only done to make the syntax and calculations clear. HQMF does not require the use of CQL.

#### 2.3.1.1 Proportion Measure Score

The population types for a Proportion measure are "Initial Population", "Denominator", "Denominator Exclusion", "Numerator", "Numerator Exclusion" and "Denominator Exception". The following diagram shows the relationships between the populations for proportion measures and the table below provides their definitions.

Figure 4: Population criteria for Proportion measures illustration

![Proportion Venn Diagram](assets/images/ProportionVenn.jpg)

Table 2: Population Criteria Definitions for Proportion Measures

| Population | Definition |
|:----|:----:|
| Initial Population (IPOP) | All entities to be evaluated by an eMeasure which may but are not required to share a common set of specified characteristics within a named measurement set to which the eMeasure belongs. |
| Denominator (DENOM) | The same as the Initial Population or a subset of the Initial Population to further constrain the population for the purpose of the eMeasure. |
| Denominator Exclusion (DENEX) | Entities to be removed from the Initial Population and Denominator before determining if Numerator criteria are met. Denominator Exclusions are used in Proportion and Ratio measures to help narrow the Denominator. |
| Numerator (NUMER) | The processes or outcomes for each entity defined in the Denominator of a Proportion or Ratio measure. |
| Numerator Exclusion (NUMEX) | Entities that should be removed from the eMeasure's Numerator. Numerator exclusions are used in Proportion and Ratio measures to help narrow the Numerator (for inverted measures). |
| Denominator Exception (DENEXCEP) | Those conditions that should remove a patient, procedure, or unit of measurement from the Denominator only if the Numerator criteria are not met. Denominator exceptions allow for adjustment of the calculated score for those providers with higher risk populations. |

Here is an example of using population types to select data on diabetes patients for a Proportion measure:

* Initial Population (IPOP): Patient is between the age of 16 and 74
* Denominator (DENOM): Patient has Diabetes Type II
* Numerator (NUMER): Patient is between the age of 16 and 74, has Diabetes Type II, and the most recent laboratory result has hbA1C value > 9%
* Denominator Exception (DENEXCEP): Patient meets the DENOM criteria and does NOT meet the NUMER criteria, and is designated as having "Steroid Induced Diabetes" or "Gestational Diabetes"

Figure 5: Calcuation Flow for Proportion Measures

![Calculation Flow Diagram-Proportion](assets/images/CalculationFlowDiagrams-Proportion.jpg)

* Initial population (IPOP): Identify those cases that meet the IPOP criteria.
* Denominator (DENOM): Identify that subset of the IPOP that meet the DENOM criteria.
* Denominator exclusion (DENEX): Identify that subset of the DENOM that meet the DENEX criteria. There are cases that should be removed from the denominator as exclusion. Once these cases are removed, the subset remaining would reflect the denominator per criteria.
* Numerator (NUMER): Identify those cases in the DENOM and NOT in the DENEX that meet the NUMER criteria. In proportion measures, the numerator criteria are the processes or outcomes expected for each patient, procedure, or other unit of measurement defined in the denominator.
* Numerator exclusion (NUMEX): Identify that subset of the NUMER that meet the NUMEX criteria. Numerator Exclusion is used only in ratio eMeasures to define instances that should not be included in the numerator data.
* Denominator exception (DENEXCEP): Identify those in the DENOM and NOT in the DENEX and NOT in the NUMER that meet the DENEXCEP criteria.

The “performance rate” is a ratio of patients meeting NUMER criteria, divided by patients in the DENOM (accounting for exclusion and exception). Performance rate can be calculated using this formula:

Performance rate = (NUMER - NUMEX) / (DENOM – DENEX – DENEXCEP)

##### 2.3.1.1.1 Patient-based Calcuation

The following snippet provides precise semantics for the measure score calculation for a patient-based proportion measure:

```cql
context Patient

define "Denominator Membership":
  "Initial Population"
    and "Denominator"
    and not "Denominator Exclusion"
    and not ("Denominator Exception" and not "Numerator")

define "Numerator Membership":
  "Initial Population"
    and "Denominator"
    and not "Denominator Exclusion"
    and "Numerator"
    and not "Numerator Exclusion"

context Population

define "Measure Score":
  Count("Numerator Membership" IsMember where IsMember is true)
    / Count("Denominator Membership" IsMember where IsMember is true)
```

##### 2.3.1.1.2 Non-patient-based Calcuation

The following snippet provides precise semantics for the measure score calculation for a non-patient-based proportion measure:

```cql
define "Numerator Membership":
  "Initial Population"
    intersect "Denominator"
    except "Denominator Exclusion"
    intersect "Numerator"
    except "Numerator Exclusion"

define "Denominator Membership":
  "Initial Population"
    intersect "Denominator"
    except "Denominator Exclusion"
    except ("Denominator Exception" except "Numerator")

context Population

define "Measure Score":
  Count("Numerator Membership") /
    Count("Denominator Membership")
```

#### 2.3.1.2 Continuous Variable Measure Score

The population types for a Continuous Variable measure are "Initial Population", "Measure Population", and "Measure Population Exclusion". In addition to these populations, a Measure Observation is defined which contains one or more Continuous Variable statements that are used to score one or more particular aspects of performance. The following diagram shows the relationships between the populations for Continuous Variable measures and the table below provides their definitions.

Figure 6: Population criteria for Continuous Variable measures illustration

![Continuous Variable Venn Diagram](assets/images/CVVenn.jpg)

Table 3: Population Criteria Definitions for Continuous Variable Measures

| Population | Definition |
|:----|:----:|
| Initial Population (IPOP) | All entities to be evaluated by an eMeasure which may but are not required to share a common set of specified characteristics within a named measurement set to which the eMeasure belongs. |
| Measure Population (MSRPOPL) | Continuous Variable measures do not have a Denominator, but instead define a Measure Population, as shown in the figure above. Rather than reporting a Numerator and Denominator, a Continuous Variable measure defines variables that are computed across the Measure Population (e.g., average wait time in the emergency department). A Measure Population may be the same as the Initial Population or a subset of the Initial Population to further constrain the population for the purpose of the eMeasure. |
| Measure Population Exclusions (MSRPOPLEX) | Patients who should be removed from the eMeasure's Initial Population and Measure Population before determining the outcome of one or more continuous variables defined within a Measure Observation. Measure Population Exclusions are used in Continuous Variable measures to help narrow the Measure Population. |

Here is an example of using the population types to select data on emergency department patients for a Continuous Variable measure:

* Initial Population (IPOP): Patient had an emergency department (ED) encounter
* Measure Population (MSRPOPL): Same as Initial Population
* Measure Population Exclusion (MSRPOPLEX): Patient had an inpatient encounter that was within 6 hours of the ED encounter or expired in the ED

Figure 7: Calcuation Flow for Continuous Variable Measure Score

![Calculation Flow Diagram-ContinuousVariable](assets/images/CalculationFlowDiagrams-ContinuousVariable.jpg)

* Initial population (IPOP): Identify those cases that meet the IPOP criteria.
* Measure population (MSRPOPL): Identify that subset of the IPOP that meet the MSRPOPL criteria.
* Measure population exclusion (MSRPOPLEX): Identify that subset of the MSRPOPL that meet the MSRPOPLEX criteria.

##### 2.3.1.2.1 Individual Observations

Individual Observations are calculated for each case in the MSRPOPL and not in the MSRPOPLEX.

##### 2.3.1.2.2 Measure Aggregates

Using individual observations for all cases in the MSRPOPL and not in the MSRPOPLEX, calculate the aggregate MSRPOPL.

Score = aggregate MSRPOPL

##### 2.3.1.2.3 Calcuation

The following snippet provides precise semantics for the measure score calculation for a continuous variable measure:

```cql
define "Measure Population Membership":
  "Initial Population"
    intersect "Measure Population"
    except "Measure Population Exclusion"

context Population

define "Measure Score":
  Avg("Measure Population Membership" PopulationMember
      return "Median ED Time"(PopulationMember)
  )
```

#### 2.3.1.3 Ratio Measure Score

The population types for a Ratio measure are "Initial Population", "Denominator", "Denominator Exclusion", "Numerator" and "Numerator Exclusion". The following diagrams show the relationships between the populations for Ratio measures and the table below provides their definitions.

Figure 8: Population criteria for Ratio measures illustration

![Ratio Venn Diagram](assets/images/RatioVenn.jpg)

Figure 9: Population criteria for Ratio measures illustration

![Ratio 2 Venn Diagram](assets/images/Ratio2Venn.png)

Figure 10: Population criteria for Ratio measures illustration

![Ratio 3 Venn Diagram](assets/images/Ratio3Venn.png)

Table 4: Population Criteria Definitions for Ratio Measures

| Population | Definition |
|:----|:----:|
| Initial Population (IPOP) | All entities to be evaluated by an eMeasure which may but are not required to share a common set of specified characteristics within a named measurement set to which the eMeasure belongs. Ratio measures are allowed to have two Initial Populations, one for Numerator and one for Denominator. In most cases, there is only 1 Initial Population |
| Denominator (DENOM) | The same as the Initial Population or a subset of the Initial Population to further constrain the population for the purpose of the eMeasure. |
| Denominator Exclusion (DENEX) | Entities that should be removed from the Initial Population and Denominator before determining if Numerator criteria are met. Denominator exclusions are used in Proportion and Ratio measures to help narrow the Denominator. |
| Numerator (NUMER) | The outcomes expected for each entity defined in the Denominator of a Proportion or Ratio measure. |
| Numerator Exclusion (NUMEX) | Entities that should be removed from the eMeasure's Numerator before determining if Numerator criteria are met. Numerator exclusions are used in Proportion and Ratio measures to help narrow the Numerator. |

Here is an example of using the population types to select data on patients with central line catheters for a ratio measure:

* Initial Population (IPOP): Patient is aged 65 years or older and admitted to hospital
* Denominator (DENOM): Patient has a central line
* Denominator Exclusion (DENEX): Patient is immunosuppressed
* Numerator (NUMER): Patient has a central line blood stream infection
* Numerator Exclusion (NUMEX): Patient's central line blood stream infection is deemed to be a contaminant

Figure 11: Calcuation Flow for Ratio Measure Score

![Calculation Flow Diagram-Ratio](assets/images/CalculationFlowDiagrams-Ratio.jpg)

* Initial population (IPOP): Identify those cases that meet the IPOP criteria. (Some ratio measures will require multiple initial populations, one for the numerator, and one for the denominator.)
* Denominator (DENOM): Identify that subset of the IPOP that meet the DENOM criteria.
* Denominator exclusion (DENEX): Identify that subset of the DENOM that meet the DENEX criteria.
* Numerator (NUMER): Identify that subset of the IPOP that meet the NUMER criteria.
* Numerator exclusion (NUMEX): Identify that subset of the NUMER that meet the NUMEX criteria.

##### 2.3.1.3.1 Individual Observations

For each case in the DENOM and not in the DENEX, determine the individual DENOM observations.

For each case in the NUMER and not in the NUMEX, determine the individual NUMER observations.

##### 2.3.1.3.2 Measusre Aggregates

Using individual observations for all cases in the DENOM and not in the DENEX, calculate the aggregate DENOM.

Using individual observations for all cases in the NUMER and not in the NUMEX, calculate the aggregate NUMER.

Ratio = aggregate NUMER / aggregate DENOM

##### 2.3.1.3.3 Patient-based Calcuation

The following snippet provides precise semantics for the measure score calculation for a patient-based ratio measure:

```cql
context Patient

define "Denominator Membership":
  "Initial Population"
    and "Denominator"
    and not "Denominator Exclusion"

define "Numerator Membership":
  "Initial Population"
    and "Numerator"
    and not "Numerator Exclusion"

context Population

define "Measure Ratio Numerator":
  Count("Numerator Membership" IsMember where IsMember is true)

define "Measure Ratio Denominator":
  Count("Denominator Membership" IsMember where IsMember is true)
```

##### 2.3.1.3.4 Non-patient-based Calcuation

The following snippet provides precise semantics for the measure score calculation for a non-patient-based ratio measure:

```cql
define "Numerator Membership":
  "Initial Population"
    intersect "Numerator"
    except "Numerator Exclusion"

define "Denominator Membership":
  "Initial Population"
    intersect "Denominator"
    except "Denominator Exclusion"

context Population

define "Measure Score Numerator":
  Count("Numerator Membership")

define "Measure Score Denominator":
  Count("Denominator Membership")
```

#### 2.3.1.4 Cohort Measure Score

In a cohort measure, a population is identified from the population of all items being counted. For example, one might identify all the patients who have had H1N1 symptoms. The identified population is very similar to the Initial Population but is called a Cohort Population for public health purposes. In the Constrained Information Model (CIM), the population will be expressed using the InitialPopulationCriteria act. The Cohort Population result is used by public health agencies to trigger specific public health activities. The following diagram depicts the population for a Cohort measure and the table below provides its definition.

Figure 12: Population criteria for Cohort measures illustration

![Cohort Venn Diagram](assets/images/CohortVenn.jpg)

Table 5: Population Criteria Definitions for Cohort Measures

| Population | Definition |
|:----|:----:|
| Initial Population (IPOP) | All entities to be evaluated by an eMeasure which may but are not required to share a common set of specified characteristics within a named measurement set to which the eMeasure belongs. (Also known as a Cohort Population) |

Here is an example of using the population types to select data on patients who have received immunizations for a Cohort measure:

* Initial Population (IPOP): All patients who had an immunization

Figure 13: Calcuation Flow for Cohort

Calculation Flow Diagram-Cohort

* Initial population (IPOP): Identify those cases that meet the IPOP criteria.

### 2.3.2 Population Criteria and Data Criteria

Population Criteria are constructed using Data Criteria to appropriately identify the right population. In order to use multiple Data Criteria to filter out populations, the Data Criteria are combined logically using "AND/OR/XOR" operators. These operators appear in the form of:

* "AllTrue" and "AllFalse", representing AND and NOR operators respectively
* "AtLeastOneTrue" and "AtLeastOneFalse" representing OR and NAND operators respectively
* "OnlyOneTrue" and "OnlyOneFalse" representing XOR operator

For example, to identify an Initial Population consisting of male patients between the ages of 16-74, we would construct two Data Criteria elements and combine them as follows:

* Data Criteria Element 1: "Patient is between the ages of 16-74"
* Data Criteria Element 2: "Patient is male"
* Combine the above two criteria using the "AllTrue" operator (which is a logical AND) to extract the Initial Population desired.

### 2.3.3 Population Criteria and Items Counted

Most eMeasures need the ability to designate what a population is counting. For example, a single measure may need to look at how many patients met a particular criterion, the number of beds available for those patients, and the number of staff treating those patients. To express this, Items Counted (ITMCNT) is provided as a Measure Attribute so that a population can make explicit what is being counted.

Items Counted can be specified at the document level or at the specific population level using the measureAttribute act class.