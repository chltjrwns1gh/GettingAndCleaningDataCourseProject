# You should create one R script called run_analysis.R that does the following. 

# Requirement 1. Merges the training and the test sets to create one data set.
# Save original directory
dir_original <- getwd()
# Create directory lists #set, #train, #merged
filedirs_test <- c('./UCI HAR Dataset/test/subject_test.txt',
           './UCI HAR Dataset/test/X_test.txt',
           './UCI HAR Dataset/test/y_test.txt',
           './UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt',
           './UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt',
           './UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt',
           './UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt',
           './UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt',
           './UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt',
           './UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt',
           './UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt',
           './UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt')
filedirs_train <- lapply(files_test, function(x){gsub('test', 'train', x)})
filedirs_merged <- lapply(files_test, function(x){gsub('test', 'merged', x)}) # Lists of directory which merged files will be saved
# Create directory which merged data should be saved
if(!file.exists("./UCI HAR Dataset/merged")){
    dir.create("./UCI HAR Dataset/merged")
}
if(!file.exists("./UCI HAR Dataset/merged/Inertial Signals")){
    dir.create("./UCI HAR Dataset/merged/Inertial Signals")
}
# Create and Save merged data
for(index_directory in 1:length(files_test)){
    data_temp_test <- read.table(filedirs_test[[index_directory]])
    data_temp_train <- read.table(filedirs_train[[index_directory]])
    data_temp_merged <- rbind(data_temp_test, data_temp_train)
    write.table(data_temp_merged, file=filedirs_merged[[index_directory]])
}

# Requirement 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Requirement 3. Uses descriptive activity names to name the activities in the data set
# Requirement 4. Appropriately labels the data set with descriptive variable names. 
# Requirement 5. From the data set in step 4, creates a second
#    , independent tidy data set with the average of each variable for each activity and each subject.

# Variable 'data2' means data made in requirement 2.
data2 <- data.frame(matrix(ncol=2, nrow=0,
                           dimnames=list(NULL, c('mean', 'standard_deviation'))))
for(index_directory in 1:length(filedirs_merged)){
    data_temp_merged <- read.table(filedirs_merged[[index_directory]])
    data2[nrow(data2)+1,] <- c(mean(as.matrix(data_temp_merged)), sd(as.matrix(data_temp_merged)))
}
rownames(data2) <- c('subject', 'X', 'y',
                     'body_acc_x', 'body_acc_y', 'body_acc_z',
                     'body_gyro_x', 'body_gyro_y', 'body_gyro_z',
                     'total_acc_x', 'total_acc_y', 'total_acc_z')
# Save data2 as 'data2.txt'
write.table(data2, file='data2.txt', row.name=FALSE)
