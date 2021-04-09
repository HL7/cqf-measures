

### Examples

* [**Simple Example**](Measure-measure-exm.html) Usage example illustrating all the common data elements of the CQF Measure profile - [Library](Library-EXMLogic.html)
* [**EXM146**](Measure-measure-exm146-FHIR.html) Encounter-based proportion measure example - [Library](Library-EXM146.html)
* [**EXM55**](Measure-measure-exm55-FHIR.html) Continuous-variable measure example - [Library](Library-EXM55.html)
* [**RatioMeasure**](Measure-measure-ratio-exm.html) Ratio measure example - [Library](Library-EXMRatio.html)
* [**Terminology**](Measure-measure-terminology-FHIR.html) Example illustrating terminology usage - [Library](Library-Terminology.html)
* [**RiskAdjustment**](Measure-measure-risk-adjustment-FHIR2.html) Example illustrating risk adjustment usage - [Library](Library-risk-adjustment-FHIR2.html)
* [**Common Library**](Library-Common.html) Usage example illustrating a library to share logic between measures
* [**SupplementalDataElements**](Library-SupplementalDataElements.html) Library illustrating common supplemental data elements

### Screening Measures

These examples illustrate patient-based screening measures

* [**EXM124**](Measure-measure-exm124-FHIR.html) Cervical Cancer Screening - [Library](Library-EXM124.html)
* [**EXM125**](Measure-measure-exm125-FHIR.html) Breast Cancer Screening - [Library](Library-EXM125.html)
* [**EXM130**](Measure-measure-exm130-FHIR.html) Colorectal Cancer Screening - [Library](Library-EXM130.html)

### Hospital Measures

* [**EXM108**](Measure-measure-vte-1-FHIR.html) Venous Thromboembolism Prophylaxis - [Library](Library-EXM108.html)

### Composite Measures
<div class='new-content' markdown='1'>
This section provides examples of all four composite measure scoring methods described by this implementation guide. Each composite is constructed using the same five component measures:

* [Breast Cancer Screening (BCS)](Measure-BCSComponent.html) - Patient-based proportion measure
* [Colorectal Cancer Screening (CCS)](Measure-CCSComponent.html) - Patient-based proportion measure
* [High Blood Pressure Screening (HBP)](Measure-HBPComponent.html) - Encounter-based proportion measure
* [Pneumococcal Vaccination (PVS)](Measure-PVSComponent.html) - Patient-based proportion measure
* [Tobacco Screening (TSC)](Measure-TSCComponent.html) - Patient-based proportion measure

For each of these measures, the population criteria are summarized as:

|Population | BCS | CCS | HBP | PVS | TSC |
|-----------|-----|-----|-----|-----|-----|
|Initial Population |female, 51-74, with Qualifying Encounters |50-75, with Qualifying Encounters |>= 18, Encounters in Encounter to Screen for Blood Pressure |>= 65, with Qualifying Encounters or Nursing/Long-term Facility encounters |>= 18 with Qualifying Encounters or Other/Counseling encounters or 2 or more Office visits |
|Denominator |Initial Population |Initial Population |Initial Population |Initial Population |Initial Population |
|Denominator Exclusions |Hospice or Mastectomy or AIFLTC |Hospice or Cancer or Colectomy or AIFLTC |Hypertension Diagnosis |Hospice |None
|Denominator Exceptions |None |None |Medical or Patient Reason |None |Medical Reason or Limited Life Expectancy |
|Numerator |Mammography |Colonoscopy or FOBT or Flex Sig or FIT DNA or CT Colonography |Normal BP or High BP with followup |Pneumococcal Vaccine |Screened for Tobacco Use |

#### All-or-nothing scoring

Interpretation: For each Eligible Clinician, the percentage of patients who received
all preventive services for which they were eligible

[Preventive Care and Wellness (All-or-nothing)](Measure-PreventiveCareandWellnessAllOrNothingComposite.html)

#### Opportunity scoring

Interpretation: For each Eligible Clinician (EC), the percentage of opportunities to provide preventive services that were completed.

[Preventive Care and Wellness (Opportunity)](Measure-PreventiveCareandWellnessOpportunityComposite.html)

#### Patient-level linear

Interpretation: For each Eligible Clinician (EC), the percentage of completed preventive services, which gives EC partial numerator credit for meeting the criteria for some but not all components of the measure.

[Preventive Care and Wellness (Patient-level linear)](Measure-PreventiveCareandWellnessPatientLevelLinearComposite.html)

#### Component-level weighted

Interpretation: For each Eligible Clinician (EC), percentage of patients who received preventive services, which gives EC partial numerator credit for meeting the criteria for some but not all components of the measure.

[Preventive Care and Wellness (Component-level weighted)](Measure-PreventiveCareandWellnessWeightedComposite.html)
</div>
