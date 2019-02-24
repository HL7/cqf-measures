library EXM55_QDM version '5.0.0' 

using QDM version '5.0.2' 

valueset "ONC Administrative Sex" : 'urn:oid:2.16.840.1.113762.1.4.1' 
valueset "Race" : 'urn:oid:2.16.840.1.114222.4.11.836' 
valueset "Ethnicity" : 'urn:oid:2.16.840.1.114222.4.11.837' 
valueset "Payer" : 'urn:oid:2.16.840.1.114222.4.11.3591' 
valueset "Emergency Department Visit" : 'urn:oid:2.16.840.1.113883.3.117.1.7.1.292' 
valueset "Psychiatric/Mental Health Patient" : 'urn:oid:2.16.840.1.113883.3.117.1.7.1.299' 
valueset "Hospital Settings" : 'urn:oid:2.16.840.1.113762.1.4.1111.126' 

parameter "Measurement Period" Interval<DateTime> 

context Patient 

define "SDE Ethnicity" : 
	["Patient Characteristic Ethnicity" : "Ethnicity"] 

define "SDE Payer" : 
	["Patient Characteristic Payer" : "Payer"] 

define "SDE Race" : 
	["Patient Characteristic Race" : "Race"] 

define "SDE Sex" : 
	["Patient Characteristic Sex" : "ONC Administrative Sex"] 

define "Initial Population" : 
	"Inpatient Encounter" Encounter 
		with ["Encounter, Performed" : "Emergency Department Visit"] ED
		   such that ED.relevantPeriod ends 1 hour or less before start of Encounter.relevantPeriod 

define "Measure Population" : 
	"Initial Population" 

define "Inpatient Encounter" : 
	["Encounter, Performed"] Encounter
		where Encounter.lengthOfStay <= 120 days
		and Encounter.relevantPeriod ends during "Measurement Period" 

define "Measure Population Exclusions" : 
	"Inpatient Encounter" Encounter
		with ["Encounter, Performed" : "Emergency Department Visit"] ED 
		   such that ED.relevantPeriod ends 1 hour or less before start of Encounter.relevantPeriod
		      and ED.admissionSource in "Hospital Settings" 

define "Stratification 1" : 
	"Inpatient Encounter" Encounter 
		where not (Encounter.principalDiagnosis in "Psychiatric/Mental Health Patient") 

define "Stratification 2" : 
	"Inpatient Encounter" Encounter
		where Encounter.principalDiagnosis in "Psychiatric/Mental Health Patient" 

define "Stratification 3" : 
	"Inpatient Encounter" Encounter
		where Encounter.principalDiagnosis is null 

//Measure Observation
define function "Related ED Visit" (Encounter "Encounter, Performed" ) : 
	Last(["Encounter, Performed" : "Emergency Department Visit"] ED 
		where ED.relevantPeriod ends 1 hour or less before start of Encounter.relevantPeriod 
		sort by start of ED.relevantPeriod ) 

define function "Measure Observation" (Encounter "Encounter, Performed" ) : 
	duration in minutes of "Related ED Visit" (Encounter).locationPeriod