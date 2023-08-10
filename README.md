# GettingAndCleaningDataCourseProject
https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project

[ How this project works ]
Execute 'run_analysis.R' to analyze data in 'UCI HAR Dataset' as given instructions in this URL (https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project).
It will automatically produce 'result.txt' as a result.
Because data files are few megabytes(MB), execution of 'run_analysis.R' might take some minutes. Please wait for it.

Code is executed in this orders.
1. Download and unzip the given dataset('UCI HAR Dataset') in a given URL(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. [ Requirement 1 ] Merge training and test sets together and saved in './UCI HAR Dataset/merged'
3. Read all data('features.txt', 'activity_labels.txt', 'subject_merged.txt', 'X_merged.txt', 'y_merged.txt')
4. [ Requirement 2 ] Select columns of merged data : subject_merged, y_merged, X_merged(columns named with contains('mean')|contains('std'))
5. [ Requirement 3 ] Use descriptive activity names as given in 'activity_labels.txt'
6. [ Requirement 4 ] Label the dataset with descriptive variable names.
7. [ Requirement 5 ] Create and Save independent tidy data set with the average of each variables.

DONE!!

[ What does each file do? ]
1. 'run_analysis.R' : This file performs data preparation and make it to tidy data set which contains average of each variable for each activity and each subject.
2. 'codebook.md' : This file shows you about (1) where this data originated, (2) what did I do to data(==what does 'run_analysis.R' do)
3. 'result.txt' : This file is the result of 'run_analysis.R'. 
4. 'README.md' : This file tells you about (1) how this project works, (2) what procedures this project do and (3) what each file does. Also, this file is file which you're watching now. 
