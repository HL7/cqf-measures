#### Data Model Standards Landscape
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

There are occasional instances where additional specificity or functionality is
required explicitly for quality measurement, or a particular component within a
quality measure. In these cases, creation of measure content IG can be considered
to facilitate measure development.

The following diagram depicts this data model standards landscape:

<details open>
<summary>

<b>Figure 3: The Data Model Standards Landscape Diagram</b>

</summary>

{% include img.html img="data-model-standards-landscape.png" %}

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
measurement-specific level (in Measure Content IG for example), steps should be taken
to promote that profile to the broadest consensus group possible.


