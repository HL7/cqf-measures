---
layout: default
title: HQMF Human readability
---
### 2.6 Human Readability and Rendering HQMF Documents

HQMF requires that a receiver of an eMeasure be able to deterministically display the document in a standard Web browser such that a human reader would extract the same quality data as would a computer that is basing the extraction on formally encoded eMeasure entries. Material within a section to be rendered is placed into the section.text field. The content model of this field is the same as that used for other Structured Document specifications (e.g., Clinical Document Architecture, Structured Product Labeling).

The following conformance constraints relate to the rendered content of an HQMF document:

* A recipient of an eMeasure SHALL be able to parse and interpret the document sufficiently to render it, using the rendering rules in the Section Narrative Block.
* HQMF header fields, which SHALL be rendered if present, include the following attributes, participants, and relationships:
  * QualityMeasureDocument.title
  * QualityMeasureDocument.text
  * QualityMeasureDocument.statusCode
  * QualityMeasureDocument.effectiveTime
  * QualityMeasureDocument.versionNumber
  * QualityMeasureDocument.author
  * QualityMeasureDocument.custodian
  * QualityMeasureDocument.verifier
    * QualityMeasureDocument.verifier.time
* QualityMeasureDocument.componentOf. QualityMeasureSet. title
* QualityMeasureDocument.subjectOf. MeasureAttribute code value pairs
* HQMF section fields which if present must be rendered include:
  * Section.title
  * Section.text (must be rendered per the rules defined in Section Narrative Block).
A creator of an eMeasure SHALL properly populate section.text and Section Narrative Blocks such that a recipient, adhering to the recipient requirements above, will render the document such that a human reader would extract the same quality data as would a computer that is basing the extraction on formally encoded eMeasure entries.

To avoid confusion among readers, narrative block and rendered content must be differentiated. Rendered Content refers to all the elements that a recipient must be able to render for the document as a whole. This includes QualityMeasureDocument.title and QualityMeasureDocument.text elements where a narrative description of the eMeasure is stored, and to the Section.text and Section.title elements where narrative text to be rendered is stored. "Narrative Block" specifically refers to section.text elements in every section.

The textual elements at the document level and the section level can contain all the required information for a measure in a narrative form, however it cannot be verified or automated to provide consistent processing.