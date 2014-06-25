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


#### transactions.csv (reduced)
##### Preprocessing
I reduced the original transactions.csv file to a file that is 1 gb big using the python script `reduce_transacs.py`. The preprocesing of the reduced transactions.csv file is done in the `trans_preprocess.R` script.
The first six rows of the transactions data set are below:
```
      id chain dept category    company brand       date productsize productmeasure purchasequantity purchaseamount
1: 86246   205   99     9909  104538848 15343 2012-03-02        16.0             OZ                1           2.49
2: 86246   205   58     5824  108674585 55172 2012-03-02        16.0             OZ                1           3.29
3: 86246   205   72     7205  103500030  3830 2012-03-06         4.6             OZ                1           3.99
4: 86246   205   55     5558  104154848  5603 2012-03-07         5.8             OZ                1           1.25
5: 86246   205   58     5824 1076401474   304 2012-03-14        12.0             OZ                1           4.99
6: 86246   205   99     9909  107127979  6732 2012-03-17         7.0             OZ                2           8.38
```
The structure and summary of the data set:
```
str(trans)
Classes ‘data.table’ and 'data.frame':  15349956 obs. of  11 variables:
 $ id              : Factor w/ 310665 levels "86246","86252",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ chain           : Factor w/ 134 levels "2","3","4","6",..: 70 70 70 70 70 70 70 70 70 70 ...
 $ dept            : Factor w/ 16 levels "7","17","21",..: 16 12 14 10 12 16 16 6 6 6 ...
 $ category        : Factor w/ 20 levels "706","799","1703",..: 20 16 18 13 16 20 20 9 9 8 ...
 $ company         : Factor w/ 1572 levels "1036030","10100010",..: 381 832 242 333 1219 547 552 877 1483 268 ...
 $ brand           : Factor w/ 1881 levels "5","47","174",..: 610 1441 150 219 6 264 193 801 208 179 ...
 $ date            : chr  "2012-03-02" "2012-03-02" "2012-03-06" "2012-03-07" ...
 $ productsize     : num  16 16 4.6 5.8 12 7 22 75 50 19 ...
 $ productmeasure  : chr  "OZ" "OZ" "OZ" "OZ" ...
 $ purchasequantity: int  1 1 1 1 1 2 1 2 1 1 ...
 $ purchaseamount  : num  2.49 3.29 3.99 1.25 4.99 8.38 2.59 6.78 2.99 1.99 ...
 - attr(*, ".internal.selfref")=<externalptr> 
 
summary(trans)
          id               chain               dept            category            company            brand         
 378964359 :   92804   21     : 2099674   99     :4056598   9909   :4056598   107143070:1148035   5072   : 1154445  
 618764932 :   76957   96     :  660442   35     :2012837   2119   :1651003   101111010:1091179   6732   :  969615  
 2255653295:   63213   152    :  589492   21     :1651003   5824   :1397480   103700030: 974087   9907   :  557746  
 3465135195:   50785   214    :  571164   56     :1456645   7205   :1281663   107127979: 969615   867    :  544481  
 3288731255:   43561   101    :  539957   58     :1397480   5616   :1271415   103500030: 872567   3830   :  484670  
 3388824436:   29366   153    :  502646   72     :1281663   3509   :1086855   101200010: 545899   15889  :  423510  
 (Other)   :14993270   (Other):10386581   (Other):3493730   (Other):4604942   (Other)  :9748574   (Other):11215489  
     date            productsize     productmeasure     purchasequantity  purchaseamount    
 Length:15349956    Min.   :  0.05   Length:15349956    Min.   :-27.000   Min.   :-885.040  
 Class :character   1st Qu.:  8.00   Class :character   1st Qu.:  1.000   1st Qu.:   2.500  
 Mode  :character   Median : 13.50   Mode  :character   Median :  1.000   Median :   3.590  
                    Mean   : 28.47                      Mean   :  1.395   Mean   :   4.732  
                    3rd Qu.: 30.00                      3rd Qu.:  1.000   3rd Qu.:   5.150  
                    Max.   :768.00                      Max.   :970.000   Max.   :3153.920 
```
