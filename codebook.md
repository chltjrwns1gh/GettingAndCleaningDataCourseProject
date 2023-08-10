'run_analysis.R' does series of things.\

# 1. Download the dataset
Original Dataset is from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip \
It is downloaded and unzipped as folder 'UCI HAR Dataset'\

# 2. Create merged data directory and save merged data

filedirs_test contains 3 data sets in the test directory('./UCI HAR Dataset/test/') : 'subject_test.txt', 'X_test.txt', 'y_test.txt'
<pre><code>
filedirs_test <- c('./UCI HAR Dataset/test/subject_test.txt',
           './UCI HAR Dataset/test/X_test.txt',
           './UCI HAR Dataset/test/y_test.txt')
</code></pre>
filedirs_train contains 3 data sets in the train directory('./UCI HAR Dataset/train/') : 'subject_train.txt', 'X_train.txt', 'y_train.txt'\
This and next step are done easily by multiple substitution(gsup()) by every elements of filedirs_test.
<pre><code>  filedirs_train <- lapply(filedirs_test, function(x){gsub('test', 'train', x)})  </code></pre>
filedirs_merged contains 3 data sets directory which merged data sets will be stored ('./UCI HAR Dataset/merged/') : 'subject_merged.txt', 'X_merged.txt', 'y_merged.txt'
<pre><code>  filedirs_merged <- lapply(filedirs_test, function(x){gsub('test', 'merged', x)})  </code></pre>

To make sure the existence of directories in filedirs_merged, each directory was created.
<pre><code>
if(!file.exists("./UCI HAR Dataset/merged")){
    dir.create("./UCI HAR Dataset/merged")
}
</code></pre>

To create merged dataset of test and training datasets, each test dataset and each train dataset are called.\
data_temp_test contains each files of './UCI HAR Dataset/test' folder in order of 'subject_test.txt', 'X_test.txt', 'y_test.txt'.
<pre><code>
  data_temp_test <- read.table(filedirs_test[[index_directory]])
</code></pre>
data_temp_train contains each files from './UCI HAR Dataset/train' folder in order of 'subject_train.txt', 'X_train.txt', 'y_train.txt'.
<pre><code>
  data_temp_train <- read.table(filedirs_train[[index_directory]])
</code></pre>
Then, data_temp_test and data_temp_train are merged into data_temp_merged by using rbind() function.
<pre><code>
  data_temp_merged <- rbind(data_temp_test, data_temp_train)
</code></pre>
Finally, data_temp_merged is stored as filedirs_merged
<pre><code>
  if(!file.exists(filedirs_merged[[index_directory]])){write.table(data_temp_merged, file=filedirs_merged[[index_directory]])}
</code></pre>

# 3. Read data and assign to each variable.
features <- features.txt\
activity_labels <- activity_labels.txt\
subject_merged <- subject_merged.txt\
X_merged <- X_merged.txt\
y_merged <- y_merged.txt\

# 4. Merge datasets to create one dataset using cbind() function
merged_data <- cbind(subject_merged, X_merged, y_merged)\

# 5. Extracts only the measurements on the mean and standard deviation for each measurement.
Since select() is in dplyr package,
<pre><code>
  library(dplyr)
</code></pre>
tidy_data is subset of merged_data containing columns : subject, activity_code, measurements which contains 'mean' or 'std'
<pre><code>
  tidy_data <- merged_data %>% select(subject, activity_code, contains('mean'), contains('std'))
</code></pre>

# 6. Uses descriptive activity names to name the activities in the data set
Change activity_code into activity_name.\
activity_code column is renamed into activity
<pre><code>
  tidy_data$activity_code <- activity_labels[tidy_data$activity_code, 2]
  colnames(tidy_data)[2] <- 'activity'
</code></pre>

# 7. Appropriately labels the data set with descriptive variable names
My principles of naming variables were these.
>    (1) All words are lowercase\
>    (2) All words are followed by one '.'\
>    (3) All short form words are replaced into full form words

all start with character t in column's name replaced by 'time.'\
all start with character f in column's name replaced by 'frequency.'\
all Acc in column's name replaced by 'accelerometer.'\
all Gyro in column's name replaced by 'gyroscope.'\
all Mag in column's name replaced by 'magnitude.'\
all std in column's name replaced by 'standard_deviation.'\
all Body in column's name replaced by 'body.'\
all Gravity in column's name replaced by 'gravity.'\
all Freq in column's name replaced by 'frequency.'\
all Mean in column's name replaced by 'mean.'\
all mean in column's name replaced by 'mean.'\
all gravity in column's name replaced by 'gravity.'\
all Jerk in column's name replaced by 'jerk.'\
all '\\.{2,}' in column's name replaced by '\\.'\

# 8. From the data set in step 7, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Final data was stored in result by summarizing means of each variable for each activity and each subject
<pre><code>
  result <- tidy_data %>%
    group_by(subject, activity) %>%
    summarize_all(funs(mean))
</code></pre>
result variable is exported into 'result.txt'
<pre><code>
  write.table(result, 'result.txt', row.name=FALSE)
</code></pre>
