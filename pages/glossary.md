---
layout: default
title: Glossary
---

---

<!-- TOC  the css styling for this is \pages\assets\css\project.css under 'markdown-toc'-->

* Do not remove this line (it will not be displayed)
{:toc}

## 10 Glossary

### 10.1 Glossary
See the [eCQI Resource Center](https://ecqi.healthit.gov/glossary) for additional definitions

#### A.1 Clinical Quality Framework (CQF)

The Clinical Quality Framework is a joint effort by the Clinical Decision Support and Clinical Quality Information Work Groups to identify, develop, and harmonize standards that promote integration and reuse between Clinical Decision Support (CDS) and Clinical Quality Measurement (CQM). [Source](https://confluence.hl7.org/display/CQIWC/Clinical+Quality+Framework)

#### A.2 Cohort

A measure score in which a population is identified from the population of all items being counted. For example, one can identify all the patients who have had H1N1 symptoms. This population is very similar to the Initial Population but is called a Cohort Population for public health purposes.

#### A.3 Continuous Variable

A measure score in which each individual value for the measure can fall anywhere along a continuous scale and can be aggregated using a variety of methods such as the calculation of a mean or median (for example, mean number of minutes between presentation of chest pain to the time of administration of thrombolytics). [Source](https://ecqi.healthit.gov/glossary)

#### A.4 Denominator

The lower part of a fraction used to calculate a rate, proportion, or ratio. It can be the same as the initial population or a subset of the initial population to further constrain the population for the purpose of the measure. Continuous variable measures do not have a denominator, but instead define a measure population. [Source](https://ecqi.healthit.gov/glossary)

For measures that include multiple populations, different populations may have different denomintaors, grouping the denominators along specific criteria (e.g. patient's age, diagnosis, surgical procedures, prior myocardial infarction, etc.).

Different measures within a measure set (see A.18, Quality Measure Set) may have different Denominators (e.g., measure #1 Denominator = Initial Population AND Smoker; measure #2 Denominator = Initial Population AND Atrial Fibrillation). A Denominator can have inclusion and exclusion criteria.

#### A.5 Denominator Exception

 Any condition that should remove a patient, procedure, or unit of measurement from the denominator of the performance rate only if the numerator criteria are not met. A denominator exception allows for adjustment of the calculated score for those providers with higher risk populations. A denominator exception also provides for the exercise of clinical judgment and should be specifically defined where capturing the information in a structured manner fits the clinical workflow. A denominator exception is used only in proportion measures. Denominator exception cases are removed from the denominator. However, the number of patients with valid exceptions may still be reported. Allowable reasons fall into three general categories - medical reasons, patient reasons, or system reasons. [Source](https://ecqi.healthit.gov/glossary)

#### A.6 Denominator Exclusion

A case that should be removed from the denominator before determining if numerator criteria are met. Denominator exclusions are used in proportion and ratio measures to help narrow the denominator. For example, patients with bilateral lower extremity amputations would be listed as a denominator exclusion for a measure requiring foot exams. [Source](https://ecqi.healthit.gov/glossary)

#### A.7 Direct Reference Code

A direct reference code (DRC) is a specific code that is referenced directly in the eCQM logic to describe a data element or one of its attributes. Direct reference code metadata include the description of the code, the code system from which the code is derived, and the version of that code system.

#### A.8 Electronic Clinical Quality Measure (eCQM)

A clinical quality measure that is expressed and formatted to use data from electronic health records (EHR) and/or health information technology systems to measure healthcare quality, specifically data captured in structured form during the process of patient care. So they can be reported from an EHR, the FHIR Measure Resource is used to format the eCQM content using QI Core to define the data elements and Clinical Quality Language (CQL) to express the logic needed to evaluate a provider or organization's performance. [Source](https://ecqi.healthit.gov/glossary)

#### A.9 Health Quality Measures Format (HQMF)

An HL7 Version 3 normative standard for the representation of quality measures. This specification provided the base requirements for the FHIR Measure resource.

#### A.10 Initial Population

All events to be evaluated by a specific electronic clinical quality measure (eCQM) involving patients who share a common set of specified characteristics within a specific measurement set to which a given measure belongs. All patients counted (for example, as numerator, as denominator) are drawn from the initial population. [Source](https://ecqi.healthit.gov/glossary)

#### A.11 Measure Population

Continuous variable measures do not have a Denominator, but instead define a Measure Population. To be in the Measure Population, a patient must be in the Initial Population. Proportion and Ratio measures do not have a Measure Population, but instead define a Denominator.

#### A.12 Measure Population Exclusion

Measure Population Exclusions are used in Continuous Variable Measures to define instances that should not be included in the Measure Population.

#### A.13 Numerator

The numerator is the upper portion of a fraction used to calculate a rate, proportion, or ratio. Also called the measure focus, it is the target process, condition, event, or outcome. Numerator criteria are the processes or outcomes expected for each patient, procedure, or other unit of measurement defined in the denominator. A numerator statement describes the clinical action that satisfies the conditions of the performance measure. [Source](https://ecqi.healthit.gov/glossary)

#### A.14 Numerator Exclusion

The numerator exclusion defines the instances that should not be included in the numerator data. Numerator exclusions are used in ratio and proportion measures. [Source](https://ecqi.healthit.gov/glossary)

#### A.15 Outcome Measure

A measure that assesses the results of healthcare that are experienced by patients: clinical events, recovery and health status, experiences in the health system, and efficiency/cost. [Source](https://ecqi.healthit.gov/glossary)

#### A.16 Process Measure

A measure that focuses on a sequence of actions or steps that should be followed to provide high quality evidence-based care. There should be a scientific basis for believing that the process, when executed well, will increase the probability of achieving a desired outcome. [Source](https://ecqi.healthit.gov/glossary)

#### A.17 Proportion

A score derived by dividing the number of cases that meet a criterion for quality (the numerator) by the number of eligible cases within a given time frame (the denominator) where the numerator cases are a subset of the denominator cases (for example, percentage of eligible women with a mammogram performed in the last year). [Source](https://ecqi.healthit.gov/glossary)

#### A.18 Quality Measure Set

A unique grouping of measures carefully selected to provide, when viewed together, a robust picture of the care provided in a given domain (e.g., cardiovascular care, pregnancy).

#### A.19 Quality Measure (or Performance Measure)

A numeric quantification of healthcare quality for a designated accountable healthcare entity, such as hospital, health plan, nursing home, clinician, etc. A healthcare performance measure is a way to calculate whether and how often the healthcare system does what it should. Measures are based on scientific evidence about processes, outcomes, perceptions, or systems that relate to high-quality care. [Source](https://ecqi.healthit.gov/glossary)

#### A.20 Rate Aggregation

An organization or clinician uses rate aggregation to determine measure rate and based upon the entities’ aggregate data and summarizes the performance of the entity over a given time period (e.g., monthly, quarterly, yearly). The aggregated data are derived from the results of a specific measure algorithm and, if appropriate, the application of specific risk adjustment models.

#### A.21 Ratio

A ratio is a score that is derived by dividing a count of one type of data by a count of another type of data. For example, the number of patients with central lines who develop infection divided by the number of central line days. [Source](https://ecqi.healthit.gov/glossary)

#### A.22 Stratification

Criteria used to classify populations into one or more characteristics, variables, or other categories. As subsets of the overall population, stratifications are used in risk adjustment, analysis and interpretation. Examples of stratification include age, discharge status for an inpatient stay, facility location within a hospital (e.g., ICU, Emergency Department), surgical procedures, and specific conditions.

#### A.23 Supplemental Data Elements

Additional variables required for risk adjustment or other purposes of data aggregation. Comparison of results across strata can be used to show where disparities exist or where there is a need to expose differences in results. Examples of supplemental data elements include payer, ethnicity, race and gender.


### 10.2 Acronyms

| Acronym |  |  Definition        |
| :--- | :---: | :--- |
| API | --- |	Application Program Interface |
| CDS |	--- | Clinical Decision Support |
| CMS |	--- | Centers for Medicare and Medicaid Services |
| CQFM | --- |	Clinical Quality Framework Measures |
| CQL |	--- | Clinical Quality Language |
| CQM |	--- | Clinical Quality Measures |
| eCQM | --- | 	electronic Clinical Quality Measures |
| DEQM | --- |	Data Exchange For Quality Measures |
| EHR |	--- | Electronic Health Record |
| ELM |	--- | Expression Logical Model |
| FHIR | --- |	Fast Healthcare Interoperability Resources |
| HEDIS |	--- | Healthcare Effectiveness Data and Information Set |
| HL7 | --- | Health Level Seven |
| HQMF |	--- | Health Quality Measure Format |
| ICU |	--- | Intensive Care Unit |
| IG |	--- | Implementation Guide |
| JSON |	--- | JavaScript Object Notation |
| LOINC |	--- | Logical Observation Identifiers Names and Codes |
| QDM |	--- |Quality Data Model |
| QI Core |	--- | Quality Improvement Core |
| QRDA |	--- | Quality Reporting Document Architecture |
| QUICK |	--- | Quality Information and Clinical Knowledge logical model |
| R4 |	--- | FHIR Release 4 |
| REST | --- |	Representational State Transfer |
| SNOMED-CT |	--- | Systematized Nomenclature of Medicine -- Clinical Terms |
| STU3 | --- |	FHIR Release 3 (STU) |
| URI | --- |	Uniform Resource Identifier |
| URL | --- |	Uniform Resource Locater |
| XML | --- |	eXtensible Markup Language |
