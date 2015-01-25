
library(data.table)
library(reshape2)

# read X_test & Y_test data.
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

#Assign column names in X_test using values from features
#read the features or column names into a data frame
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
names(X_test) = features
#Filter features which has mean or standard deviation in the values
filtered_features <- grepl("mean|std", features)
# Use the filtered features only from the X_test i,e apply column filter based on filtered_features. After this X_test is ready
X_test = X_test[,filtered_features]

# Read the activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
# fetch activity labels corresponding to activity ids in Y_test and add as one column with activity id into Y_test
Y_test[,2] = activity_labels[Y_test[,1]]
names(Y_test) = c("Activity_ID", "Activity_Label")
#read the subjects_test which has subject ids
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test) = "subject"
subject_test <- as.data.table(subject_test)
# Bind subject_test, X_test and Y_test data
test_data <- cbind(subject_test, Y_test, X_test)
# Read and apply same processing to X_train & Y_train like X_test and Y_test.
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
X_train = X_train[,filtered_features]
# Load activity data
Y_train[,2] = activity_labels[Y_train[,1]]
names(Y_train) = c("Activity_ID", "Activity_Label")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(X_train) = features
names(subject_train) = "subject"
subject_train <- as.data.table(subject_train)
# Bind data
train_data <- cbind(subject_train, Y_train, X_train)
# Once test and train data has been processed in same way, combine test and train data
data = rbind(test_data, train_data)
id_labels = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
#melt the data set by differentiating between ID Labels and Measurement Variables and melt on basis of measurement variables into tall lean data set
melt_data = melt(data, id = id_labels, measure.vars = data_labels)
# Calculate mean of measurement columns of melted dataset using dcast
tidy_data = dcast(melt_data, subject + Activity_Label ~ variable, mean)
write.table(tidy_data, file = "./tidy_data.txt",row.name=FALSE)