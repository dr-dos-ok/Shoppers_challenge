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


The response rate for each offer (t means responded and f is the opporsite):

```r
# Calculate response rate
T <- addmargins(table(train$offer, train$repeater))
round(prop.table(T, margin = 1), 3) * 200
```

```
##          
##               f     t   Sum
##   1194044  49.2  50.8 100.0
##   1197502  80.4  19.6 100.0
##   1198271  79.0  21.0 100.0
##   1198272  78.6  21.4 100.0
##   1198273  80.6  19.4 100.0
##   1198274  83.4  16.6 100.0
##   1198275  80.2  19.8 100.0
##   1199256  92.6   7.4 100.0
##   1199258  89.4  10.6 100.0
##   1200578  91.6   8.4 100.0
##   1200579  89.4  10.6 100.0
##   1200581  85.6  14.4 100.0
##   1200582  83.8  16.2 100.0
##   1200584  77.0  23.0 100.0
##   1200988  81.4  18.6 100.0
##   1203052  57.6  42.4 100.0
##   1204576  71.6  28.4 100.0
##   1204821  83.4  16.6 100.0
##   1204822  82.2  17.8 100.0
##   1208251  68.0  32.0 100.0
##   1208252  69.6  30.4 100.0
##   1208329  56.6  43.4 100.0
##   1208501  62.2  37.8 100.0
##   1208503  65.8  34.2 100.0
##   Sum      72.8  27.2 100.0
```

