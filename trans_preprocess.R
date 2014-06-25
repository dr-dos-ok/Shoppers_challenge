# install.packages("data.table")
# install.packages("bit64")
library(data.table)
library(bit64)

# Reduce the transactions.csv file (takes 1 hour 32 mins on my mac)
system("python reduce_transacs.py")

# Read in the transactions.csv file using data.table package
trans<-fread("data/reduced_transactions.csv")

# Convert some columns into factors
trans[,1:6:=lapply(.SD,as.factor),.SDcols=1:6]



