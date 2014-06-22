getdata-004-project
===================

Repository for Coursera Getting and Cleaning Data course
--

Usage
-----
Download https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extract files into a `data` folder. For more information on the dataset, see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

Run `run_analysis.R`.

Process
-------
This script first loads:
* "./UCI HAR Dataset/activity_labels.txt" into `activity_lables` dataframe
* "./data/UCI HAR Dataset/test/subject_test.txt" and "./data/UCI HAR Dataset/train/subject_train.txt" into `subject` dataframe
* "./UCI HAR Dataset/features.txt" into `x_labels` dataframe
* "./data/UCI HAR Dataset/test/X_test.txt" and "./data/UCI HAR Dataset/train/X_train.txt" into `x` dataframe
* "./data/UCI HAR Dataset/test/y_test.txt" and "./data/UCI HAR Dataset/train/y_train.txt" into `y`

Columns for each dataframe are renamed appropriately for readability.

Finally, dataframe `final` is created by merging `activity_labels` with `y` using the activity_id and binding columns from dataframes `x` and `subject`. For this project, we're only interested in mean and standard deviation calculations, so any column name that does not contain "-mean()" or "-std()" is removed.

This leaves us with a single 'tidy' dataframe containing one measurement for each measurement type, for each subject, for each activity, for each observation. This allows us to easily manipulate all measurement values for a given measurement type, or all measurements for a given activity or subject.

An average of each measurement, for each activity, for each subject is then saved to dataframe `final_avg`. Both final dataframes are saved as CSV files in the data folder.
