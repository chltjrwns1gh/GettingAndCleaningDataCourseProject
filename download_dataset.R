# download dataset
URL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(URL, destfile='Dataset.zip')
unzip('Dataset.zip')
# list.dirs()
# [26] "./UCI HAR Dataset"                              
# [27] "./UCI HAR Dataset/test"                         
# [28] "./UCI HAR Dataset/test/Inertial Signals"        
# [29] "./UCI HAR Dataset/train"                        
# [30] "./UCI HAR Dataset/train/Inertial Signals"