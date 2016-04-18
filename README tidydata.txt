The run_analysis.R file contains a script to transform the initial UCI HAR dataset into a tidy data set, with the following characteristics:
-One variable per column
-One observation per row
-One observation set per table.

The R script is to be run from the same workspace that contains the UCI HAR dataset that has been downloaded from the link provided in the assignment.

This script performs the following:
1. Uses read.table to read into R the datasets for test and train, along with the text files listing the subject IDÕs as well as the activity ID for each line of data contained in the X_test and X_train files.

2. Uses rbind to combine the two data frames (test and train) and include the subject IDs and the activity ID numbers in order to identify each row. 

3. Uses grep, select, and filter to remove the columns that relate to feature variables that are not either a mean or standard deviation calculation.

4. merge, select, and rename are used to replace the activity IDÕs (which have been coerced into an integer vector as opposed to a data frame) with descriptive character names. This is done by merging the activity labels text file with the combined data frame, using the activity IDÕs as a key.

5. Used gather and mutate to tidy the data set by creating two columns, Feature, and Time such that all of the feature IDÕs are in one column, and the measured value in the other. This meets the first definition of tidy data, as noted above.

Merge is used to swap out the feature IDÕs for the actual feature text names, in a similar fashion to step 4 for the activity IDs.

Group_by is used to group the data set by subject, activity, and feature name, in order to prep the dat set for step 5. Using summarize, we obtain the final tidy data set that provides the average value for each feature variable, on a subject and activity basis.

