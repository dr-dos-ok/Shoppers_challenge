---
title: "Shoppers Challenge Notebook"
author: "Koba Khitalishvili & Evan Van Ness"
date: "June 24, 2014"
output: html_document
---

## Exploratory analysis
#### trainHistory.csv

Read file in and show first five rows:

```r
# read trainHistory.csv in
train <- read.csv("data/trainHistory.csv", header = TRUE, sep = ",")

head(train)
```

```
##         id chain   offer market repeattrips repeater  offerdate
## 1    86246   205 1208251     34           5        t 2013-04-24
## 2    86252   205 1197502     34          16        t 2013-03-27
## 3 12682470    18 1197502     11           0        f 2013-03-28
## 4 12996040    15 1197502      9           0        f 2013-03-25
## 5 13089312    15 1204821      9           0        f 2013-04-01
## 6 13179265    14 1197502      8           0        f 2013-03-29
```


Preprocess the data set a little:

```r
# Convert necesary columns to factors
train[, 1:4] <- lapply(train[, 1:4], as.factor)
```

The structure and summary of the data set:

```r
str(train)
```

```
## 'data.frame':	160057 obs. of  7 variables:
##  $ id         : Factor w/ 160057 levels "86246","86252",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ chain      : Factor w/ 130 levels "2","3","4","6",..: 70 70 13 10 10 9 10 9 3 3 ...
##  $ offer      : Factor w/ 24 levels "1194044","1197502",..: 20 2 2 2 18 2 12 12 17 2 ...
##  $ market     : Factor w/ 34 levels "1","2","4","5",..: 26 26 10 8 8 7 8 7 1 1 ...
##  $ repeattrips: int  5 16 0 0 0 0 0 0 0 0 ...
##  $ repeater   : Factor w/ 2 levels "f","t": 2 2 1 1 1 1 1 1 1 1 ...
##  $ offerdate  : Factor w/ 56 levels "2013-03-01","2013-03-02",..: 50 22 23 20 27 24 25 25 31 21 ...
```

```r
summary(train)
```

```
##         id             chain           offer           market     
##  86246   :     1   21     :27373   1197502:45652   10     :41724  
##  86252   :     1   152    :10967   1208329:18767   21     : 9919  
##  12682470:     1   96     : 8657   1203052:15337   27     : 8657  
##  12996040:     1   64     : 5889   1208251:15028   37     : 7700  
##  13089312:     1   360    : 5880   1199256: 7971   9      : 7648  
##  13179265:     1   46     : 5440   1204576: 7293   20     : 7438  
##  (Other) :160051   (Other):95851   (Other):50009   (Other):76971  
##   repeattrips     repeater        offerdate     
##  Min.   :   0.0   f:116619   2013-03-25: 10922  
##  1st Qu.:   0.0   t: 43438   2013-03-26:  9425  
##  Median :   0.0              2013-04-24:  9044  
##  Mean   :   0.7              2013-03-27:  7896  
##  3rd Qu.:   1.0              2013-04-23:  7554  
##  Max.   :2124.0              2013-04-25:  7099  
##                              (Other)   :108117
```

The response rate in percent for each offer (Yes means responded):

```r
# Calculate response rate
T <- addmargins(table(train$offer, train$repeater))
T <- round(prop.table(T, margin = 1), 3) * 200
T_res_rate <- data.frame(Yes = T[, 2], No = T[, 1], Sum = T[, 3])[-25, ]
T_res_rate[order(T_res_rate[, 1], decreasing = TRUE), ]
```

```
##          Yes   No Sum
## 1194044 50.8 49.2 100
## 1208329 43.4 56.6 100
## 1203052 42.4 57.6 100
## 1208501 37.8 62.2 100
## 1208503 34.2 65.8 100
## 1208251 32.0 68.0 100
## 1208252 30.4 69.6 100
## 1204576 28.4 71.6 100
## 1200584 23.0 77.0 100
## 1198272 21.4 78.6 100
## 1198271 21.0 79.0 100
## 1198275 19.8 80.2 100
## 1197502 19.6 80.4 100
## 1198273 19.4 80.6 100
## 1200988 18.6 81.4 100
## 1204822 17.8 82.2 100
## 1198274 16.6 83.4 100
## 1204821 16.6 83.4 100
## 1200582 16.2 83.8 100
## 1200581 14.4 85.6 100
## 1199258 10.6 89.4 100
## 1200579 10.6 89.4 100
## 1200578  8.4 91.6 100
## 1199256  7.4 92.6 100
```

