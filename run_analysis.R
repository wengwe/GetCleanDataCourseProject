library(dplyr)
library(tidyr)
#read the traning and test datasets.
data.root <- "C:/Dev/Src/Coursera_DataScience/Getting_Clearning_Data/course_project/GetCleanDataCourseProject/UCI HAR Dataset"
training.foler <- file.path(data.root, "train")
testing.foler <- file.path(data.root, "test")

feature.info <- read.table(file.path(data.root, "features.txt"))
feature.names <- as.character(feature.info$V2)

activity.label <- read.table(file.path(data.root, "activity_labels.txt"))
activity.label <- rename(activity.label, Activity.ID=V1, Activity.Name=V2  )

test.sub <- read.table(file.path(testing.foler, "subject_test.txt"))
test.sub <- rename(test.sub,Subject=V1)
test.data <- read.table(file.path(testing.foler, "X_test.txt"))
colnames(test.data) <- paste(colnames(test.data), feature.names, sep = "_")
test.mean.data <- select(test.data, contains("mean()"))
test.std.data <- select(test.data, contains("std()"))
test.data <- cbind(test.mean.data, test.std.data)

test.activity <- read.table(file.path(testing.foler, "y_test.txt"))
test.data$Subject.ID <- test.sub$Subject 
test.data$Activity.ID <- test.activity$V1
test.data <- left_join(test.data, activity.label)
#colnames(test.data)[1:561] <- feature.names
#colnames(test.data)[1:561] <- paste(colnames(test.data)[1:561], feature.names, sep = "_")


train.sub <- read.table(file.path(training.foler, "subject_train.txt"))
train.sub <- rename(train.sub,Subject=V1)
train.data <- read.table(file.path(training.foler, "X_train.txt"))
colnames(train.data) <- paste(colnames(train.data), feature.names, sep = "_")
train.mean.data <- select(train.data, contains("mean()"))
train.std.data <- select(train.data, contains("std()"))
train.data <- cbind(train.mean.data, train.std.data)

train.activity <- read.table(file.path(training.foler, "y_train.txt"))
train.data$Subject.ID <- train.sub$Subject 
train.data$Activity.ID <- train.activity$V1
train.data <- left_join(train.data, activity.label)


#1. Merges the training and the test sets to create one data set.
all.data <- rbind(train.data, test.data)



#2. Extracts only the measurements on the mean and standard deviation for each measurement.
# it is done already when processing the data.

#3, Uses descriptive activity names to name the activities in the data set
#4, Appropriately labels the data set with descriptive variable names.

#5, From the data set in step 4, creates a second, i
#ndependent tidy data set with the average of each variable for each activity and each subject.
summary.data <- 
  all.data %>% 
  select(-Activity.ID) %>%
  group_by(Subject.ID, Activity.Name) %>% 
  summarise_each(funs(mean))


#retouch the colnames
col.names <- colnames(summary.data)
n2 <- strsplit(col.names, split = "_")

extract.func <- function(item) {
   l <- length(item)
   if(l == 1) {
     return(item)
     }
   else {
     return(item[2])
     }
}

newnames <- sapply(n2, extract.func)
colnames(summary.data) <- newnames


#transform data format to desribe features. 
final.df <- 
  summary.data %>% 
  gather(key=feature.name, value=avg.value, -(Subject.ID:Activity.Name)) %>% 
  separate(col = feature.name , into =c("featureGatherType","feature"), sep =1) %>%
  separate(col = feature , into =c("feaureMeaureEntity","featureValueType", "featureAxis"), sep = "-", fill="right") %>%
  mutate(accelarationSignal = ifelse(grepl( "Body", feaureMeaureEntity), "Body", "Gravity")) %>% 
  mutate(featureInstrument = ifelse(grepl( "Acc", feaureMeaureEntity), "Accelerometer", "Gyroscope")) %>% 
  mutate(isJerkSignal = grepl( "Jerk", feaureMeaureEntity)) %>%
  mutate(isEuclideanNorm = grepl( "Mag", feaureMeaureEntity)) %>%
  select(Subject.ID , Activity.Name, featureGatherType, featureValueType ,featureAxis , accelarationSignal, featureInstrument, isJerkSignal, isEuclideanNorm,avg.value)

write.table(final.df, file = file.path(data.root,"output.txt"), row.name=FALSE )
