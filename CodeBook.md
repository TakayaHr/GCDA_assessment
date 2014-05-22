CodeBook for GCD Course Project
=============================================================

```
## [1] "2014-05-22 12:31:01 JST"
```


In this CodeBook, I will reffer to the variables and row names in the table "tidy_data.txt". The cleaning process I took is reffered in "README.md." The tidy data has 12 rows and 66 variables.

The values in each cell
-----------------------------
The title of the raw data is "Human Activity Recognition Using Smartphones Dataset." Volunteers performed six activities and took the record with smarphones. They could measured the acceleration and velocity at a constant rate of 50Hz because these smartphones have ccelerometer and gyroscope. 

I calculated the average values of mesured aceceleration and velocity per each acitivities and variables and showed in the tidy data. The type of the values are numeric.

activity labels (Rows)
------------------------
The volunteers recieved training and took a test.Traing data is from the first line to the sixth line, and test data is in the bottom lines. Each of the data has six activity labels;

```r
setwd("./UCI HAR Dataset")
activity.label <- read.table("activity_labels.txt", header = FALSE)
levels(activity.label[, 2])
```

```
## [1] "LAYING"             "SITTING"            "STANDING"          
## [4] "WALKING"            "WALKING_DOWNSTAIRS" "WALKING_UPSTAIRS"
```

SO, I made 12 rows in the tidy data.

```r
tidy.data <- read.table("tidy_data.txt")
rownames(tidy.data)
```

```
##  [1] "train: WALKING"            "train: WALKING_UPSTAIRS"  
##  [3] "train: WALKING_DOWNSTAIRS" "train: SITTING"           
##  [5] "train: STANDING"           "train: LAYING"            
##  [7] "test: WALKING"             "test: WALKING_UPSTAIRS"   
##  [9] "test: WALKING_DOWNSTAIRS"  "test: SITTING"            
## [11] "test: STANDING"            "test: LAYING"
```


Variables (columns)
----------------------
The variables mean the features selections in the two experiment - the training and the test. 

```r
colnames(tidy.data)
```

```
##  [1] "tBodyAcc.mean...X"           "tBodyAcc.mean...Y"          
##  [3] "tBodyAcc.mean...Z"           "tBodyAcc.std...X"           
##  [5] "tBodyAcc.std...Y"            "tBodyAcc.std...Z"           
##  [7] "tGravityAcc.mean...X"        "tGravityAcc.mean...Y"       
##  [9] "tGravityAcc.mean...Z"        "tGravityAcc.std...X"        
## [11] "tGravityAcc.std...Y"         "tGravityAcc.std...Z"        
## [13] "tBodyAccJerk.mean...X"       "tBodyAccJerk.mean...Y"      
## [15] "tBodyAccJerk.mean...Z"       "tBodyAccJerk.std...X"       
## [17] "tBodyAccJerk.std...Y"        "tBodyAccJerk.std...Z"       
## [19] "tBodyGyro.mean...X"          "tBodyGyro.mean...Y"         
## [21] "tBodyGyro.mean...Z"          "tBodyGyro.std...X"          
## [23] "tBodyGyro.std...Y"           "tBodyGyro.std...Z"          
## [25] "tBodyGyroJerk.mean...X"      "tBodyGyroJerk.mean...Y"     
## [27] "tBodyGyroJerk.mean...Z"      "tBodyGyroJerk.std...X"      
## [29] "tBodyGyroJerk.std...Y"       "tBodyGyroJerk.std...Z"      
## [31] "tBodyAccMag.mean.."          "tBodyAccMag.std.."          
## [33] "tGravityAccMag.mean.."       "tGravityAccMag.std.."       
## [35] "tBodyAccJerkMag.mean.."      "tBodyAccJerkMag.std.."      
## [37] "tBodyGyroMag.mean.."         "tBodyGyroMag.std.."         
## [39] "tBodyGyroJerkMag.mean.."     "tBodyGyroJerkMag.std.."     
## [41] "fBodyAcc.mean...X"           "fBodyAcc.mean...Y"          
## [43] "fBodyAcc.mean...Z"           "fBodyAcc.std...X"           
## [45] "fBodyAcc.std...Y"            "fBodyAcc.std...Z"           
## [47] "fBodyAccJerk.mean...X"       "fBodyAccJerk.mean...Y"      
## [49] "fBodyAccJerk.mean...Z"       "fBodyAccJerk.std...X"       
## [51] "fBodyAccJerk.std...Y"        "fBodyAccJerk.std...Z"       
## [53] "fBodyGyro.mean...X"          "fBodyGyro.mean...Y"         
## [55] "fBodyGyro.mean...Z"          "fBodyGyro.std...X"          
## [57] "fBodyGyro.std...Y"           "fBodyGyro.std...Z"          
## [59] "fBodyAccMag.mean.."          "fBodyAccMag.std.."          
## [61] "fBodyBodyAccJerkMag.mean.."  "fBodyBodyAccJerkMag.std.."  
## [63] "fBodyBodyGyroMag.mean.."     "fBodyBodyGyroMag.std.."     
## [65] "fBodyBodyGyroJerkMag.mean.." "fBodyBodyGyroJerkMag.std.."
```

kind of signal;

-"X","Y" or "Z" mean the directions of the aceceleration or velocity.
-"Jark","Gyro", etc. mean the values were derived to each kind of signals. 

kind of calculating;

-"t" means the values are the magnitude of signals and were calculated by the Euclidean norm.   
-"f" means the values were processed FFT (Fast Fourier Transform) so that we can check the frequency of these sifgnals.
-"mean" means the values are average values.
-"std" means the values are standard deviation values.


License of the raw data
-----------------------------
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

