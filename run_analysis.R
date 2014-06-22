# RESET WORKSPACE
rm(list=ls())

# LOAD LIBRARIES
require(data.table)

# LOAD DATA
## activity label
activity_labels <- as.data.frame(fread("./getdata-004/data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors=TRUE))
setnames(activity_labels, c("activity_id", "activity"))

## subject
subject <- as.data.frame(rbind(fread("./getdata-004/data/UCI HAR Dataset/test/subject_test.txt"), fread("./getdata-004/data/UCI HAR Dataset/train/subject_train.txt")))
setnames(subject, "subject")

## meaurement labels
x_labels <- fread("./getdata-004/data/UCI HAR Dataset/features.txt")

## measurement
x <- as.data.frame(rbind(read.fwf(file="./getdata-004/data/UCI HAR Dataset/test/X_test.txt", widths=rep(c(16), 561)), read.fwf(file="./getdata-004/data/UCI HAR Dataset/train/X_train.txt", widths=rep(c(16), 561))))
setnames(x, x_labels$V2)

## activity
y <- as.data.frame(rbind(fread("./getdata-004/data/UCI HAR Dataset/test/y_test.txt"), fread("./getdata-004/data/UCI HAR Dataset/train/y_train.txt")))
setnames(y, "activity_id")

# MERGE DATASETS
final <- cbind(merge(activity_labels, y, by="activity_id", all=TRUE), subject, x)

# SUBSET
## extract only identifying columns (1, 2) and columns with "-mean()" or "-std()" in the name
extractCols = c(2, 3, grep("[-]mean[(][)]|[-]std[(][)]", names(final)))
final <- subset(final, select=extractCols)

# CLEAN WORKSPACE
rm(activity_labels, subject, x_labels, y, x)

# TIDY DATA
## clean up column names
setnames(final, sub("[(][])]", "", names(final)))

## save tidied input data
write.table(x=final, file="./getdata-004/data/activity_by_subject.txt")

# CALCULATE AVERAGE BY SUBJECT AND ACTIVITY
final_avg <- aggregate(.~subject + activity, FUN=mean, data=final)

# Save averages to disk
write.table(x=final_avg, file="./getdata-004/data/activity_average.txt")
