# Terminology Bindings

All bindings in the Measure Resource:
http://hl7.org/fhir/measure.html#tx

|----|----|----|----|
|Path	|Definition	|Type	|Reference |
|Measure.status 		|The lifecycle status of an artifact.		|Required		|PublicationStatus
|Measure.subject[x] 		|The possible types of subjects for a measure (E.g. Patient, Practitioner, Organization, Location, etc.).		|Extensible		|SubjectType
|Measure.jurisdiction 		|Countries and regions within which this artifact is targeted for use.		|Extensible		|Jurisdiction 	ValueSet
|Measure.topic 		|High-level categorization of the definition, used for searching, sorting, and filtering.		|Example		|DefinitionTopic
|Measure.scoring 		|The scoring type of the measure.		|Extensible		|MeasureScoring
|Measure.compositeScoring 		|The composite scoring method of the measure.		|Extensible		|CompositeMeasureScoring
|Measure.type 		|The type of measure (includes codes from 2.16.840.1.113883.1.11.20368).		|Extensible		|MeasureType
|Measure.improvementNotation 		|Observation values that indicate what change in a measurement value or score is indicative of an improvement in the measured item or scored issue.		|Required		|MeasureImprovementNotation
|Measure.group.population.code 		|The type of population.		|Extensible		|MeasurePopulationType
|Measure.supplementalData.usage 		|The intended usage for supplemental data elements in the measure.		|Extensible		|MeasureDataUsage

* Measure.status: ballot bound
* Measure.subject[x]: FHIR-defined implicit value set - no changes required
* Measure.jurisdiction: FHIR-defined value set - no changes required
* Measure.topic: Example binding, not used in QM IG
* Measure.scoring: Update http://terminology.hl7.org/ValueSet/measure-scoring
* Measure.compositeScoring: Update to http://terminology.hl7.org/ValueSet/composite-measure-scoring
* Measure.type: Update to http://terminology.hl7.org/ValueSet/measure-type
* Measure.improvementNotation: http://terminology.hl7.org/ValueSet/measure-improvement-notation
* Measure.group.population.code: http://terminology.hl7.org/ValueSet/measure-population
* Measure.group.supplementalData.usage: http://terminology.hl7.org/ValueSet/measure-data-usage


measure-data-usage
http://terminology.hl7.org/CodeSystem/v3-ActCode
#MSRADJ risk adjustment
#SDE supplemental data elements

http://terminology.hl7.org/CodeSystem/measure-data-usage
#supplemental-data Supplemental Data
#risk-adjustment-factor Risk Adjustment Factor

improvement notation

http://terminology.hl7.org/CodeSystem/v3-ObservationValue
#DecrIsImp
#IncrIsImp

http://terminology.hl7.org/ValueSet/measure-improvement-notation
http://terminology.hl7.org/CodeSystem/measure-improvement-notation
#increase
#decrease

observation-method-aggregate:
http://terminology.hl7.org/ValueSet/v3-ObservationMethodAggregate
http://terminology.hl7.org/CodeSystem/v3-ObservationMethod
#AVERAGE
#COUNT
#MAX
#MEDIAN
#MIN
#MODE
#STDEV.P
#STDEV.S
#SUM
#VARIANCE.P
#VARIANCE.S

http://hl7.org/fhir/us/cqfmeasures/ValueSet/aggregate-method
http://hl7.org/fhir/us/cqfmeasures/CodeSystem/aggregate-method
#sum
#average
#median
#minimum
#maximum
#count
