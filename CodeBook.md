Codebook
========
Variable list and descriptions
------------------------------

Variable name     | Description
------------------|------------
Subject.ID        | ID the subject who performed the activity for each window sample. Its range is from 1 to 30.
Activity          | Activity name
featureGatherType | Feature: Time domain signal or frequency domain signal (Time or Freq)
featureInstrument | Feature: Measuring instrument (Accelerometer or Gyroscope)
accelarationSignal| Feature: Acceleration signal (Body or Gravity)
featureValueType  | Feature: Variable (Mean or SD)
isJerkSignal      | Feature: Jerk signal
isEuclideanNorm   | Feature: Is feature Magnitude of the signals calculated using the Euclidean norm
featureAxis       | Feature: 3-axial signals in the X, Y and Z directions (X, Y, or Z)
featAverage       | Feature: Average of each variable for each activity and each subject

Dataset structure
-----------------


```r
data.root <- "C:/Dev/Src/Coursera_DataScience/Getting_Clearning_Data/course_project/GetCleanDataCourseProject/UCI HAR Dataset"
dfTidy <- read.table(file.path(data.root, "output.txt"), header = TRUE)
str(dfTidy)
```

```
## 'data.frame':	11880 obs. of  10 variables:
##  $ Subject.ID        : int  1 1 1 1 1 1 2 2 2 2 ...
##  $ Activity.Name     : Factor w/ 6 levels "LAYING","SITTING",..: 1 2 3 4 5 6 1 2 3 4 ...
##  $ featureGatherType : Factor w/ 2 levels "f","t": 2 2 2 2 2 2 2 2 2 2 ...
##  $ featureValueType  : Factor w/ 2 levels "mean()","std()": 1 1 1 1 1 1 1 1 1 1 ...
##  $ featureAxis       : Factor w/ 3 levels "X","Y","Z": 1 1 1 1 1 1 1 1 1 1 ...
##  $ accelarationSignal: Factor w/ 2 levels "Body","Gravity": 1 1 1 1 1 1 1 1 1 1 ...
##  $ featureInstrument : Factor w/ 2 levels "Accelerometer",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ isJerkSignal      : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ isEuclideanNorm   : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ avg.value         : num  0.222 0.261 0.279 0.277 0.289 ...
```

List the key variables in the data table
----------------------------------------


```r
colnames(dfTidy)
```

```
##  [1] "Subject.ID"         "Activity.Name"      "featureGatherType" 
##  [4] "featureValueType"   "featureAxis"        "accelarationSignal"
##  [7] "featureInstrument"  "isJerkSignal"       "isEuclideanNorm"   
## [10] "avg.value"
```

Show a few rows of the dataset
------------------------------


```r
head(dfTidy)
```

```
##   Subject.ID      Activity.Name featureGatherType featureValueType
## 1          1             LAYING                 t           mean()
## 2          1            SITTING                 t           mean()
## 3          1           STANDING                 t           mean()
## 4          1            WALKING                 t           mean()
## 5          1 WALKING_DOWNSTAIRS                 t           mean()
## 6          1   WALKING_UPSTAIRS                 t           mean()
##   featureAxis accelarationSignal featureInstrument isJerkSignal
## 1           X               Body     Accelerometer        FALSE
## 2           X               Body     Accelerometer        FALSE
## 3           X               Body     Accelerometer        FALSE
## 4           X               Body     Accelerometer        FALSE
## 5           X               Body     Accelerometer        FALSE
## 6           X               Body     Accelerometer        FALSE
##   isEuclideanNorm avg.value
## 1           FALSE 0.2215982
## 2           FALSE 0.2612376
## 3           FALSE 0.2789176
## 4           FALSE 0.2773308
## 5           FALSE 0.2891883
## 6           FALSE 0.2554617
```

Summary of variables
--------------------


```r
summary(dfTidy)
```

```
##    Subject.ID              Activity.Name  featureGatherType
##  Min.   : 1.0   LAYING            :1980   f:4680           
##  1st Qu.: 8.0   SITTING           :1980   t:7200           
##  Median :15.5   STANDING          :1980                    
##  Mean   :15.5   WALKING           :1980                    
##  3rd Qu.:23.0   WALKING_DOWNSTAIRS:1980                    
##  Max.   :30.0   WALKING_UPSTAIRS  :1980                    
##  featureValueType featureAxis accelarationSignal     featureInstrument
##  mean():5940      X   :2880   Body   :10440      Accelerometer:7200   
##  std() :5940      Y   :2880   Gravity: 1440      Gyroscope    :4680   
##                   Z   :2880                                           
##                   NA's:3240                                           
##                                                                       
##                                                                       
##  isJerkSignal    isEuclideanNorm   avg.value       
##  Mode :logical   Mode :logical   Min.   :-0.99767  
##  FALSE:7200      FALSE:8640      1st Qu.:-0.96205  
##  TRUE :4680      TRUE :3240      Median :-0.46989  
##  NA's :0         NA's :0         Mean   :-0.48436  
##                                  3rd Qu.:-0.07836  
##                                  Max.   : 0.97451
```
