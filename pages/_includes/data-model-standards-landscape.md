#### 1.2.3 Data Model Standards Landscape
{: #data-model-standards-landscape}

The quality improvement ecosystem covers every aspect of the healthcare
delivery system, and needs to be able to represent information across that
entire spectrum. FHIR provides a foundation for representation of this
information in a universally applicable way. In particular cases, more
specificity is required to capture the intended meaning of healthcare
information. As FHIR is more and more broadly adopted, consensus among
participating stakeholders on the use of particular profiles and patterns
enables semantic interoperability for more use cases.

Within the US Realm, US Core profiles comprise this base consensus, and
although it enables a variety of interoperability use cases, the profiles do not
represent all of the requirements for quality improvement. The QI-Core profiles
are derived from US Core and provide this additional functionality.

There are occasional instances where additional specificity or functionality
is required explicitly for quality measurement, or a particular component within
a quality measure. In these cases, additional profiles are defined within the
DEQM, or by stakeholders such as measure developers or implementers. For
example, the Medication Reconciliation Post Discharge measure example included
in this implementation guide references the Healthcare Effectiveness Data and
Information Set (HEDIS) Implementation Guide, which defines profiles specific to
that particular HEDIS measure.

The following diagram depicts this data model standards landscape:

<details open>
<summary>

<b>Figure 3: The Data Model Standards Landscape Diagram</b>

</summary>

<img src="assets/images/data-model-standards-landscape.png" alt="Data Model
Standards Landscape" class="img-responsive img-rounded center-block"/>

</details>


As illustrated, FHIR provides the foundation, and sets of profiles are built
on top of FHIR that provide more and more focused use cases by constraining
profiles and extending functionality to cover gaps. While the additional layers
are necessary to represent specific operations and provide space for agreement
among relevant stakeholders, the consensus-based standards development process
is used to suggest changes to the layers below, resulting in an ever-broadening
umbrella of interoperability.

This layering of profiles balances the relative adoption and implementation
maturity of FHIR and the data representation requirements of the use cases
involved, guided by the following principles:

1.  **Avoid proliferation of profiles.** To the extent possible, make
use of existing profiles at the lowest level of the stack, only defining a new
profile if absolutely necessary to express a requirement for a particular use
case that cannot be represented by an existing one.
2.  **Share profiles across measures.** There should not be profiles specific to any particular
measure. Instead, QI Core provides a layer for the expression of quality
improvement requirements across measures and decision support artifacts.
3.  **No terminology-narrowing-only profiles.** Profiles should not be used
to specify only terminology narrowing constraints. The FHIR Clinical Reasoning
module and CQL enable the representation of data requirements for quality
measures and decision support artifacts.
4.  **Promote data-related profiles.** When it becomes necessary to define a data-related profile at the
measurement-specific level (in DEQM or HEDIS for example), steps should be taken
to promote that profile to the broadest consensus group possible.

##### 1.2.3.1 FHIR Version Support
{: #fhir-version-support}

There are three broadly used and fully published versions of the FHIR
specification:

-  **FHIR DSTU2** - This version has broad support among US-based
vendors as it is the basis for the Argonaut profiles. Most major vendors today
support some subset of this version of FHIR
-    **FHIR STU3** - This is
the version that US Core, QI Core, and many other implementation guides are
based on. There is broad vendor support for this version.
-  **FHIR R4** - This is the first normative release of FHIR, including several of the
foundational, conformance, and administrative resources going normative.

The implementation guides in this landscape are currently focused on FHIR
STU3, with the plan to produce R4 versions once the US Core and QI Core profiles
have been updated to R4.

In addition to _what_ data is reported, use cases frequently require the 
communication of _when_, _where_ and _how_ to report. See the 
[Electronic Case Reporting (eCR) implementation guide](http://hl7.org/fhir/us/ecr/2018Sep/design-considerations.html#fhir-design-considerations) 
for a more complete discussion of these design considerations. We are actively 
seeking feedback from implementers how this type of information is currently 
communicated in quality reporting scenarios and when it would be useful to do 
so electronically.
{: .stu-note}