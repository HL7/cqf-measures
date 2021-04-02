---
layout: default
title: HQMF Overview
---
# 1 HQMF Overview

## 1.1 What is the HQMF, and what is an eMeasure?

The Health Quality Measures Format (HQMF) is a standard for representing a health quality measure as an electronic document. A quality measure is a quantitative tool to assess the performance of an individual or organization's performance in relation to a specified process or outcome via the measurement of an action, process, or outcome of clinical care. Quality measures are often derived from clinical guidelines and are designed to determine whether the appropriate care has been provided given a set of clinical criteria and an evidence base. Quality measures are also often referred to as performance measures or quality indicators. Public health programs engage in quality measurement in the context of monitoring and improving the health of the jurisdiction population. Specific measures and other analytics are performed within surveillance programs and are subject to correlation with dynamic environmental factors, social conditions, and other epidemiologic criteria that are not suited to static measure definition. In support of these quality measurement activities, cohort measures specify a population of interest to a given surveillance program. Such cohort measures are intended to assess and report records of interest to the surveillance program.

Through standardization of a measure's structure, metadata, definitions, and logic, the HQMF provides measure consistency and unambiguous interpretation. A health measure encoded in the HQMF is referred to as an "eMeasure".

Standardization of document structure (e.g., sections), metadata (e.g., author, verifier), and definitions (e.g., numerator, initial population) enables a wide range of measures, currently existing in a variety of formats, to achieve at least a minimal level of consistency and readability, even if not fully machine processable.

Formal representation of the clinical, financial, and administrative concepts and logic within an eMeasure supports unambiguous interpretation and consistent reporting. Examples of statements that can be formally represented by the HQMF are:

    To be included in a measure's Denominator, a patient will have had at least two face-to-face visits; AND will have a confirmed diagnosis of coronary artery disease (based on diagnostic or procedure criteria).

    To be included in a measure's Initial Population, a patient will have had a principal inpatient discharge diagnosis of stroke; AND a hospital length of stay less than or equal to 120 days.

    To be included in a public health reportable population, a patient will have a confirmed diagnosis of Tuberculosis within a given reporting period; AND residence within a jurisdiction that requires reporting of Tuberculosis.

HQMF, like the HL7 Clinical Document Architecture (CDA) standard, is derived from an overarching structured document architecture. HQMF is not a CDA standard, but rather, has a peer-to-peer relationship with CDA. In order to report the results of an HQMF computation, systems typically will use the HL7 CDA R2 Quality Reporting Document Architecture (QRDA) standard.

## 1.2 Guidance for Measure Developers

Creating eMeasures in HQMF requires measure developers to adopt a programmer's mind-set. Constructing or creating eMeasures in HQMF is similar to constructing an SQL query. HQMF is a declarative programming language. As with any such language, it is possible to create code that is syntactically correct but logically incorrect. The result is unanticipated bugs or side effects. Therefore, while creating eMeasures, measure developers must consider that each eMeasure will be processed by an HQMF Release 2 (R2) processing engine. A processing engine is a program that parses an HQMF file, executes the logic against a data store, and computes results (i.e., 7 patients in the Denominator, 3 in the Numerator). As HQMF processing engines become more available, measure developers will need to adopt many of the practices common to software development such as integrating testing with the development process. Measure developers can refer to HQMF processing engines that currently exist (e.g., US ONC Query Health Initiative, MITRE Cypress project) to better understand HQMF processing complexities. 

## 1.3 HQMF for Quality and Public Health

### 1.3.1 HQMF and Quality Improvement

Figure 1: Quality measure framework

![Quality measure framework](assets/images/eMeasureQualityLifeCycle.jpg)

Measure developers, drawing on available evidence, devise measureable parameters to gauge the quality of care in a subject area. These parameters are assembled into quality measures, which are then expressed as eMeasures in HQMF. A set of eMeasures may be used to guide care decisions as well as data collection for Electronic Health Record (EHR) and other systems. The data are then assembled into quality reports (e.g., QRDA documents) and submitted to quality reporting or other organizations. 

### 1.3.2 HQMF and Public Health Cohort Measure Definitions for Reporting

HQMF is part of a larger public health reporting framework, as shown in the following figure. 

Figure 2: Public health eMeasure framework

![Public health eMeasure framework](assets/images/PublicHealtheMeasureFramework.jpg)

Public health epidemiologists, often drawing upon available evidence, devise requirements for reporting from providers and laboratories to monitor community health. These reporting requirements are mapped to standard vocabularies and structures available to EHR systems, laboratory systems, and information exchanges, which are then expressible as a Cohort measure definition in HQMF (called an eMeasure). This eMeasure may be understood by providers to guide reportable actions for care, and to guide collection of Electronic Health Record (EHR), laboratory, and other source reporting data. These data are assembled into public health reports (e.g., Healthcare Associated Infection (HAI) CDA Report, HL7 CDA for public health reports) and submitted to public health authorities.

Unambiguous expression of concepts and logic within an eMeasure is a necessary step towards the larger objective of enabling a direct query against an EHR or other operational data store. While HQMF is not an EHR query language, through the provision of unambiguous and formal definitions, it is an EHR query enabler. Additionally, an unambiguous representation of the clinical concepts in an eMeasure allows EHR vendors and healthcare providers to be proactive in capturing such information at the point of care. If, for example, a quality measure reports on the provision of educational material to stroke patients, the corresponding eMeasure will make it clear exactly what type of educational material would be considered appropriate care. If the eMeasure calls for the collection of a certain data element not normally captured by the EHR, the EHR might now prompt the user to collect this information, thereby enhancing both the quality of data reporting and the quality of care. These data might similarly be captured through invoking a public health reporting form that is pre-populated from the EHR data allowing for the user to enter the remaining data attributes. 

# 2 General HQMF Concepts

This chapter serves as a high-level introduction to the concepts used within an eMeasure document, all of which are described in greater detail in later chapters. For the purposes of public health reporting, the case reporting requirements will be expressed as Cohort measures.

HQMF concepts of measurement period, Data and Population Criteria, stratifiers, and other measure attributes are bundled together in a structure shown in the diagram below. 

Figure 3: Typical HQMF document structure

![Typical HQMF document structure](HQMF-structure.png)

An eMeasure document is wrapped by the <QualityMeasureDocument> element, and contains a header and a body (see QualityMeasureDocument). The header identifies and classifies the document and provides important metadata about the measure.

The body contains sections (<populationCriteriaSection> <dataCriteriaSection>, etc.), each wrapped by the <component> element. Each section can contain a single HQMF narrative block (see the Section Narrative Block), and any number of HQMF entries. An eMeasure conformant to the specification may contain pre-defined components, such as the Population Criteria Section (see Document constraints). Each pre-defined component may suggest or require various entries (see Section Constraints), and HQMF entries within these components are constrained to better ensure consistency across eMeasures (see Entry Constraints). Additional components and entries, above and beyond those required for HQMF conformance, can be included as needed.

The HQMF narrative block must contain the human readable content to be rendered. Within a component, the narrative block represents content to be rendered whereas HQMF entries represent structured content provided for further computer processing.

A minimally conformant eMeasure will contain elements from the document header, but need not include computable Data Criteria. In this case, the full narrative of the eMeasure, in any electronic format, is placed into or referenced by QualityMeasureDocument.text. From there, one can represent the full narrative of a quality measure within the narrative blocks of HQMF defined components. Full encoding further enhances the narrative of the quality measure with the addition of entries.

The following truncated XML snippet shows the high level XML structure of an HQMF Document. 

```xml
<!-- Start of an HQMF R2 eMeasure. An eMeasure is surrounded by the QualityMeasureDocument element. -->
<QualityMeasureDocument>
   <!-- Header attributes including Title, Narrative, Author, Custodian etc.  -->
   <templateId />
   <title />
   <text />
   <author />
   <custodian />
   <verifier />
   
   <!-- defining the time period that this eMeasure applies to -->
   <controlVariable>
      <measurePeriod />
   </controlVariable>
   
   <!-- Miscellaneous metadata for an eMeasure -->
   <subjectOf>
      <measureAttribute />
   </subjectOf> 

   <!-- Sections -->
   <!-- Measure Description Section -->
   <component>
      <measureDescriptionSection />      
   </component> 
    
   <!-- Data Criteria Section, containing actCriteria, etc. --> 
   <component>
      <dataCriteriaSection />
   </component> 
   
   <!-- Population Criteria Section containing an Initial Population, 
   numeratorCriteria, denominatorCriteria exclusions, exceptions, 
   stratifier Criteria etc. -->
   <component>
      <populationCriteriaSection />
   </component>
   
   <!-- Measure Observation Section containing expression language expressions 
      for evaluation using Data Criteria-->
   <component>
      <measureObservationsSection />
   </component>

</QualityMeasureDocument>
<!-- end of eMeasure -->
```

## 2.1 Measurement Period

Every quality measure has a Measurement Period. The Measurement Period designates the reference time frame for which data are identified, filtered and analyzed. Measurement Period can be expressed as both fixed times (start and end date) and relative times (start date and a period of reporting frequency). The exact usage of Measurement Period depends on the measure and its purpose. Data that are collected before or after the Measurement Period can also be identified with a time relationship, explained in the next part of this document. 

## 2.2 Data Criteria

A "criterion" is something that can be evaluated to be TRUE or FALSE for a given item. It lays out a pattern to be matched by an object in an EHR.

The Data Criteria of a measure identify the various conditions that determine if a data item is included in the measure population or not (based upon clinical or public health interests).

For example:

    "Patient is between the ages of 20 - 30 years"
    "Patient had a hbA1C test as part of last visit"
    "Patient's last LDL cholesterol is < 100"
    "Patient has Diabetes type II"

Data Criteria can be defined against the following types of clinical data elements (this list is not exhaustive):

    Patient Demographics
    Encounters
    Medications
    Laboratory Results
    Vital Signs
    Problems
    Procedures
    Allergies
    Immunizations

Note that the actual contents of a Data Criteria element are determined by the type of data being referenced in the criteria. For example, an Encounter data criteria is represented with a Act of type Encounter, so the elements available will be determined by the structure of that type. 

### 2.2.1 Filters and Data Criteria



HQMF assumes that Data Criteria are evaluated in stages. For example a Data Criterion element (encounter) might include a constraint that a patient had an encounter within the measurement period. When this Data Criterion element is evaluated, first a list of all encounters is retrieved. Then, those encounters not within the measurement period are removed. If the resulting list of encounters is empty, then the criterion is not satisfied. If the list contains at least one encounter, then the criterion is satisfied. This document refers to that refinement process as "filtering" and the refinements applied to a data criterion during evaluation as "filters". The filters that can be applied to a Data Criterion element include temporally related information, outbound relationship, and excerpt.

For example:

    Patient has an HbA1C value > 9% in the "LAST" laboratory test.
    The patient was diagnosed with Diabetes Type II, and the "FIRST" encounter where the patient was diagnosed was within the measurement period.
    Patient's "LAST" vaccination was within 3 months of the "FIRST" vaccination.

In the above examples, "LAST" and "FIRST" are examples of filters (using excerpt) that can be applied to initial Data Criteria to refine and extract the population of interest.

Data Criteria can be related to other Data Criteria or Measurement Period via time relationships. The following examples show how an encounter can have a temporal relationship with other Data Criteria or a Measurement Period.

    Patient had a laboratory test that occurred one year before the most recent encounter.
    Patient has encounters during the Measurement Period where a particular medication was requested.
    Patient had a diagnosis of disease X within N years of immunization for disease X.

### 2.2.2 Value Sets and Data Criteria



Quality measures often need to select patients based on enumerated features of demographics, encounters, medications or other criteria that span a range of coded values. These ranges of coded values are represented as value sets and are used to filter populations.

A value set represents a uniquely identifiable set of valid concept identifiers, where any concept identifier in a coded element can be tested to determine whether it is a member of the value set at a specific point in time. A concept identifier in a value set may be a single concept code or a post-coordinated expression of a combination of codes. A value set has a unique identifier that is assigned by the owner of the value set. These identifiers are referenced within the Data Criteria and included within the eMeasure. The exact representation will be described later in this document.

An example of a value set is a list of codes for Diabetes Type II. The list could have a name that conveys what is in the list of codes (e.g., Diabetes Type II). The value set is identified by an OID (e.g., 2.16.840.1.113883.3.464.1.37) and belong to a particular entity which maintains oversight of the value set and makes any updates to it as needed.

A value set from public health, for example, is Immunization Service Funding Eligibility, identified by 2.16.840.1.114222.4.5.301. It includes national classifications Immunization Service Funding Eligibility assigned to the patient for the purpose of identifying sources of reimbursement. As with many public health domain value sets, this is maintained by the PHIN-VADS Value Set Repository (https://phinvads.cdc.gov/). This value set may be further constrained or extended by state or regional jurisdictions (assigned a separate identifier) where additional classifications may also be supported.

Note that according to Quality Data Model (QDM), a value set is constrained to a single code system. The exception to this rule is grouping value sets. Through grouping value sets, multiple value sets of the same or different code systems can be combined into one value set.

### 2.2.3 Processing Order and Data Criteria

Data Criteria can include a set of filters on the events identified. The order in which those filters are processed determines the end result for any specific criterion. All Data Criteria processing is performed in document order, meaning the order in which the criteria elements appear in the document, and the processing is not complete until all of the Data Criteria children are processed. The concepts are explained below using a few examples.

Consider the XML example below which specifies an ObservationCritiera which, when processed, will extract the last hbA1C greater than 9% among all the observations where hbA1C was measured.

The processing of Data Criteria when executed in document order is as follows:

    Identify and extract the result observations where hbA1C are measured. This is performed using the value set of the code element. Let us call this the set of "hbA1C observations".
    Identify and extract from the set of "hbA1C observations" the ones where the value is greater than 9%. This is done when the value element is processed. Let us call this the set of "hbA1C observations greater than 9%".
    Identify and extract the last observation from the set of "hbA1C observations greater than 9%". This is done when the excerpt element is processed which identifies the observation to be extracted.

```xml
<entry typeCode="DRIV">
   <localVariableName value="LastHbA1Cgt9"/>
   <observationCriteria classCode="OBS" moodCode="EVN">
      <id root="2.16.840.1.113883.19" extension="LastHbA1Cgt9"/>
      <code valueSet="2.16.840.1.113883.3.464.1.72"/>
      <value xsi:type="IVL_PQ" lowClosed="false">
         <low value="9" unit="%"/>
         <high nullFlavor="PINF"/>
      </value>
      <excerpt>
         <subsetCode code="LAST"/>
            <observationCriteria classCode="OBS" moodCode="EVN">
                <id root="2.16.840.1.113883.19" extension="LastHbA1Cgt9"/>
            <observationCriteria/>
      </excerpt>
   </observationCriteria>
</entry>
```

The next example shows how to check if the "last hbA1c measured was greater than 9%". This is different than the previous example, which extracted the last one from the set of "hbA1c results greater than 9%".

There are 3 different criteria elements required to perform this operation.

    The first criterion identifies and extracts the last hbA1c observation regardless of the value of the observation.
    The second criterion checks if an observation value is greater than 9%, regardless of whether the observation is the first one or last one or one in between.
    The third criterion is a grouper criterion which is used to intersect the first and the second criteria, the intersect operation will only extract the observation if it is the last one and it is greater than 9%.

```xml
<!-- Get last A1C (Criteria A) -->
<entry typeCode="DRIV">
   <localVariableName value="LastHbA1C"/>
   <observationCriteria classCode="OBS" moodCode="EVN">
      <id root="2.16.840.1.113883.19" extension="LastHbA1C"/>
      <code valueSet="2.16.840.1.113883.3.464.1.72"/>
      <definition>
         <criteriaReference classCode="OBS" moodCode="EVN">
            <id root="2.16.840.1.113883.19" extension="Results"/>
         </criteriaReference>
      </definition>
      <excerpt>
         <subsetCode code="LAST"/>
            <observationCriteria classCode="OBS" moodCode="EVN">
                <id root="2.16.840.1.113883.19" extension="LastHbA1C"/>
            <observationCriteria/>
      </excerpt>
   </observationCriteria>
</entry>
		
<!-- Criteria to check for a1c greater than 9% (Criteria B) -->
<entry typeCode="DRIV">
   <localVariableName value="HbA1Cgt9"/>
   <observationCriteria moodCode="EVN">
      <id root="2.16.840.1.113883.19" extension="HbA1Cgt9"/>
      <value xsi:type="IVL_PQ">
         <low value="9" unit="%"/>
      </value>
      <definition>
         <criteriaReference classCode="OBS" moodCode="EVN">
            <id root="2.16.840.1.113883.19" extension="Results"/>
         </criteriaReference>
      </definition>
   </observationCriteria>
</entry>
		
<!-- Create another Grouper criteria which is an intersect of A and B, meaning that we are intersecting  -->
<entry typeCode="DRIV">
   <grouperCriteria classCode="GROUPER" moodCode="EVN">
      <id root="2.16.840.1.113883.19" extension="IsLastA1Cgt9"/>
      <outboundRelationship typeCode="COMP">
        <conjunctionCode code="AND"/>
        <criteriaReference classCode="OBS" moodCode="EVN">
            <id root="2.16.840.1.113883.19" extension="LastHbA1C"/>
        </criteriaReference>
      </outboundRelationship>
      <outboundRelationship typeCode="COMP">
        <conjunctionCode code="AND"/>
        <criteriaReference classCode="OBS" moodCode="EVN">
            <id root="2.16.840.1.113883.19" extension="HbA1Cgt9"/>
        </criteriaReference>
      </outboundRelationship>
   </grouperCriteria>
</entry>
```

### 2.2.4 Result Evaluation and Caching

The HQMF standard allows Data Criteria to be referenced using the Data Criteria ID. This allows measure developers to create a Data Criteria definition once and reuse it multiple times throughout the measure document using the ID. Results compiled from evaluation of the original Data Criteria can be cached. The cached results can be reused, without reevaluation, whenever the Data Criteria ID is referenced. However, HQMF R2 does not mandate result caching (i.e., Data Criteria referenced via an ID can be reevaluated each time) and leaves this detail up to specific implementations of the standard. 

### 2.2.5 Risk Adjustment Variables

In developing outcome measures, one challenge that measure developers often have is accounting for factors outside of provider or hospital control. These are features such as patient characteristics (age, health, etc.) or other risk factors. Because of variations in these risk factors, patients may experience variations in outcomes of care. Such variations in outcomes might not reflect the actual quality of care provided by the health care organization. Adjusting an outcome measure for these factors, a process called Risk Adjustment which produces a risk adjusted outcome measure, allows accurate comparison of outcomes across organizations.

Risk adjusted outcome measures identify risk factors as risk variables. Risk variables are plugged into a risk model to calculate the risk adjustment. In HQMF, risk variables are expressed in data criteria that extract the information needed for the risk model.

For example, a measure that calculates the risk-standardized mortality rate will identify risk variables such as patient age, first measurement of systolic blood pressure, first troponin level, and first creatinine level. Data criteria for the troponin and patient age risk variables are shown below: 

```xml
<entry typeCode="DRIV">
  <localVariableName value="Troponin"/>
  <observationCriteria moodCode="EVN" classCode="OBS">
    <id root="2.16.840.1.113883.3.100.1" extension="LaboratoryTestResultFirstTroponinLevelGroup"/>
    <code xsi:type="CD" valueSet="2.16.840.1.113883.3.666.5.2361">
      <displayName value="First Troponin Level Group"/>
    </code>
    <text value="Laboratory Test, Result: First Troponin Level Group"/>
    <excerpt typeCode="XCRPT">
      <subsetCode code="FIRST"/>
      <observationCriteria classCode="OBS" moodCode="EVN">
        <id root="2.16.840.1.113883.3.100.1" extension="LaboratoryTestResultFirstTroponinLevelGroup"/>
      </observationCriteria>
    </excerpt>
  </observationCriteria>
</entry>
<entry typeCode="DRIV">
  <localVariableName value="PatientAge"/>
  <observationCriteria moodCode="EVN" classCode="OBS">
    <id root="2.16.840.1.113883.3.100.1" extension="PatientCharacteristicPatientAge"/>
    <code xsi:type="CD" valueSet="2.16.840.1.113883.3.190.5.47">
      <displayName value="Patient Age"/>
    </code>
    <text value="Patient Characteristic: Patient Age"/>
  </observationCriteria>
</entry>
```

## 2.4. Stratifiers

Stratifiers are constructed using Data Criteria and used to specify how the results need to be grouped.

For example:

    Identify all patients between the ages of 16 and 74 and stratify the counts by gender.

In the above example, the stratification criteria refer to gender and age Data Criteria elements to group the counts of patients between 16 and 74.

When a measure definition includes stratification, each population in the measure definition should be reported both without stratification, and stratified by each stratification criteria. Specific programs may require reporting of performance rates. The performance rate is defined as

Performance rate = (NUMER - NUMEX) / (DENOM – DENEX – DENEXCEP)

For measures with multiple numerators and/or strata, each patient/episode must be scored for inclusion/exclusion to every population. For example if a measure has 3 numerators, and the patient is included in the first numerator, the patient should be scored for inclusion/exclusion from the populations related to the other numerators as well.
