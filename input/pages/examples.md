

### Examples

* [**Simple Example**](Measure-EXMLogic-FHIR.html) Usage example illustrating all the common data elements of the CQF Measure profile - [Library](Library-EXMLogic-FHIR.html)
* [**EXM146**](Measure-EXM146-FHIR.html) Encounter-based proportion measure example - [Library](Library-EXM146-FHIR.html)
* [**EXM55**](Measure-EXM55-FHIR.html) Continuous-variable measure example - [Library](Library-EXM55-FHIR.html)
* [**RatioMeasure**](Measure-EXMRatio-FHIR.html) Ratio measure example - [Library](Library-EXMRatio-FHIR.html)
* [**Terminology**](Measure-Terminology-FHIR.html) Example illustrating terminology usage - [Library](Library-Terminology-FHIR.html)
* [**RiskAdjustment**](Measure-measure-risk-adjustment-FHIR2.html) Example illustrating risk adjustment usage - [Library](Library-risk-adjustment-FHIR2.html)
* [**PromotingInteroperabilityMeasure**](Measure-measure-pi-exm.html) Promoting Interoperability measure example <!---  [Library](Library-EXMRatio.html) -->
* [**Common Library**](Library-Common.html) Usage example illustrating a library to share logic between measures
* [**SupplementalDataElements**](Library-SupplementalDataElements.html) Library illustrating common supplemental data elements

### Screening Measures

These examples illustrate patient-based screening measures

* [**EXM124**](Measure-EXM124-FHIR.html) Cervical Cancer Screening - [Library](Library-EXM124-FHIR.html)
* [**EXM125**](Measure-EXM125-FHIR.html) Breast Cancer Screening - [Library](Library-EXM125-FHIR.html)
* [**EXM130**](Measure-EXM130-FHIR.html) Colorectal Cancer Screening - [Library](Library-EXM130-FHIR.html)

### Hospital Measures

* [**EXM108**](Measure-EXM108-FHIR.html) Venous Thromboembolism Prophylaxis - [Library](Library-EXM108-FHIR.html)

### Additional Supplemental Data Elements Measures

* [**NHSN Glycemic Control: Hyperglycemic Initial Population**](Bundle-sde-example-artifact-bundle.html) Example illustrating the use of supplemental data to gather additional information about a cohort. See the Data Exchange for Quality Measures IG for an example of the MeasureReport that results from this measure.

### Multiple-Rate Measures

* [**Multirate Example**](Measure-MultiRateExample-FHIR.html) Example measure illustrating multiple rates in a single Measure resource - [Library](Library-MultiRateExample-FHIR.html)

### Composite Measures

This section provides examples of all four composite measure scoring methods described by this implementation guide. Each composite is constructed using the same five component measures:

* [Breast Cancer Screening (BCS)](Measure-BCSComponent.html) - Patient-based proportion measure
* [Colorectal Cancer Screening (CCS)](Measure-EXM130-FHIR.html) - Patient-based proportion measure
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

### Test Case examples

The sections provide examples of test cases

* [Simple Test Case](MeasureReport-testcase-example.html) - Example test case illustrating expected input parameters and expected output results given those input parameters.
* [Bundled Test Case](Bundle-bundle-example.html) - Example test case in a bundle illustrating expected input parameters and expected output results given those input parameters along with evaluatedResources.

