run_analysis.R cleans and transforms data found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data comes in 8 .txt files. 

Training Data:
subject_train.txt <- contains the subject training from the volunteers
X_train.txt <- contains training data
y_train.txt <- contains training data of recorded activities to predict

Testing Data:
subject_test.txt <- contains testing data from the volunteers
X_test.txt <- contains testing data
y_test <- contains testing data of recorded activities to predict

Other Files:
activity_labels.txt <- contains the labels for the activities that have been coded numerically
features.txt <- contains variable names

The data is cleaned across 5 general steps:

1. Download the data, and assign all files to their individual dataframes
2. Merge the dataframes to create the working dataframe
3. Clean the variable names
4. Take the mean across all the variables
5. Output the final dataframe. 