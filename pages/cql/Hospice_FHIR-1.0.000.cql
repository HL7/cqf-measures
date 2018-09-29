library Hospice_FHIR version '1.0.000'

using FHIR version '3.0.0'

include MATGlobalCommonFunctionsFHIR version '2.0.000' called Global
include FHIRHelpers version '3.0.0' called FHIRHelpers

// codesystem "SNOMEDCT:2017-09": 'urn:oid:2.16.840.1.113883.6.96' version 'urn:hl7:version:2017-09'
codesystem "SNOMEDCT:2017-09": 'http://snomed.info/sct' version 'urn:hl7:version:2017-09'

valueset "Encounter Inpatient": 'urn:oid:2.16.840.1.113883.3.666.5.307'
valueset "Hospice care ambulatory": 'urn:oid:2.16.840.1.113762.1.4.1108.15'

code "Discharge to healthcare facility for hospice care (procedure)": '428371000124100' from "SNOMEDCT:2017-09" display 'Discharge to healthcare facility for hospice care (procedure)'
code "Discharge to home for hospice care (procedure)": '428361000124107' from "SNOMEDCT:2017-09" display 'Discharge to home for hospice care (procedure)'

context Patient

define function "Has Hospice"(MeasurementPeriod Interval<DateTime>):
	exists (
	    [Encounter: "Encounter Inpatient"] DischargeHospice
			where DischargeHospice.status = 'final'
			    and (
			        FHIRHelpers.ToConcept(DischargeHospice.hospitalization.dischargeDisposition).codes[0] ~ "Discharge to home for hospice care (procedure)"
					    or FHIRHelpers.ToConcept(DischargeHospice.hospitalization.dischargeDisposition).codes[0] ~ "Discharge to healthcare facility for hospice care (procedure)"
			    )
				and DischargeHospice.period ends during day of MeasurementPeriod
	)
    or exists (
        [ProcedureRequest: "Hospice care ambulatory"] HospiceOrder
            where HospiceOrder.intent = 'order'
                and HospiceOrder.authoredOn in day of MeasurementPeriod
    )
    or exists (
        [Procedure: "Hospice care ambulatory"] HospicePerformed
            where HospicePerformed.status = 'completed'
                and Global."Get Choice Interval - dateTime or Period"(HospicePerformed.performed) overlaps MeasurementPeriod
    )
