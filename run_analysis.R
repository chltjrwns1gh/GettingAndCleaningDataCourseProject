# [ Requirement 0 ]. download dataset
filename <- 'Dataset.zip'
URL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if(!file.exists(filename)){
    download.file(URL, destfile=filename)
}
if(!file.exists("UCI HAR Dataset")){
    unzip(filename)
}

# You should create one R script called run_analysis.R that does the following. 

# ---------------------------------------------------- 
# [ Requirement 1] . Merges the training and the test sets to create one data set.
# Create directory lists #test, #train, #merged
filedirs_test <- c('./UCI HAR Dataset/test/subject_test.txt',
           './UCI HAR Dataset/test/X_test.txt',
           './UCI HAR Dataset/test/y_test.txt')
filedirs_train <- lapply(filedirs_test, function(x){gsub('test', 'train', x)})
filedirs_merged <- lapply(filedirs_test, function(x){gsub('test', 'merged', x)}) # Lists of directory which merged files will be saved

# Create directory which merged data should be saved
if(!file.exists("./UCI HAR Dataset/merged")){
    dir.create("./UCI HAR Dataset/merged")
}

# Create and each merged(rbind(test, train)) data
for(index_directory in 1:3){
    data_temp_test <- read.table(filedirs_test[[index_directory]])
    data_temp_train <- read.table(filedirs_train[[index_directory]])
    data_temp_merged <- rbind(data_temp_test, data_temp_train)
    if(!file.exists(filedirs_merged[[index_directory]])){write.table(data_temp_merged, file=filedirs_merged[[index_directory]])}
}

# Read features and activity_labels
features <- read.table('./UCI HAR Dataset/features.txt', col.names=c('function_code', 'function_name'))
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', col.names=c('activity_code', 'activity_type'))

# Read merged data
subject_merged <- read.table('./UCI HAR Dataset/merged/subject_merged.txt', col.names='subject')
X_merged <- read.table('./UCI HAR Dataset/merged/X_merged.txt', col.names=features$function_name)
y_merged <- read.table('./UCI HAR Dataset/merged/y_merged.txt', col.names='activity_code')

# Create one merged dataset by features(==cbind)
merged_data <- cbind(subject_merged, X_merged, y_merged)

# ---------------------------------------------------- 
# [ Requirement 2 ]. Extracts only the measurements on the mean and standard deviation for each measurement. 
library(dplyr)
# Select columns of merged_data : subject_merged, y_merged, X_merged(containing 'mean' or 'std')
tidy_data <- merged_data %>% select(subject, activity_code, contains('mean'), contains('std'))


# ---------------------------------------------------- 
# [ Requirement 3 ]. Uses descriptive activity names to name the activities in the data set
tidy_data$activity_code <- activity_labels[tidy_data$activity_code, 2]
colnames(tidy_data)[2] <- 'activity'

# ---------------------------------------------------- 
# [ Requirement 4 ]. Appropriately labels the data set with descriptive variable names. 
colnames(tidy_data) <- gsub('^t', 'time.', colnames(tidy_data))
colnames(tidy_data) <- gsub('^f', 'frequency.', colnames(tidy_data))
colnames(tidy_data) <- gsub('Acc', 'accelerometer.', colnames(tidy_data))
colnames(tidy_data) <- gsub('Gyro', 'gyroscope.', colnames(tidy_data))
colnames(tidy_data) <- gsub('Mag', 'magnitude.', colnames(tidy_data))
colnames(tidy_data) <- gsub('std', 'standard_deviation.', colnames(tidy_data))
colnames(tidy_data) <- gsub('Body', 'body.', colnames(tidy_data))
colnames(tidy_data) <- gsub('Gravity', 'gravity.', colnames(tidy_data))
colnames(tidy_data) <- gsub('Freq', 'frequency.', colnames(tidy_data))
colnames(tidy_data) <- gsub('Mean', 'mean.', colnames(tidy_data))
colnames(tidy_data) <- gsub('mean', 'mean.', colnames(tidy_data))
colnames(tidy_data) <- gsub('gravity', 'gravity.', colnames(tidy_data))
colnames(tidy_data) <- gsub('Jerk', 'jerk.', colnames(tidy_data))
colnames(tidy_data) <- gsub('\\.{2, }', '\\.', colnames(tidy_data))


# ---------------------------------------------------- 
# [ Requirement 5 ]. From the data set in step 4, creates a second
#    , independent tidy data set with the average of each variable for each activity and each subject.
result <- tidy_data %>%
    group_by(subject, activity) %>%
    summarize_all(funs(mean))
write.table(result, 'result.txt', row.name=FALSE)
