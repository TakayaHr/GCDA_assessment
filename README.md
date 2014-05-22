 for GCD Course Project
========================================================

```
## [1] "2014-05-22 12:29:09 JST"
```


Introduction
--------------
When we want to performing analysis, we have to clean the data set we have collected beforehand. In this report, I will make a tidy data from the data:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

I unziped this file and saved as "UCI HAR Dataset" in my working directory.

The purpose of this demonstration is making a tidy data set which has the average values of each variables for each activity and each subject.I will explain the meanings of the following variables in "CodeBook.Rmd" file.

Merging the datasets
-----------------------------
In this chapter, I loaded five files in "UCI HAR Dataset," and bind them into one data set.

I setted th working directory to "UCI HAR Dataset."

I saved the names of feature selections as a data frame "features."

```r
setwd("./UCI HAR Dataset")
features <- read.table("features.txt")
head(features)
```

```
##   V1                V2
## 1  1 tBodyAcc-mean()-X
## 2  2 tBodyAcc-mean()-Y
## 3  3 tBodyAcc-mean()-Z
## 4  4  tBodyAcc-std()-X
## 5  5  tBodyAcc-std()-Y
## 6  6  tBodyAcc-std()-Z
```

I saved the traing data into a variable "train."

```r
setwd("./UCI HAR Dataset/train")
x.train <- read.table("X_train.txt", header = FALSE)
y.train <- scan("y_train.txt")
colnames(x.train) <- as.character(features[, 2])
train <- cbind(activity = y.train, x.train)
setwd("../")
train[1:3, 1:4]
```

```
##   activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
## 1        5            0.2886          -0.02029           -0.1329
## 2        5            0.2784          -0.01641           -0.1235
## 3        5            0.2797          -0.01947           -0.1135
```

"x_train.txt" has values, and the columns are correspond to the feature names.
"y_train.txt" has values and the table is a numeric vector. This values describes the activity names.

In the same way, I saved the test data into a variable "test."

```r
setwd("./UCI HAR Dataset/test")
x.test <- read.table("X_test.txt", header = FALSE)
y.test <- scan("y_test.txt")
colnames(x.test) <- as.character(features[, 2])
test <- cbind(activity = y.test, x.test)
setwd("../")
test[1:3, 1:4]
```

```
##   activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
## 1        5            0.2572          -0.02329          -0.01465
## 2        5            0.2860          -0.01316          -0.11908
## 3        5            0.2755          -0.02605          -0.11815
```

And I made a new data set.I made a new factor variable with two levels-"train" and "test."

```r
dataset <- cbind(kind = rep(c("train", "test"), times = c(nrow(train), nrow(test))), 
    rbind(train, test))
dataset[1:3, 1:4]
```

```
##    kind activity tBodyAcc-mean()-X tBodyAcc-mean()-Y
## 1 train        5            0.2886          -0.02029
## 2 train        5            0.2784          -0.01641
## 3 train        5            0.2797          -0.01947
```


Extracting the variables
--------------------------------
We want to using only the mesurements on the mean and standard deviation. In this chapte, I extracted some columns which has these mesurements.

First, I found the columns which names include "mean()" or "std()," and arranged the column numbers in ascending order.

```r
col.mean.std <- c(grep("mean()", features[, 2]), grep("std()", features[, 2]))
col.mean.std <- c(1, 2, col.mean.std[order(col.mean.std)] + 2)
col.mean.std
```

```
##  [1]   1   2   3   4   5   6   7   8  43  44  45  46  47  48  83  84  85
## [18]  86  87  88 123 124 125 126 127 128 163 164 165 166 167 168 203 204
## [35] 216 217 229 230 242 243 255 256 268 269 270 271 272 273 296 297 298
## [52] 347 348 349 350 351 352 375 376 377 426 427 428 429 430 431 454 455
## [69] 456 505 506 515 518 519 528 531 532 541 544 545 554
```

Next, I found the columns which names include "meanFreq()." These do not contain the mesurements we want to use.

```r
ignore.case <- grep("meanFreq()", features[, 2])
ignore.case <- c(1, 2, ignore.case[order(ignore.case)] + 2)
ignore.case <- match(ignore.case, col.mean.std)
ignore.case
```

```
##  [1]  1  2 49 50 51 58 59 60 67 68 69 72 75 78 81
```

Last, I got the new data which contains only the useful columns.

```r
(col.mean.std <- c(1, 2, col.mean.std[-(ignore.case)]))
```

```
##  [1]   1   2   3   4   5   6   7   8  43  44  45  46  47  48  83  84  85
## [18]  86  87  88 123 124 125 126 127 128 163 164 165 166 167 168 203 204
## [35] 216 217 229 230 242 243 255 256 268 269 270 271 272 273 347 348 349
## [52] 350 351 352 426 427 428 429 430 431 505 506 518 519 531 532 544 545
```

```r
dataset[1:3, 8:10]  #old data set
```

```
##   tBodyAcc-std()-Z tBodyAcc-mad()-X tBodyAcc-mad()-Y
## 1          -0.9135          -0.9951          -0.9832
## 2          -0.9603          -0.9988          -0.9749
## 3          -0.9789          -0.9965          -0.9637
```

```r
new.data <- dataset[, col.mean.std]
new.data[1:3, 8:10]  #new data set
```

```
##   tBodyAcc-std()-Z tGravityAcc-mean()-X tGravityAcc-mean()-Y
## 1          -0.9135               0.9634              -0.1408
## 2          -0.9603               0.9666              -0.1416
## 3          -0.9789               0.9669              -0.1420
```


Appropriately labels fordescriptive activity names
----------------------------------------------------------
When I merged the raw data, I got the activity names as numbers by loading "y_train.txt" and "y_test.txt." In this chapter, I converted these numbers (from 1 to 6) to descriptive activity names.

```r
setwd("./UCI HAR Dataset")
(activity.label <- read.table("activity_labels.txt", header = FALSE))
```

```
##   V1                 V2
## 1  1            WALKING
## 2  2   WALKING_UPSTAIRS
## 3  3 WALKING_DOWNSTAIRS
## 4  4            SITTING
## 5  5           STANDING
## 6  6             LAYING
```

```r
new.data[, 2] <- activity.label[match(new.data$activity, activity.label[, 1]), 
    2]
new.data[1:3, 1:4]
```

```
##    kind activity tBodyAcc-mean()-X tBodyAcc-mean()-Y
## 1 train STANDING            0.2886          -0.02029
## 2 train STANDING            0.2784          -0.01641
## 3 train STANDING            0.2797          -0.01947
```


Average of each variables
----------------------------
In this chapter, I created the tidy data set I said in the Introduction of this  file.
Because I had take the average values of two factor variables, I made a function with which we can make a subset matrix for the first factor and calculate the mean for the second factor.

```r
mean.test.train <- function(x, y) {
    subseted <- subset(x, x$kind == y)
    means <- tapply(subseted[, 3], subseted$activity, mean)
    for (i in 4:ncol(x)) {
        means <- cbind(means, tapply(subseted[, i], subseted$activity, mean))
    }
    rownames(means) <- activity.label[, 2]
    colnames(means) <- colnames(x[, 3:ncol(x)])
    means
}
```

I made the tidy data, using this function.

```r
tidy.data <- rbind(mean.test.train(new.data, "test"), mean.test.train(new.data, 
    "train"))
rownames(tidy.data) <- paste(rep(c("train: ", "test: "), times = c(6, 6)), rownames(tidy.data), 
    sep = "")
tidy.data[, 1:2]
```

```
##                           tBodyAcc-mean()-X tBodyAcc-mean()-Y
## train: WALKING                       0.2672          -0.01825
## train: WALKING_UPSTAIRS              0.2720          -0.01412
## train: WALKING_DOWNSTAIRS            0.2788          -0.01623
## train: SITTING                       0.2765          -0.01825
## train: STANDING                      0.2881          -0.01618
## train: LAYING                        0.2631          -0.02427
## test: WALKING                        0.2692          -0.01835
## test: WALKING_UPSTAIRS               0.2734          -0.01214
## test: WALKING_DOWNSTAIRS             0.2793          -0.01612
## test: SITTING                        0.2763          -0.01777
## test: STANDING                       0.2882          -0.01637
## test: LAYING                         0.2619          -0.02665
```

I saved the tidy data as a text file called "tidy_data.txt" in the working directory.

```r
write.table(tidy.data, "tidy_data.txt")
```


This is the end of my process to make a tidy data from the data set.

Data License
--------------
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
