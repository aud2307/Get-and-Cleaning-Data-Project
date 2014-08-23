#Create a directory where to store the files
if(!file.exists("Project")){
  dir.create("Project")
}


# Unzip the folder
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# create a temporary directory
td = tempdir()
# create the placeholder file
tf = tempfile(tmpdir=td, fileext=".zip")
# download into the placeholder file
download.file(fileURL, tf)


# unzip the file to the temporary directory
fname = unzip(tf, exdir=td, overwrite=TRUE)

# fpath is the full path to the extracted file
fpath = file.path(td, fname)


#Unzip and import some files
#data <- fname[grep("features.txt",fname)]  - to know the position of files.. eg X_test is in position 15

subject_test<-read.table(fname[14])
X_test<-read.table(fname[15])                   
y_test<-read.table(fname[16]) 


#Import and read  all x-train related files in R
subject_train<-read.table(fname[26])
X_train<-read.table(fname[27])                   
y_train<-read.table(fname[28]) 


#Create the labels
#read feature data frame and skip the first column for feature
feature <- read.table(fname[2],colClasses=c("NULL",NA))


#Merge both data frame
df3 <-rbind(X_test,X_train)

#set the name of the merged data frame df3
names(df3) <- t(feature)


#Q2 - Extracts only the measurements for mean and standard deviation
#match only the mean and leaving the MeanFreqData
toMatch <- c("-mean[^Freq]","-std")
df4 <- df3[,grepl(paste(toMatch,collapse="|"),as.character(names(df3)),perl=TRUE)]


#Q3: Append Subject and activity names
yFinal <- rbind(y_test,y_train)
names(yFinal) <- c("Activity")
subjectFinal <- rbind(subject_test,subject_train)
names(subjectFinal) <- c("Subject")

df5 <- cbind(subjectFinal,df4,yFinal)

#Create a new vector contains activity labels
Activity <- read.table(fname[1])


#Assign the activity label to the code in df5 data frame
df5$Activity <- factor(df5$Activity,labels=Activity$V2)

#Q4: Editing variables names (lecture 4 for reference)
#gsub is used to match and replace patterns
names(df5) <- gsub("-|\\()","",names(df5))

#Q5
#Group data by subject and activity


df6 <- aggregate(df5[,2:67], by=list(df5$Subject,df5$Activity) , FUN = "mean")

#create the tidy data frame in the correny working directory
write.table(df6,"tidy_file.txt",row.names=FALSE)



