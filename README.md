Get-and-Cleaning-Data-Project
=============================
This repository includes the following files:
- runAnalysis.R file which a R-script file containing the code to create a tidy data frame from the Human Activity Recognition Using Smartphones Dataset
The main steps are commented in the scripts. Basically there are the following:
 * Step 1: Download the Data set
          Download the folder to a Temporary directory
          Unzip the files and store them in the same directory
          Point to each element of the temporary directory ( fname)
          Read the data set with the command read.table
          
* Merge the data
           The data contains 2 data frame: X_test containing the measurements for 20 subjects and X_train containing the data for 10 subjects

           Both X_test and X_train are merged to combine all the data for the 30 subjects
           Create a new data frame df3
        
* Add column names to the new data frame

          Columns names are specified in the file feature.txt
          Read the content of this file (feature.txt) into R
          Append the feature dataframe to the combines ones using the command names(dataframe)
        
* Extract mean and standard deviation

          Only Mean() measurement and std() measurement were extracted from the combined data frame: the command grep is used to catch Mean() and std() pattern
          Create the new data frame df4
        
* Add column Subject and Activity to the new data frame df4

          Read Subject (test and train) and Y(test and train) into R and merge them to form a data frame with dim=[1,561]
          Add Subject and Activity column names to the merged data frame Subject and activity
           Append Subject and Activity dataframe to the combined data frame df4

* Replace Activity (Y) by activity labels

        Read Activity labels data frame in R
        Match the activity code in Activity column in df4 with the activity labels using factor function
        
* Clean the column names of data frame df4 as per the standards of tidy data 

        Remove the character "-" and "()"from the label by using gsub() function
    
* Group the varibles in the data frame by Subject ( 1 to 30) and by Activity name ( Walking, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS etc ..) and calculate the mean

       The function aggregate() is used on an subset of data when the calculation is done 
       Check the content of the data frame with str function to see which columns to keep in the subset
       Create the final tidy data frame with 68 variables and 180 observations
       
  
* Save the file on the working directory with the function write.table()
        
 
