---
layout: default
title: HQMF Encoding eMeasure Quality Statements
---
### 2.7 Encoding eMeasure Quality Statements

#### 2.7.1 General Approach

Quality measures exist in a variety of formats today. The HQMF specification, while providing formalism for query measure statements, also provides an incremental approach where one can:

* Create a minimally conformant eMeasure that simply wraps an existing quality measure in any electronic format within the HQMF header.
* Represent the full narrative of a quality measure within the narrative blocks of HQMF defined sections.
* Enhance the full narrative within the HQMF XML with a formalized representation of quality statements. This formalism is based on the following approach, which serves to modularize the process and make it understandable, reusable, and implementable via an eMeasure authoring tool:
  1. Data criteria are defined: A criterion ("age is greater than 18", "antibiotic was prescribed", "diminished renal capacity", "length of stay less than 120 days") is an assertion that can be found to be true or false, when comparing against raw data (either QRDA documents or EHR data).Formally, Data Criteria return sets of matching data nodes which pass the assertions stated in the Data Criteria. Hence, an empty data set resolves to "false" , while a non-empty set resolves to "true". Filters can then be applied to a returned non-empty data set. Data Criteria in HQMF are used primarily to determine whether or not the item being counted (e.g., patients, encounters, procedures, etc.) is included in a measure's Population, Numerator, Denominator, etc. For instance, a measure might say that "to be included in the Denominator, a patient must have age greater than 18 and antibiotic therapy prescribed". HQMF formalizes Data Criteria by expressing them as RIM patterns coupled with vocabularies. Where a patient or the item being counted has an object in EHR that is subsumed by Data Criteria, those criteria can be deemed true for that patient or item being counted. Most measures focus on counting the number of patients that meet certain Data Criteria. However, this may not always be the case. An example of a non-patient centric measure is NQF #0435, which counts encounters where Ischemic stroke patients were prescribed antithrombotic therapy at hospital discharge (the item being counted here would be encounters and not actual patients).
  2. Population Criteria are defined: Criteria for Numerator, Denominator, and other measurement populations are defined based on the underlying Data Criteria. For instance, the criteria for a patient to be part of a measure's Denominator might be that the patient meets the criteria for "diminished renal capacity" and does not meet the criteria that "antibiotic was prescribed". Population Criteria, like Data Criteria, are assertions that can be found to be true or false, thereby providing a means for HQMF to formalize a measure's population parameters.
  3. Measure observations are defined: While some quality measures only define Data Criteria and Population Criteria, other quality measures also define variables or calculations that are used to score a particular aspect of performance. For instance, a measure intends to assess the use of restraints. Population criteria for the measure include "patient is in a psychiatric inpatient setting" and "patient has been restrained". For this population, the measure defines a measure observation of "restraint time" as the total amount of time the patient has been restrained. Measure observations are not criteria, but rather, are definitions of observations, used to score a measure. Examples in Public Health Reporting Requirements include:
      * Next shot due date and administration of the same vaccine > 1 month
      * Significant increase in BMI- increase of BMI>10% in a 6 month period

These steps are described in greater detail in the chapters that follow. HQMF entries corresponding to these steps are segregated into different sections in an eMeasure.

#### 2.7.2 Patient Criteria vs. Aggregate Scores

Terms like "numerator" and "denominator" can be ambiguous, in that they can refer to [1] the criteria for determining if an individual patient is included in a particular population (e.g., "numerator criteria are inpatient AND diagnosis of pneumonia AND treated with antibiotic"); [2] the total count of patients meeting the criteria (e.g., "27 patients meet the numerator criteria"); [3] the top or bottom of a fraction (e.g., "the numerator is total restraint time, the denominator is total psychiatric inpatient days"). HQMF differentiates these interpretations in a number of ways:

* Data criteria and population criteria are expressed as individual patient criteria. In other words, criteria are constructed such that one can determine whether or not a particular patient meets the criteria.
* HL7 has distinct codes to distinguish between the interpretations. For example, the code "included in denominator" is an assertion (represented in HQMF as an observation value) that a patient has met the denominator criteria; whereas the code "denominator count" is an observation (represented as an observation code) that carries a value.
* Measure Observations are not implicitly tied to any particular population and can explicitly reference the population over which they apply. For example, a measure defines a Measure Observation "average systolic blood pressure" as the sum of systolic blood pressures divided by the number of blood pressure readings. While the "sum of systolic blood pressures" is the numerator of an equation, it bears no relationship to the measure's numerator population. In fact, a quality organization may require that "average systolic blood pressure" be reported on any of the measure populations. Examples in Public Health Reporting Requirements include:
  * Exposure duration
    * Time from screening to consultation
    * Exposure to lead for more than 30 days
    * Exposure to treatment
  * Foreign travel in excess of 1 week

#### 2.7.3 Measure Definition vs. Reporting Requirements

Organizations with a variety of quality reporting goals can collect data based on the same eMeasure, but stipulate different reporting requirements. For example, several organizations might be interested in the use of antibiotics in patients with bronchitis. An eMeasure could then define the nenominator criteria as "encounter with diagnosis of bronchitis", and the numerator criteria as "antibiotic prescription is written". One quality organization wishes to receive a quarterly summary where all qualifying encounters are reported, stratified by age; whereas another quality organization requests semi-annual reports, where, in order to minimize the human burden of chart review, only 20% of encounters with a diagnosis of bronchitis need to be sampled.

A "measure definition" includes those components of a quality measure that are fixed and universally applicable, whereas "reporting requirements" are not part of a measure's definition, and can vary across organizations. While the dividing line is not absolute, common reporting requirements that are not typically defined as part of an eMeasure include reporting frequency, sampling, etc.