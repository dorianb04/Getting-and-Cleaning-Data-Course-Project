library(plyr)

dowloading <- function() {

  #Downloading the zipped Dataset

  #Checking if the directory exists
  if (!file.exists("./Dataset")) {
    dir.create("./Dataset")
  }

  #downloading the zip file
  download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                destfile = "./Dataset/DataSet.zip")

  #unzipping the file
  unzip(zipfile = "./Dataset/DataSet.zip",
        exdir = "./Dataset")

  #deleting the zip file
  file.remove("./Dataset/DataSet.zip")
}

## 1. Dowloading the file if it does not exists
if (!dir.exists("./Dataset")) {
  dowloading()
}

## 2. Reading the test and train dataset and mergind them together

### 2.1. Reading sets

# Test
x_test <- read.table("./Dataset/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./Dataset/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./Dataset/UCI HAR Dataset/test/subject_test.txt")

# Train
x_train <- read.table("./Dataset/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./Dataset/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./Dataset/UCI HAR Dataset/train/subject_train.txt")

# Activity label
activity_labels <- read.table("./Dataset/UCI HAR Dataset/activity_labels.txt")

# Features
features <- read.table("./Dataset/UCI HAR Dataset/features.txt")

# Columns names
colnames(x_train)<- features[, 2]
colnames(x_test) <- features[, 2]

colnames(y_train)<- "id_activity"
colnames(y_test) <- "id_activity"

colnames(subject_train) <- "id_subject"
colnames(subject_test) <- "id_subject"
colnames(activity_labels) <- c("id_activity", "name_activity")

### 2.2. Merging dataSets
train <- cbind(y_train, subject_train, x_train)
test <- cbind(y_test, subject_test, x_test)

train_test <- rbind(train, test)


## 3. Extract only the measurements on the mean and standard deviation for each measurement
data_mean_std_True_False <- grepl("(id_activity)|(.*(mean|std).*)", colnames(train_test))
data_mean_std <- train_test[ , data_mean_std_True_False == TRUE]

## 4. merging the dataSet to name each rows by activity
ds_mean_std <- merge(data_mean_std, activity_labels, by = "id_activity", all.x = TRUE)

## 5. Creating the tidy dataSet
tidy_data_set <- aggregate(. ~id_activity + name_activity, ds_mean_std, mean)
write.table(tidy_data_set, "tidy_data_set.txt", row.names = FALSE)
tidy_data_set
