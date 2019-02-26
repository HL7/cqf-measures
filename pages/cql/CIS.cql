/*
Childhood Immunization Screening (CIS)
*/

library CIS_FHIR version '1.0.1'
//using FHIR version '3.0.1'
using FHIR version '3.0.0'

/*
Description
Percentage of children 2 years of age who had four diphtheria, tetanus and acellular pertussis (DTaP); three polio (IPV), one measles, mumps and rubella (MMR); three H influenza type B (HiB); three hepatitis B (Hep B); one chicken pox (VZV); four pneumococcal conjugate (PCV); one hepatitis A (Hep A); two or three rotavirus (RV); and two influenza (flu) vaccines by their second birthday
*/

// BTR -> Syntax is incorrect here, suggest pulling this from the actual FHIR library, it looks like it was copied from the Human Readable...
codesystem "CPT": "2.16.840.1.113883.6.12 version 2018"
codesystem "CVX": "2.16.840.1.113883.12.292 version 2017-11"
codesystem "SNOMEDCT": "2.16.840.1.113883.6.96 version 2017-09"
code "Anaphylaxis due to Haemophilus influenzae type b vaccine (disorder)": "SNOMEDCT version 2017-09 Code (433621000124101)"
code "Anaphylaxis due to Hepatitis B vaccine (disorder)": "SNOMEDCT version 2017-09 Code (428321000124101)"
code "Anaphylaxis due to rotavirus vaccine (disorder)": "SNOMEDCT version 2017-09 Code (428331000124103)"
code "Discharge to healthcare facility for hospice care (procedure)": "SNOMEDCT version 2017-09 Code (428371000124100)"
code "Discharge to home for hospice care (procedure)": "SNOMEDCT version 2017-09 Code (428361000124107)"
code "Influenza virus vaccine adverse reaction (disorder)": "SNOMEDCT version 2017-09 Code (420113004)"
code "Neomycin adverse reaction (disorder)": "SNOMEDCT version 2017-09 Code (292927007)"
code "Pneumococcal vaccine adverse reaction (disorder)": "SNOMEDCT version 2017-09 Code (293116002)"
code "Poliomyelitis vaccine adverse reaction (disorder)": "SNOMEDCT version 2017-09 Code (293117006)"
code "Polymyxin B adverse reaction (disorder)": "SNOMEDCT version 2017-09 Code (292992006)"
code "Rotavirus vaccine, human, attenuated (RV1), 2 dose schedule, live, for oral use": "CPT version 2018 Code (90681)"
code "Rotavirus vaccine, pentavalent (RV5), 3 dose schedule, live, for oral use": "CPT version 2018 Code (90680)"
code "rotavirus, live, monovalent vaccine": "CVX version 2017-11 Code (119)"
code "Streptomycin adverse reaction (disorder)": "SNOMEDCT version 2017-09 Code (292925004)"
valueset "Anaphylactic Reaction to Common Baker's Yeast": "2.16.840.1.113883.3.464.1003.199.12.1032"
valueset "Anaphylactic Reaction to DTaP Vaccine": "2.16.840.1.113883.3.464.1003.199.12.1031"
valueset "Anaphylactic Reaction to Hepatitis A Vaccine": "2.16.840.1.113883.3.464.1003.199.12.1026"
valueset "Anti Hepatitis A IgG Antigen Test": "2.16.840.1.113883.3.464.1003.198.12.1033"
valueset "Anti Hepatitis B Virus Surface Ab": "2.16.840.1.113883.3.464.1003.198.12.1073"
valueset "Disorders of the Immune System": "2.16.840.1.113883.3.464.1003.120.12.1001"
valueset "DTaP Vaccine Administered": "2.16.840.1.113883.3.464.1003.110.12.1022"
valueset "DTaP Vaccine": "2.16.840.1.113883.3.464.1003.196.12.1214"
valueset "Encephalopathy due to Childhood Vaccination": "2.16.840.1.113883.3.464.1003.114.12.1007"
valueset "Encounter Inpatient": "2.16.840.1.113883.3.666.5.307"
valueset "Ethnicity": "2.16.840.1.114222.4.11.837"
valueset "Haemophilus Influenzae Type B (HiB) Vaccine Administered": "2.16.840.1.113883.3.464.1003.110.12.1043"
valueset "Haemophilus Influenzae Type B (HiB) Vaccine": "2.16.840.1.113883.3.464.1003.196.12.1217"
valueset "Hepatitis A Vaccine Administered": "2.16.840.1.113883.3.464.1003.110.12.1041"
valueset "Hepatitis A Vaccine": "2.16.840.1.113883.3.464.1003.196.12.1215"
valueset "Hepatitis A": "2.16.840.1.113883.3.464.1003.110.12.1024"
valueset "Hepatitis B Vaccine Administered": "2.16.840.1.113883.3.464.1003.110.12.1042"
valueset "Hepatitis B Vaccine": "2.16.840.1.113883.3.464.1003.196.12.1216"
valueset "Hepatitis B": "2.16.840.1.113883.3.464.1003.110.12.1025"
valueset "HIV": "2.16.840.1.113883.3.464.1003.120.12.1003"
valueset "Home Healthcare Services": "2.16.840.1.113883.3.464.1003.101.12.1016"
valueset "Hospice care ambulatory": "2.16.840.1.113762.1.4.1108.15"
valueset "Inactivated Polio Vaccine (IPV) Administered": "2.16.840.1.113883.3.464.1003.110.12.1045"
valueset "Inactivated Polio Vaccine (IPV)": "2.16.840.1.113883.3.464.1003.196.12.1219"
valueset "Influenza Vaccine Administered": "2.16.840.1.113883.3.464.1003.110.12.1044"
valueset "Influenza Vaccine": "2.16.840.1.113883.3.464.1003.196.12.1218"
valueset "Intussusception": "2.16.840.1.113883.3.464.1003.199.12.1056"
valueset "Malignant Neoplasm of Lymphatic and Hematopoietic Tissue": "2.16.840.1.113883.3.464.1003.108.12.1009"
valueset "Measles Antibody Test (IgG Antibody presence)": "2.16.840.1.113883.3.464.1003.198.12.1060"
valueset "Measles Antibody Test (IgG Antibody Titer)": "2.16.840.1.113883.3.464.1003.198.12.1059"
valueset "Measles": "2.16.840.1.113883.3.464.1003.110.12.1053"
valueset "Measles, Mumps and Rubella (MMR) Vaccine Administered": "2.16.840.1.113883.3.464.1003.110.12.1031"
valueset "Measles, Mumps and Rubella (MMR) Vaccine": "2.16.840.1.113883.3.464.1003.196.12.1224"
valueset "Mumps Antibody Test (IgG Antibody presence)": "2.16.840.1.113883.3.464.1003.198.12.1062"
valueset "Mumps Antibody Test (IgG Antibody Titer)": "2.16.840.1.113883.3.464.1003.198.12.1061"
valueset "Mumps": "2.16.840.1.113883.3.464.1003.110.12.1032"
valueset "Office Visit": "2.16.840.1.113883.3.464.1003.101.12.1001"
valueset "ONC Administrative Sex": "2.16.840.1.113762.1.4.1"
valueset "Payer": "2.16.840.1.114222.4.11.3591"
valueset "Pneumococcal Conjugate Vaccine Administered": "2.16.840.1.113883.3.464.1003.110.12.1046"
valueset "Pneumococcal Conjugate Vaccine": "2.16.840.1.113883.3.464.1003.196.12.1221"
valueset "Positive Finding": "2.16.840.1.113883.3.464.1003.121.12.1016"
valueset "Preventive Care Services, Initial Office Visit, 0 to 17": "2.16.840.1.113883.3.464.1003.101.12.1022"
valueset "Preventive Care, Established Office Visit, 0 to 17": "2.16.840.1.113883.3.464.1003.101.12.1024"
valueset "Race": "2.16.840.1.114222.4.11.836"
valueset "Rotavirus Vaccine (3 dose schedule)": "2.16.840.1.113883.3.464.1003.196.12.1223"
valueset "Rubella Antibody Test (IgG Antibody presence)": "2.16.840.1.113883.3.464.1003.198.12.1064"
valueset "Rubella Antibody Test (IgG Antibody Titer)": "2.16.840.1.113883.3.464.1003.198.12.1063"
valueset "Rubella": "2.16.840.1.113883.3.464.1003.110.12.1037"
valueset "Severe Combined Immunodeficiency": "2.16.840.1.113883.3.464.1003.120.12.1007"
valueset "Varicella Zoster Antibody Test (IgG Antibody Presence)": "2.16.840.1.113883.3.464.1003.198.12.1067"
valueset "Varicella Zoster Antibody Test (IgG Antibody Titer)": "2.16.840.1.113883.3.464.1003.198.12.1066"
valueset "Varicella Zoster Vaccine (VZV) Administered": "2.16.840.1.113883.3.464.1003.110.12.1040"
valueset "Varicella Zoster Vaccine (VZV)": "2.16.840.1.113883.3.464.1003.196.12.1170"
valueset "Varicella Zoster": "2.16.840.1.113883.3.464.1003.110.12.1039"
Data Criteria (QDM Data Elements)
"Diagnosis: Anaphylactic Reaction to Common Baker's Yeast": "Anaphylactic Reaction to Common Baker's Yeast (2.16.840.1.113883.3.464.1003.199.12.1032)"
"Diagnosis: Anaphylactic Reaction to DTaP Vaccine": "Anaphylactic Reaction to DTaP Vaccine (2.16.840.1.113883.3.464.1003.199.12.1031)"
"Diagnosis: Anaphylactic Reaction to Hepatitis A Vaccine": "Anaphylactic Reaction to Hepatitis A Vaccine (2.16.840.1.113883.3.464.1003.199.12.1026)"
"Diagnosis: Disorders of the Immune System": "Disorders of the Immune System (2.16.840.1.113883.3.464.1003.120.12.1001)"
"Diagnosis: Encephalopathy due to Childhood Vaccination": "Encephalopathy due to Childhood Vaccination (2.16.840.1.113883.3.464.1003.114.12.1007)"
"Diagnosis: Hepatitis A": "Hepatitis A (2.16.840.1.113883.3.464.1003.110.12.1024)"
"Diagnosis: Hepatitis B": "Hepatitis B (2.16.840.1.113883.3.464.1003.110.12.1025)"
"Diagnosis: HIV": "HIV (2.16.840.1.113883.3.464.1003.120.12.1003)"
"Diagnosis: Intussusception": "Intussusception (2.16.840.1.113883.3.464.1003.199.12.1056)"
"Diagnosis: Malignant Neoplasm of Lymphatic and Hematopoietic Tissue": "Malignant Neoplasm of Lymphatic and Hematopoietic Tissue (2.16.840.1.113883.3.464.1003.108.12.1009)"
"Diagnosis: Measles": "Measles (2.16.840.1.113883.3.464.1003.110.12.1053)"
"Diagnosis: Mumps": "Mumps (2.16.840.1.113883.3.464.1003.110.12.1032)"
"Diagnosis: Rubella": "Rubella (2.16.840.1.113883.3.464.1003.110.12.1037)"
"Diagnosis: Severe Combined Immunodeficiency": "Severe Combined Immunodeficiency (2.16.840.1.113883.3.464.1003.120.12.1007)"
"Diagnosis: Varicella Zoster": "Varicella Zoster (2.16.840.1.113883.3.464.1003.110.12.1039)"
"Encounter, Performed: Encounter Inpatient": "Encounter Inpatient (2.16.840.1.113883.3.666.5.307)"
"Encounter, Performed: Home Healthcare Services": "Home Healthcare Services (2.16.840.1.113883.3.464.1003.101.12.1016)"
"Encounter, Performed: Office Visit": "Office Visit (2.16.840.1.113883.3.464.1003.101.12.1001)"
"Encounter, Performed: Preventive Care Services, Initial Office Visit, 0 to 17": "Preventive Care Services, Initial Office Visit, 0 to 17 (2.16.840.1.113883.3.464.1003.101.12.1022)"
"Encounter, Performed: Preventive Care, Established Office Visit, 0 to 17": "Preventive Care, Established Office Visit, 0 to 17 (2.16.840.1.113883.3.464.1003.101.12.1024)"
"Immunization, Administered: DTaP Vaccine": "DTaP Vaccine (2.16.840.1.113883.3.464.1003.196.12.1214)"
"Immunization, Administered: Haemophilus Influenzae Type B (HiB) Vaccine": "Haemophilus Influenzae Type B (HiB) Vaccine (2.16.840.1.113883.3.464.1003.196.12.1217)"
"Immunization, Administered: Hepatitis A Vaccine": "Hepatitis A Vaccine (2.16.840.1.113883.3.464.1003.196.12.1215)"
"Immunization, Administered: Hepatitis B Vaccine": "Hepatitis B Vaccine (2.16.840.1.113883.3.464.1003.196.12.1216)"
"Immunization, Administered: Inactivated Polio Vaccine (IPV)": "Inactivated Polio Vaccine (IPV) (2.16.840.1.113883.3.464.1003.196.12.1219)"
"Immunization, Administered: Influenza Vaccine": "Influenza Vaccine (2.16.840.1.113883.3.464.1003.196.12.1218)"
"Immunization, Administered: Measles, Mumps and Rubella (MMR) Vaccine": "Measles, Mumps and Rubella (MMR) Vaccine (2.16.840.1.113883.3.464.1003.196.12.1224)"
"Immunization, Administered: Pneumococcal Conjugate Vaccine": "Pneumococcal Conjugate Vaccine (2.16.840.1.113883.3.464.1003.196.12.1221)"
"Immunization, Administered: Rotavirus Vaccine (3 dose schedule)": "Rotavirus Vaccine (3 dose schedule) (2.16.840.1.113883.3.464.1003.196.12.1223)"
"Immunization, Administered: Varicella Zoster Vaccine (VZV)": "Varicella Zoster Vaccine (VZV) (2.16.840.1.113883.3.464.1003.196.12.1170)"
"Intervention, Order: Hospice care ambulatory": "Hospice care ambulatory (2.16.840.1.113762.1.4.1108.15)"
"Intervention, Performed: Hospice care ambulatory": "Hospice care ambulatory (2.16.840.1.113762.1.4.1108.15)"
"Laboratory Test, Performed: Anti Hepatitis A IgG Antigen Test": "Anti Hepatitis A IgG Antigen Test (2.16.840.1.113883.3.464.1003.198.12.1033)"
"Laboratory Test, Performed: Anti Hepatitis B Virus Surface Ab": "Anti Hepatitis B Virus Surface Ab (2.16.840.1.113883.3.464.1003.198.12.1073)"
"Laboratory Test, Performed: Measles Antibody Test (IgG Antibody presence)": "Measles Antibody Test (IgG Antibody presence) (2.16.840.1.113883.3.464.1003.198.12.1060)"
"Laboratory Test, Performed: Measles Antibody Test (IgG Antibody Titer)": "Measles Antibody Test (IgG Antibody Titer) (2.16.840.1.113883.3.464.1003.198.12.1059)"
"Laboratory Test, Performed: Mumps Antibody Test (IgG Antibody presence)": "Mumps Antibody Test (IgG Antibody presence) (2.16.840.1.113883.3.464.1003.198.12.1062)"
"Laboratory Test, Performed: Mumps Antibody Test (IgG Antibody Titer)": "Mumps Antibody Test (IgG Antibody Titer) (2.16.840.1.113883.3.464.1003.198.12.1061)"
"Laboratory Test, Performed: Rubella Antibody Test (IgG Antibody presence)": "Rubella Antibody Test (IgG Antibody presence) (2.16.840.1.113883.3.464.1003.198.12.1064)"
"Laboratory Test, Performed: Rubella Antibody Test (IgG Antibody Titer)": "Rubella Antibody Test (IgG Antibody Titer) (2.16.840.1.113883.3.464.1003.198.12.1063)"
"Laboratory Test, Performed: Varicella Zoster Antibody Test (IgG Antibody Presence)": "Varicella Zoster Antibody Test (IgG Antibody Presence) (2.16.840.1.113883.3.464.1003.198.12.1067)"
"Laboratory Test, Performed: Varicella Zoster Antibody Test (IgG Antibody Titer)": "Varicella Zoster Antibody Test (IgG Antibody Titer) (2.16.840.1.113883.3.464.1003.198.12.1066)"
"Patient Characteristic Ethnicity: Ethnicity": "Ethnicity (2.16.840.1.114222.4.11.837)"
"Patient Characteristic Payer: Payer": "Payer (2.16.840.1.114222.4.11.3591)"
"Patient Characteristic Race: Race": "Race (2.16.840.1.114222.4.11.836)"
"Patient Characteristic Sex: ONC Administrative Sex": "ONC Administrative Sex (2.16.840.1.113762.1.4.1)"
"Procedure, Performed: DTaP Vaccine Administered": "DTaP Vaccine Administered (2.16.840.1.113883.3.464.1003.110.12.1022)"
"Procedure, Performed: Haemophilus Influenzae Type B (HiB) Vaccine Administered": "Haemophilus Influenzae Type B (HiB) Vaccine Administered (2.16.840.1.113883.3.464.1003.110.12.1043)"
"Procedure, Performed: Hepatitis A Vaccine Administered": "Hepatitis A Vaccine Administered (2.16.840.1.113883.3.464.1003.110.12.1041)"
"Procedure, Performed: Hepatitis B Vaccine Administered": "Hepatitis B Vaccine Administered (2.16.840.1.113883.3.464.1003.110.12.1042)"
"Procedure, Performed: Inactivated Polio Vaccine (IPV) Administered": "Inactivated Polio Vaccine (IPV) Administered (2.16.840.1.113883.3.464.1003.110.12.1045)"
"Procedure, Performed: Influenza Vaccine Administered": "Influenza Vaccine Administered (2.16.840.1.113883.3.464.1003.110.12.1044)"
"Procedure, Performed: Measles, Mumps and Rubella (MMR) Vaccine Administered": "Measles, Mumps and Rubella (MMR) Vaccine Administered (2.16.840.1.113883.3.464.1003.110.12.1031)"
"Procedure, Performed: Pneumococcal Conjugate Vaccine Administered": "Pneumococcal Conjugate Vaccine Administered (2.16.840.1.113883.3.464.1003.110.12.1046)"
"Procedure, Performed: Varicella Zoster Vaccine (VZV) Administered": "Varicella Zoster Vaccine (VZV) Administered (2.16.840.1.113883.3.464.1003.110.12.1040)"
"Diagnosis: Anaphylaxis due to Haemophilus influenzae type b vaccine (disorder)": "Anaphylaxis due to Haemophilus influenzae type b vaccine (disorder) (SNOMEDCT version 2017-09 Code 433621000124101)"
"Diagnosis: Anaphylaxis due to Hepatitis B vaccine (disorder)": "Anaphylaxis due to Hepatitis B vaccine (disorder) (SNOMEDCT version 2017-09 Code 428321000124101)"
"Diagnosis: Anaphylaxis due to rotavirus vaccine (disorder)": "Anaphylaxis due to rotavirus vaccine (disorder) (SNOMEDCT version 2017-09 Code 428331000124103)"
"Diagnosis: Influenza virus vaccine adverse reaction (disorder)": "Influenza virus vaccine adverse reaction (disorder) (SNOMEDCT version 2017-09 Code 420113004)"
"Diagnosis: Neomycin adverse reaction (disorder)": "Neomycin adverse reaction (disorder) (SNOMEDCT version 2017-09 Code 292927007)"
"Diagnosis: Pneumococcal vaccine adverse reaction (disorder)": "Pneumococcal vaccine adverse reaction (disorder) (SNOMEDCT version 2017-09 Code 293116002)"
"Diagnosis: Poliomyelitis vaccine adverse reaction (disorder)": "Poliomyelitis vaccine adverse reaction (disorder) (SNOMEDCT version 2017-09 Code 293117006)"
"Diagnosis: Polymyxin B adverse reaction (disorder)": "Polymyxin B adverse reaction (disorder) (SNOMEDCT version 2017-09 Code 292992006)"
"Diagnosis: Streptomycin adverse reaction (disorder)": "Streptomycin adverse reaction (disorder) (SNOMEDCT version 2017-09 Code 292925004)"
"Immunization, Administered: rotavirus, live, monovalent vaccine": "rotavirus, live, monovalent vaccine (CVX version 2017-11 Code 119)"
"Procedure, Performed: Rotavirus vaccine, human, attenuated (RV1), 2 dose schedule, live, for oral use": "Rotavirus vaccine, human, attenuated (RV1), 2 dose schedule, live, for oral use (CPT version 2018 Code 90681)"
"Procedure, Performed: Rotavirus vaccine, pentavalent (RV5), 3 dose schedule, live, for oral use": "Rotavirus vaccine, pentavalent (RV5), 3 dose schedule, live, for oral use (CPT version 2018 Code 90680)"

/*
This library has an explicit parameter which is the measurement year.
While the actual parameter's type accepts all intervals, this library
expects it will only be given arguments corresponding exactly to one whole
calendar year, and it will not behave properly otherwise; 2017 for example:
Interval[DateTime(2017,1,1,0,0,0,0), DateTime(2018,1,1,0,0,0,0))
*/

parameter "Measurement Period" Interval<DateTime>

/*
This library evaluates with respect to exactly 1 candidate patient at a time,
that patient being given by the special context parameter Patient.
*/

context Patient

/*
Initial Population
*/

// BTR -> In FHIR, you can just say:
define "Initial Population":
  Global.CalendarAgeInYearsAt(Patient.birthDate, start of "Measurement Period") >= 1
    and Global.CalendarAgeInYearsAt(Patient.birthDate, end of "Measurement Period") = 2
//	exists ( ["Patient.birthDate.value"] BirthDate
//			where Global."CalendarAgeInYearsAt"(Patient.birthDate.value, start of "Measurement Period")>= 1
//				and Global."CalendarAgeInYearsAt"(Patient.birthDate.value, end of "Measurement Period")= 2
//	)
		and exists ( "Qualifying Encounter" )
//		and (not "Is In Hospice")
  

define "Denominator":
	// was "Initial Population", but that will always be true if this expression is executed
    true

  

define "Numerator"
	
	( exists ( "Four DTaP Vaccinations" )
			or exists ( "DTaP Numerator Inclusion Conditions" )
	)
		and ( exists ( "Three Polio Vaccinations" )
				or exists ( "Polio Numerator Inclusion Conditions" )
		)
		and ( exists ( "One MMR Vaccinations" )
				or exists ( "MMR Numerator Inclusion Conditions" )
				or ( exists ( "Measles Indicators" )
						and exists ( "Mumps Indicators" )
						and exists ( "Rubella Indicators" )
				)
		)
		and ( exists ( "Three Hib Vaccinations" )
				or exists ( "Hib Numerator Inclusion Conditions" )
		)
		and ( exists ( "Three Hepatitis B Vaccinations" )
				or exists ( "Hepatitis B Numerator Inclusion Conditions" )
		)
		and ( exists ( "One Chicken Pox Vaccination" )
				or exists ( "Varicella Zoster Numerator Inclusion Conditions" )
		)
		and ( exists ( "Four Pneumococcal Conjugate Vaccinations" )
				or exists ( "Pneumococcal Conjugate Numerator Inclusion Conditions" )
		)
		and ( exists ( "One Hepatitis A Vaccinations" )
				or exists ( "Hepatitis A Numerator Inclusion Conditions" )
		)
		and ( exists ( "Rotavirus 2 Dose Vaccinations" )
				or exists ( "Rotavirus Numerator Inclusion Conditions" )
				or exists ( "Rotavirus 2 or 3 Dose Vaccinations" )
				or exists ( "Rotavirus 3 Dose Vaccinations" )
		)
		and ( exists ( "Two Influenza Vaccinations" )
				or exists ( "Influenza Numerator Inclusion Conditions" "Numerator Compliant Influenza Conditions" )
		)

/* Why is this commented out??
// BTR -> Because it should just be referenced in the Hospice library, no need to repeat it here
define "Is In Hospice":
	exists(
		[Encounter: "Hospice Value Set"] Enc
			where Enc.status.value in { 'planned', 'arrived', 'triaged', 'in-progress', 'onleave', 'finished' }
				and PeriodToIntervalOfDT(Enc.period) overlaps day of "Measurement Period"
	)
	or
	exists(
		[Claim: "Hospice Value Set"] Clm
			where Clm.status.value in { 'active', 'draft' }
				and PeriodToIntervalOfDT(Clm.item.service.period) overlaps day of "Measurement Period"
	)
	or
	exists(
		[Encounter: "Encounter Inpatient"] DischargeHospice
			where DischargeHospice.status.value in { 'planned', 'arrived', 'triaged', 'in-progress', 'onleave', 'finished' }
				and (CodingToCode(DischargeHospice.hospitalization.dischargeDisposition.coding)
						in "Discharged to Home for Hospice Care"
					or CodingToCode(DischargeHospice.hospitalization.dischargeDisposition.coding)
						in "Discharged to Health Care Facility for Hospice Care")
				and PeriodToIntervalOfDT(DischargeHospice.period) ends during day of "Measurement Period"
	)
	or
	exists(
		[ProcedureRequest: "Hospice care ambulatory"] HospiceOrder
			where HospiceOrder.status.value in { 'active', 'completed' }
				and HospiceOrder.authoredOn.value during "Measurement Period"
	)
	or
	exists(
		[Procedure: "Hospice care ambulatory"] HospicePerformed
			where HospicePerformed.status.value in { 'preparation', 'in-progress', 'suspended', 'aborted', 'completed' }
				and date form PeriodToIntervalOfDT(HospicePerformed.performed) overlaps day of "Measurement Period"
	)
*/



  
define "DTaP Immunizations or Procedures" 
	
	( ["Immunization:"DTaP Vaccine"] DTaP
				where DTaP.status.value = 'completed' )
	
/* Do we still need this?
BTR -> FHIR specifically says Procedure should NOT be used to record vaccine administration since the more specific Immunization procedure exists.
Note that it's a SHOULD, not a SHALL, so it's possible systems may still do this, but I'd suggest going with just Immunization until there is a demonstrated need
		union [Procedure: "DTaP Vaccine Administered"] DtapAdministration
            where Proc.status.value = 'completed'
				return {immunization.date: start of performed.date }
		 ) DTaPVaccination
*/
		with ["Patient.birthDate.value"] BirthDate
			such that ( Global."CalendarAgeInDaysAt"(Patient.birthDate.value, DTaPVaccination.date)>= 42 )
				and ( Global."CalendarAgeInDaysAt"(Patient.birthDate.value, DTaPVaccination.date)<= 730 )
				
//Start Here

  
o	 DTaP Numerator Inclusion Conditions 
	
	( ["Diagnosis": "Anaphylactic Reaction to DTaP Vaccine"]
		union ["Diagnosis": "Encephalopathy due to Childhood Vaccination"] ) DTaPConditions
		with ["Patient Characteristic Birthdate"] BirthDate
			such that ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, DTaPConditions.authorDatetime)<= 730 )
  
o	 Four DTaP Vaccinations 
	
	from
		"DTaP Immunizations or Procedures" DTaPVaccination1,
		"DTaP Immunizations or Procedures" DTaPVaccination2,
		"DTaP Immunizations or Procedures" DTaPVaccination3,
		"DTaP Immunizations or Procedures" DTaPVaccination4
		where DTaPVaccination2.authorDatetime 1 day or more after day of DTaPVaccination1.authorDatetime
			and DTaPVaccination3.authorDatetime 1 day or more after day of DTaPVaccination2.authorDatetime
			and DTaPVaccination4.authorDatetime 1 day or more after day of DTaPVaccination3.authorDatetime
		return DTaPVaccination1
  
o	 Four Pneumococcal Conjugate Vaccinations 
	
	from
		"Pneumococcal Conjugate Immunizations or Procedures" PneumococcalVaccination1,
		"Pneumococcal Conjugate Immunizations or Procedures" PneumococcalVaccination2,
		"Pneumococcal Conjugate Immunizations or Procedures" PneumococcalVaccination3,
		"Pneumococcal Conjugate Immunizations or Procedures" PneumococcalVaccination4
		where PneumococcalVaccination2.authorDatetime 1 day or more after day of PneumococcalVaccination1.authorDatetime
			and PneumococcalVaccination3.authorDatetime 1 day or more after day of PneumococcalVaccination2.authorDatetime
			and PneumococcalVaccination4.authorDatetime 1 day or more after day of PneumococcalVaccination3.authorDatetime
		return PneumococcalVaccination1
  
o	 Hepatitis A Numerator Inclusion Conditions 
	
	( ( ["Laboratory Test, Performed": "Anti Hepatitis A IgG Antigen Test"] HepatitisAAntigenTest
			where HepatitisAAntigenTest.result as Code in "Positive Finding"
	)
		union ( ["Diagnosis": "Anaphylactic Reaction to Hepatitis A Vaccine"] HepatitisAReaction
				return "Laboratory Test, Performed" { authorDatetime: start of HepatitisAReaction.prevalencePeriod }
		)
		union ( ["Diagnosis": "Hepatitis A"] HepatitisADiagnosis
				return "Laboratory Test, Performed" { authorDatetime: start of HepatitisADiagnosis.prevalencePeriod }
		) ) HepatitisAConditions
		with ["Patient Characteristic Birthdate"] BirthDate
			such that ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, HepatitisAConditions.authorDatetime)<= 730 )
  
o	 Hepatitis B Immunizations or Procedures 
	
	( ["Immunization, Administered": "Hepatitis B Vaccine"]
		union ( ["Procedure, Performed": "Hepatitis B Vaccine Administered"] HepatitisBAdministration
				return "Immunization, Administered" { authorDatetime: start of HepatitisBAdministration.relevantPeriod }
		) ) HepatitisBVaccination
		with ["Patient Characteristic Birthdate"] BirthDate
			such that Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, HepatitisBVaccination.authorDatetime)<= 730
  
o	 Hepatitis B Numerator Inclusion Conditions 
	
	( ( ["Laboratory Test, Performed": "Anti Hepatitis B Virus Surface Ab"] HepatitisBAntigenTest
			where HepatitisBAntigenTest.result as Code in "Positive Finding"
	)
		union ( ["Diagnosis": "Anaphylaxis due to Hepatitis B vaccine (disorder)"] HepatitisBReaction
				return "Laboratory Test, Performed" { authorDatetime: start of HepatitisBReaction.prevalencePeriod }
		)
		union ( ["Diagnosis": "Anaphylactic Reaction to Common Baker's Yeast"] YeastReaction
				return "Laboratory Test, Performed" { authorDatetime: start of YeastReaction.prevalencePeriod }
		)
		union ( ["Diagnosis": "Hepatitis B"] HepatitisBDiagnosis
				return "Laboratory Test, Performed" { authorDatetime: start of HepatitisBDiagnosis.prevalencePeriod }
		) ) HepBConditions
		with ["Patient Characteristic Birthdate"] BirthDate
			such that ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, HepBConditions.authorDatetime)<= 730 )
  
o	 Hib Immunizations or Procedures 
	
	( ["Immunization, Administered": "Haemophilus Influenzae Type B (HiB) Vaccine"]
		union ( ["Procedure, Performed": "Haemophilus Influenzae Type B (HiB) Vaccine Administered"] HibAdministration
				return "Immunization, Administered" { authorDatetime: start of HibAdministration.relevantPeriod }
		) ) HibVaccination
		with ["Patient Characteristic Birthdate"] BirthDate
			such that ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, HibVaccination.authorDatetime)>= 42 )
				and ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, HibVaccination.authorDatetime)<= 730 )
  
o	 Hib Numerator Inclusion Conditions 
	
	["Diagnosis": "Anaphylaxis due to Haemophilus influenzae type b vaccine (disorder)"] HibReaction
		with ["Patient Characteristic Birthdate"] BirthDate
			such that Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, start of HibReaction.prevalencePeriod)<= 730
  
o	 Hospice.Has Hospice 
	
	exists ( ["Encounter, Performed": "Encounter Inpatient"] DischargeHospice
			where ( DischargeHospice.dischargeDisposition as Code ~ "Discharge to home for hospice care (procedure)"
					or DischargeHospice.dischargeDisposition as Code ~ "Discharge to healthcare facility for hospice care (procedure)"
			)
				and DischargeHospice.relevantPeriod ends during "Measurement Period"
	)
		or exists ( ["Intervention, Order": "Hospice care ambulatory"] HospiceOrder
				where HospiceOrder.authorDatetime during "Measurement Period"
		)
		or exists ( ["Intervention, Performed": "Hospice care ambulatory"] HospicePerformed
				where HospicePerformed.relevantPeriod overlaps "Measurement Period"
		)
  
o	 Influenza Immunizations or Procedures 
	
	( ["Immunization, Administered": "Influenza Vaccine"]
		union ( ["Procedure, Performed": "Influenza Vaccine Administered"] InfluenzaAdministration
				return "Immunization, Administered" { authorDatetime: start of InfluenzaAdministration.relevantPeriod }
		) ) InfluenzaVaccination
		with ["Patient Characteristic Birthdate"] BirthDate
			such that ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, InfluenzaVaccination.authorDatetime)>= 180 )
				and ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, InfluenzaVaccination.authorDatetime)<= 730 )
  
o	 Influenza Numerator Inclusion Conditions 
	
	( ["Diagnosis": "Influenza virus vaccine adverse reaction (disorder)"]
		union ["Diagnosis": "Malignant Neoplasm of Lymphatic and Hematopoietic Tissue"]
		union ["Diagnosis": "Neomycin adverse reaction (disorder)"]
		union ["Diagnosis": "HIV"]
		union ["Diagnosis": "Disorders of the Immune System"] ) InfluenzaConditions
		with ["Patient Characteristic Birthdate"] BirthDate
			such that Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, start of InfluenzaConditions.prevalencePeriod)<= 730
  
o	 Initial Population 
	
	exists ( ["Patient Characteristic Birthdate"] BirthDate
			where Global."CalendarAgeInYearsAt"(BirthDate.birthDatetime, start of "Measurement Period")>= 1
				and Global."CalendarAgeInYearsAt"(BirthDate.birthDatetime, end of "Measurement Period")= 2
	)
		and exists ( "Qualifying Encounter" )
  
o	 Measles Indicators 
	
	( ( ["Laboratory Test, Performed": "Measles Antibody Test (IgG Antibody Titer)"] MeaslesTiter
			where MeaslesTiter.result >= 1.10
	)
		union ( ["Laboratory Test, Performed": "Measles Antibody Test (IgG Antibody presence)"] MeaslesIgGPresence
				where MeaslesIgGPresence.result as Code in "Positive Finding"
		)
		union ( ["Diagnosis": "Measles"] MeaslesDiagnosis
				return "Laboratory Test, Performed" { authorDatetime: start of MeaslesDiagnosis.prevalencePeriod }
		) ) Measles
		with ["Patient Characteristic Birthdate"] BirthDate
			such that Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, Measles.authorDatetime)<= 730
  
o	 MMR Numerator Inclusion Conditions 
	
	( ["Diagnosis": "Disorders of the Immune System"]
		union ["Diagnosis": "HIV"]
		union ["Diagnosis": "Malignant Neoplasm of Lymphatic and Hematopoietic Tissue"]
		union ["Diagnosis": "Neomycin adverse reaction (disorder)"] ) MMRConditions
		with ["Patient Characteristic Birthdate"] BirthDate
			such that Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, start of MMRConditions.prevalencePeriod)<= 730
  
o	 Mumps Indicators 
	
	( ( ["Laboratory Test, Performed": "Mumps Antibody Test (IgG Antibody Titer)"] MumpsTiter
			where MumpsTiter.result >= 1.10
	)
		union ( ["Laboratory Test, Performed": "Mumps Antibody Test (IgG Antibody presence)"] MumpsIgGPresence
				where MumpsIgGPresence.result as Code in "Positive Finding"
		)
		union ( ["Diagnosis": "Mumps"] MumpsDiagnosis
				return "Laboratory Test, Performed" { authorDatetime: start of MumpsDiagnosis.prevalencePeriod }
		) ) Mumps
		with ["Patient Characteristic Birthdate"] BirthDate
			such that Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, Mumps.authorDatetime)<= 730
  
o	 Numerator 
	
	( exists ( "Four DTaP Vaccinations" )
			or exists ( "DTaP Numerator Inclusion Conditions" )
	)
		and ( exists ( "Three Polio Vaccinations" )
				or exists ( "Polio Numerator Inclusion Conditions" )
		)
		and ( exists ( "One MMR Vaccinations" )
				or exists ( "MMR Numerator Inclusion Conditions" )
				or ( exists ( "Measles Indicators" )
						and exists ( "Mumps Indicators" )
						and exists ( "Rubella Indicators" )
				)
		)
		and ( exists ( "Three Hib Vaccinations" )
				or exists ( "Hib Numerator Inclusion Conditions" )
		)
		and ( exists ( "Three Hepatitis B Vaccinations" )
				or exists ( "Hepatitis B Numerator Inclusion Conditions" )
		)
		and ( exists ( "One Chicken Pox Vaccination" )
				or exists ( "Varicella Zoster Numerator Inclusion Conditions" )
		)
		and ( exists ( "Four Pneumococcal Conjugate Vaccinations" )
				or exists ( "Pneumococcal Conjugate Numerator Inclusion Conditions" )
		)
		and ( exists ( "One Hepatitis A Vaccinations" )
				or exists ( "Hepatitis A Numerator Inclusion Conditions" )
		)
		and ( exists ( "Rotavirus 2 Dose Vaccinations" )
				or exists ( "Rotavirus Numerator Inclusion Conditions" )
				or exists ( "Rotavirus 2 or 3 Dose Vaccinations" )
				or exists ( "Rotavirus 3 Dose Vaccinations" )
		)
		and ( exists ( "Two Influenza Vaccinations" )
				or exists ( "Influenza Numerator Inclusion Conditions" "Numerator Compliant Influenza Conditions" )
		)
  
o	 One Chicken Pox Vaccination 
	
	( ["Immunization, Administered": "Varicella Zoster Vaccine (VZV)"]
		union ( ["Procedure, Performed": "Varicella Zoster Vaccine (VZV) Administered"] ChickenPoxAdministration
				return "Immunization, Administered" { authorDatetime: start of ChickenPoxAdministration.relevantPeriod }
		) ) ChickenPoxVaccination
		with ["Patient Characteristic Birthdate"] BirthDate
			such that Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, ChickenPoxVaccination.authorDatetime)<= 730
  
o	 One Hepatitis A Vaccinations 
	
	( ["Immunization, Administered": "Hepatitis A Vaccine"]
		union ( ["Procedure, Performed": "Hepatitis A Vaccine Administered"] HepatitisAAdministration
				return "Immunization, Administered" { authorDatetime: start of HepatitisAAdministration.relevantPeriod }
		) ) HepatitisAVaccination
		with ["Patient Characteristic Birthdate"] BirthDate
			such that Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, HepatitisAVaccination.authorDatetime)<= 730
  
o	 One MMR Vaccinations 
	
	( ["Immunization, Administered": "Measles, Mumps and Rubella (MMR) Vaccine"]
		union ( ["Procedure, Performed": "Measles, Mumps and Rubella (MMR) Vaccine Administered"] MMRAdministration
				return "Immunization, Administered" { authorDatetime: start of MMRAdministration.relevantPeriod }
		) ) MMRVaccination
		with ["Patient Characteristic Birthdate"] BirthDate
			such that Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, MMRVaccination.authorDatetime)<= 730
  
o	 Pneumococcal Conjugate Immunizations or Procedures 
	
	( ["Immunization, Administered": "Pneumococcal Conjugate Vaccine"]
		union ( ["Procedure, Performed": "Pneumococcal Conjugate Vaccine Administered"] PneumococcalAdministration
				return "Immunization, Administered" { authorDatetime: start of PneumococcalAdministration.relevantPeriod }
		) ) PneumococcalVaccination
		with ["Patient Characteristic Birthdate"] BirthDate
			such that ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, PneumococcalVaccination.authorDatetime)>= 42 )
				and ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, PneumococcalVaccination.authorDatetime)<= 730 )
  
o	 Pneumococcal Conjugate Numerator Inclusion Conditions 
	
	["Diagnosis": "Pneumococcal vaccine adverse reaction (disorder)"] PneumococcalReaction
		with ["Patient Characteristic Birthdate"] BirthDate
			such that Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, start of PneumococcalReaction.prevalencePeriod)<= 730
  
o	 Polio Immunizations or Procedures 
	
	( ["Immunization, Administered": "Inactivated Polio Vaccine (IPV)"]
		union ( ["Procedure, Performed": "Inactivated Polio Vaccine (IPV) Administered"] PolioAdministration
				return "Immunization, Administered" { authorDatetime: start of PolioAdministration.relevantPeriod }
		) ) PolioVaccination
		with ["Patient Characteristic Birthdate"] BirthDate
			such that ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, PolioVaccination.authorDatetime)>= 42 )
				and ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, PolioVaccination.authorDatetime)<= 730 )
  
o	 Polio Numerator Inclusion Conditions 
	
	( ["Diagnosis": "Poliomyelitis vaccine adverse reaction (disorder)"]
		union ["Diagnosis": "Streptomycin adverse reaction (disorder)"]
		union ["Diagnosis": "Polymyxin B adverse reaction (disorder)"]
		union ["Diagnosis": "Neomycin adverse reaction (disorder)"] ) PolioConditions
		with ["Patient Characteristic Birthdate"] BirthDate
			such that Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, start of PolioConditions.prevalencePeriod)<= 730
  
o	 Qualifying Encounter 
	
	( ["Encounter, Performed": "Office Visit"]
		union ["Encounter, Performed": "Home Healthcare Services"]
		union ["Encounter, Performed": "Preventive Care, Established Office Visit, 0 to 17"]
		union ["Encounter, Performed": "Preventive Care Services, Initial Office Visit, 0 to 17"] ) ValidEncounter
		where ValidEncounter.relevantPeriod during "Measurement Period"
  
o	 Rotavirus 2 Dose Immunizations or Procedures 
	
	( ["Immunization, Administered": "rotavirus, live, monovalent vaccine"]
		union ( ["Procedure, Performed": "Rotavirus vaccine, human, attenuated (RV1), 2 dose schedule, live, for oral use"] Rotavirus2Administration
				return "Immunization, Administered" { authorDatetime: start of Rotavirus2Administration.relevantPeriod }
		) ) TwoDoseRotavirus
		with ["Patient Characteristic Birthdate"] BirthDate
			such that ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, TwoDoseRotavirus.authorDatetime)>= 42 )
				and ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, TwoDoseRotavirus.authorDatetime)<= 730 )
  
o	 Rotavirus 2 Dose Vaccination Followed by Two Rotavirus 3 Dose Vaccinations 
	
	from
		"Rotavirus 2 Dose Immunizations or Procedures" Rotavirus233Vaccination1,
		"Rotavirus 3 Dose Immunizations or Procedures" Rotavirus233Vaccination2,
		"Rotavirus 3 Dose Immunizations or Procedures" Rotavirus233Vaccination3
		where Rotavirus233Vaccination2.authorDatetime 1 day or more after day of Rotavirus233Vaccination1.authorDatetime
			and Rotavirus233Vaccination3.authorDatetime 1 day or more after day of Rotavirus233Vaccination2.authorDatetime
		return Rotavirus233Vaccination1
  
o	 Rotavirus 2 Dose Vaccinations 
	
	from
		"Rotavirus 2 Dose Immunizations or Procedures" Rotavirus2Vaccination1,
		"Rotavirus 2 Dose Immunizations or Procedures" Rotavirus2Vaccination2
		where Rotavirus2Vaccination2.authorDatetime 1 day or more after day of Rotavirus2Vaccination1.authorDatetime
		return Rotavirus2Vaccination1
  
o	 Rotavirus 2 or 3 Dose Vaccinations 
	
	( "Rotavirus 2 Dose Vaccination Followed by Two Rotavirus 3 Dose Vaccinations"
			union "Rotavirus 3 Dose Vaccination Followed by A Rotavirus 2 Dose Vaccination and A Rotavirus 3 Dose Vaccination"
			union "Rotavirus 3 Dose Vaccinations Followed by One Rotavirus 2 Dose Vaccination"
	)
  
o	 Rotavirus 3 Dose Immunizations or Procedures 
	
	( ["Immunization, Administered": "Rotavirus Vaccine (3 dose schedule)"]
		union ( ["Procedure, Performed": "Rotavirus vaccine, pentavalent (RV5), 3 dose schedule, live, for oral use"] Rotavirus3Administration
				return "Immunization, Administered" { authorDatetime: start of Rotavirus3Administration.relevantPeriod }
		) ) ThreeDoseRotavirus
		with ["Patient Characteristic Birthdate"] BirthDate
			such that ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, ThreeDoseRotavirus.authorDatetime)>= 42 )
				and ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, ThreeDoseRotavirus.authorDatetime)<= 730 )
  
o	 Rotavirus 3 Dose Vaccination Followed by A Rotavirus 2 Dose Vaccination and A Rotavirus 3 Dose Vaccination 
	
	from
		"Rotavirus 3 Dose Immunizations or Procedures" Rotavirus323Vaccination1,
		"Rotavirus 2 Dose Immunizations or Procedures" Rotavirus323Vaccination2,
		"Rotavirus 3 Dose Immunizations or Procedures" Rotavirus323Vaccination3
		where Rotavirus323Vaccination2.authorDatetime 1 day or more after day of Rotavirus323Vaccination1.authorDatetime
			and Rotavirus323Vaccination3.authorDatetime 1 day or more after day of Rotavirus323Vaccination2.authorDatetime
		return Rotavirus323Vaccination1
  
o	 Rotavirus 3 Dose Vaccinations 
	
	from
		"Rotavirus 3 Dose Immunizations or Procedures" Rotavirus3Vaccination1,
		"Rotavirus 3 Dose Immunizations or Procedures" Rotavirus3Vaccination2,
		"Rotavirus 3 Dose Immunizations or Procedures" Rotavirus3Vaccination3
		where Rotavirus3Vaccination2.authorDatetime 1 day or more after day of Rotavirus3Vaccination1.authorDatetime
			and Rotavirus3Vaccination3.authorDatetime 1 day or more after day of Rotavirus3Vaccination2.authorDatetime
		return Rotavirus3Vaccination1
  
o	 Rotavirus 3 Dose Vaccinations Followed by One Rotavirus 2 Dose Vaccination 
	
	from
		"Rotavirus 3 Dose Immunizations or Procedures" Rotavirus332Vaccination1,
		"Rotavirus 3 Dose Immunizations or Procedures" Rotavirus332Vaccination2,
		"Rotavirus 2 Dose Immunizations or Procedures" Rotavirus332Vaccination3
		where Rotavirus332Vaccination2.authorDatetime 1 day or more after day of Rotavirus332Vaccination1.authorDatetime
			and Rotavirus332Vaccination3.authorDatetime 1 day or more after day of Rotavirus332Vaccination2.authorDatetime
		return Rotavirus332Vaccination1
  
o	 Rotavirus Numerator Inclusion Conditions 
	
	( ( ["Diagnosis": "Anaphylaxis due to rotavirus vaccine (disorder)"]
			union ["Diagnosis": "Severe Combined Immunodeficiency"]
			union ["Diagnosis": "Intussusception"] ) RotavirusConditions
			with ["Patient Characteristic Birthdate"] BirthDate
				such that Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, start of RotavirusConditions.prevalencePeriod)<= 730
	)
  
o	 Rubella Indicators 
	
	( ( ["Laboratory Test, Performed": "Rubella Antibody Test (IgG Antibody Titer)"] RubellaTiter
			where RubellaTiter.result >= 1.10
	)
		union ( ["Laboratory Test, Performed": "Rubella Antibody Test (IgG Antibody presence)"] RubellaIgGPresence
				where RubellaIgGPresence.result as Code in "Positive Finding"
		)
		union ( ["Diagnosis": "Rubella"] RubellaDiagnosis
				return "Laboratory Test, Performed" { authorDatetime: start of RubellaDiagnosis.prevalencePeriod }
		) ) Rubella
		with ["Patient Characteristic Birthdate"] BirthDate
			such that Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, Rubella.authorDatetime)<= 730
  
o	 SDE Ethnicity 
	
	["Patient Characteristic Ethnicity": "Ethnicity"]
  
o	 SDE Payer 
	
	["Patient Characteristic Payer": "Payer"]
  
o	 SDE Race 
	
	["Patient Characteristic Race": "Race"]
  
o	 SDE Sex 
	
	["Patient Characteristic Sex": "ONC Administrative Sex"] 
  
o	 Three Hepatitis B Vaccinations 
	
	from
		"Hepatitis B Immunizations or Procedures" HepatitisBVaccination1,
		"Hepatitis B Immunizations or Procedures" HepatitisBVaccination2,
		"Hepatitis B Immunizations or Procedures" HepatitisBVaccination3
		where HepatitisBVaccination2.authorDatetime 1 day or more after day of HepatitisBVaccination1.authorDatetime
			and HepatitisBVaccination3.authorDatetime 1 day or more after day of HepatitisBVaccination2.authorDatetime
		return HepatitisBVaccination1
  
o	 Three Hib Vaccinations 
	
	from
		"Hib Immunizations or Procedures" HiBVaccination1,
		"Hib Immunizations or Procedures" HiBVaccination2,
		"Hib Immunizations or Procedures" HiBVaccination3
		where HiBVaccination2.authorDatetime 1 day or more after day of HiBVaccination1.authorDatetime
			and HiBVaccination3.authorDatetime 1 day or more after day of HiBVaccination2.authorDatetime
		return HiBVaccination1
  
o	 Three Polio Vaccinations 
	
	from
		"Polio Immunizations or Procedures" PolioVaccination1,
		"Polio Immunizations or Procedures" PolioVaccination2,
		"Polio Immunizations or Procedures" PolioVaccination3
		where PolioVaccination2.authorDatetime 1 day or more after day of PolioVaccination1.authorDatetime
			and PolioVaccination3.authorDatetime 1 day or more after day of PolioVaccination2.authorDatetime
		return PolioVaccination1
  
o	 Two Influenza Vaccinations 
	
	from
		"Influenza Immunizations or Procedures" FluVaccination1,
		"Influenza Immunizations or Procedures" FluVaccination2
		where FluVaccination2.authorDatetime 1 day or more after day of FluVaccination1.authorDatetime
		return FluVaccination1
  
o	 Varicella Zoster Numerator Inclusion Conditions 
	
	( ( ["Laboratory Test, Performed": "Varicella Zoster Antibody Test (IgG Antibody Titer)"] ChickenPoxTiter
			where ChickenPoxTiter.result >= 1.10
	)
		union ( ["Laboratory Test, Performed": "Varicella Zoster Antibody Test (IgG Antibody Presence)"] ChickenPoxIgGPresence
				where ChickenPoxIgGPresence.result as Code in "Positive Finding"
		)
		union ( ["Diagnosis": "Disorders of the Immune System"] ImmuneDisorder
				return "Laboratory Test, Performed" { authorDatetime: start of ImmuneDisorder.prevalencePeriod }
		)
		union ( ["Diagnosis": "HIV"] HIV
				return "Laboratory Test, Performed" { authorDatetime: start of HIV.prevalencePeriod }
		)
		union ( ["Diagnosis": "Malignant Neoplasm of Lymphatic and Hematopoietic Tissue"] LymphaticMalignantNeoplasm
				return "Laboratory Test, Performed" { authorDatetime: start of LymphaticMalignantNeoplasm.prevalencePeriod }
		)
		union ( ["Diagnosis": "Neomycin adverse reaction (disorder)"] NeomycinReaction
				return "Laboratory Test, Performed" { authorDatetime: start of NeomycinReaction.prevalencePeriod }
		)
		union ( ["Diagnosis": "Varicella Zoster"] VaricellaZoster
				return "Laboratory Test, Performed" { authorDatetime: start of VaricellaZoster.prevalencePeriod }
		) ) VaricellaZosterConditions
		with ["Patient Characteristic Birthdate"] BirthDate
			such that ( Global."CalendarAgeInDaysAt"(BirthDate.birthDatetime, VaricellaZosterConditions.authorDatetime)<= 730 )
  
Functions

o	 Global.CalendarAgeInDaysAt(BirthDateTime DateTime, AsOf DateTime) 
	
	days between ToDate(BirthDateTime)and ToDate(AsOf)
  
o	 Global.CalendarAgeInYearsAt(BirthDateTime DateTime, AsOf DateTime) 
	
	years between ToDate(BirthDateTime)and ToDate(AsOf)
  
o	 Global.ToDate(Value DateTime) 
	
	DateTime(year from Value, month from Value, day from Value, 0, 0, 0, 0, timezone from Value)
  
Terminology

 SDE Ethnicity 
o	
	["Patient Characteristic Ethnicity": "Ethnicity"]
  
 SDE Payer 
o	
	["Patient Characteristic Payer": "Payer"]
  
 SDE Race 
o	
	["Patient Characteristic Race": "Race"]
  
 SDE Sex 
o	
	["Patient Characteristic Sex": "ONC Administrative Sex"] 
  
