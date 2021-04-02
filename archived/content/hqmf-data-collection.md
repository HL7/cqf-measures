---
layout: default
title: HQMF Data Collection, Missing Data and Corrupt or Invalid Data
---
### 2.8 Data Collection, Missing Data and Corrupt or Invalid Data

HQMF eMeasure's Data and Population Criteria specify what measure population group the item being counted belongs to (e.g., Initial Population, Denominator, Denominator Exclusion, Numerator). For each Data or Population Criteria element defined in a HQMF measure, an item's EHR data can have three possible results:

1. The data for the item being counted meet the criterion.
2. The data for the item being counted do not meet the criterion.
3. Unknown item data or missing data.

For result #1 or #2, it is straightforward to evaluate what population group the item should belong to, based upon criterion satisfaction.

For result #3, since HQMF measures normally do not provide guidance on how to deal with the unknown result, there are often questions. Does or does not the item being counted meet the criterion? How can one determine a measure population group based on unknown result? Should a query continue to retrieve other data for the item being counted for the rest of the measure criteria?

To eliminate confusion and inconsistency in interpreting unknown data or missing data, the following constraint will apply: if data are unknown or missing, they SHALL fail the criteria unless otherwise specified in the measure.

To specify criteria around missing data, a measure can include missing data constructs using null flavors as part of the measure definition itself. For more information on this topic, refer to PopulationCriteriaSection.

While developing eMeasures, another aspect measure authors might need to account for is corrupt or invalid data. For example, assuming that one measure has a criterion of systolic blood pressure greater than 130, invalid and obviously misreported values such as systolic BP of 2000 might be reported as part of the criteria results.

For corrupt or invalid data, measure authors may need to take additional steps to construct HQMF eMeasures in a way that either reduces the chance of invalid values contaminating the result pool or reports invalid/corrupt data values separately using stratifiers. Although reporting invalid data is not explicitly defined in HQMF as a separate section, there are several strategies to deal with the situation.

One methodology is to define Data Criteria with caps at values deemed appropriate for the measure, using the appropriate Boolean logic (see the chapter on Logical Groupers) to check for false criteria before including a result into the result set.

A second approach is to use stratifiers (see the chapter on StratifierCriteria) to group the outlier/corrupt data values separately so measure authors have an idea if and when their Data Criteria are returning values that might skew the results. This would require a measure developer to create the Data Criteria needed to pick out only the outlier values and then use the stratifier criteria entry to group these values together. An important point to note is that this approach does not remove these values from the overall result set as in the previous approach. It only makes it easier for developers to identify that such values exist in the data set.