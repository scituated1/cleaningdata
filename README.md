
Wearable Data Analysis
=================================================================
This script creates a wide tidy data set from he data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The script does the following:

1.  Loads 3 packages used for cleaning and tidying the data.    These 3 packages must be downloaded prior to execution of this script.
	*	plyr
	*	dplyr
	*	tidyr
2.  If the data set has not already been downloaded and unzipped to your working directory,
	
	* downloads the .zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
	* unzips the file into your working directory in ./UCI HAR Dataset directory
	* saves the date downloaded

3.  Load the provided data into R
	The data in the UCI HAR Dataset directory has 2 subdirectories /test and /train that each contain
	* an X file - a table of 561 variables captured or calculated in this experiment
	* a Y file - a corresponding list of the activity being performed for each observation in the X file
	* a subject file - a corresponding list of the subject carrying the device for each observation in the X file
	The root ./UCI HAR Dataset directory contains label files for the X and Y files:
	*  features.txt contains the column names for the X file.
	*  activity_lables.txt is the translation for the activity numbers in the Y file
	
	Each of the 8 files is loaded into a dataframe for processing.

4.  The label dataframes are converted to vectors.  The features list is appled to the X files 
	to prepare for merging.

5.  Complete Train and Test files are created by using CBIND() to combined the Subject, Y and X files from each.

6.  All_data is created,  It is a combined dataset containing 563 columns and 10299 rows (both train and test).

7.  All original files train & test X, y and subject as well as the 2 Complete Test and Train files created in Step 5 are removed.

8.  Mean_std_data is created - it contains 88 columns - Subject, Activity and 85 feature variables that contain mean or std dev of the observed data.   The values for the activities have been replaced with their corresponding label values.

9.   tidy_data is created.  It is a summary data set which contains the mean of each of the 85 feature variables for each combination of Activity and Subject.

10.  The tidy_data is written to ./project_output.txt in the current working directory.
	

INPUT Data

==================================================================
The following information is from the "ReadMe" file for the input dataset used for this analysis.  The listed files can be found in the UCI HAR Dataset directory created by the script when the .zip file is first downloaded.

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================k
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
