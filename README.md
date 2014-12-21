tidydata
========

The project assignment for Getting and Cleaning Data Course Project
This script using the package dplyr for the some of the dataset operation
The script is divided into different sections for clarity.

Section 1, the script load the data from different files into the dataset including training data and testing data
It also read the activity code and subject code from the file

Section 2, The descriptive Field names is assigned by reading the file feature.txt. The function make.unqiue() is used to avoid the duplication of the name of some duplication

Section 3, Merge by row the training data and testing data, and merge by col the activity and subject

Section 4. Extract the Measurement with mean() and std() using the Select() of the package dplyr

Section 5. Replacing the Activity Code with the Activity description using the function modified from gsub()

Section 6. Create the tidy data by group_by() function to group the data based on the activities and subject. Then using the summarise_each() function to calculate the means of each measurement.

Section 7. Save the tidy data into the tidydata.txt file.
