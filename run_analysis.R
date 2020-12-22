#run_analysis.R
#Merges the training and the test sets to create one data set.
Set <- rbind(x_train, x_test)
Label <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Set, Label)

#Extracts only the measurements on the mean and standard deviation for each measurement. 
Data <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

#Uses descriptive activity names to name the activities in the data set
Data$code <- activities[Data$code, 2]

#Appropriately labels the data set with descriptive variable names.
names(Data)[2] = "activity"
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("^t", "Time", names(Data))
names(Data)<-gsub("^f", "Frequency", names(Data))
names(Data)<-gsub("tBody", "TimeBody", names(Data))
names(Data)<-gsub("-mean()", "Mean", names(Data), ignore.case = TRUE)
names(Data)<-gsub("-std()", "StandardDeviation", names(Data), ignore.case = TRUE)
names(Data)<-gsub("-freq()", "Frequency", names(Data), ignore.case = TRUE)
names(Data)<-gsub("angle", "Angle", names(Data))
names(Data)<-gsub("gravity", "Gravity", names(Data))

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Data2 <- Data %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean))

#Converting Dataset to text file
write.table(Data2, "FinalData.txt", row.name=FALSE)
