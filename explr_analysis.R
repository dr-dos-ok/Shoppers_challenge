# read trainHistory.csv in
readLines("data/trainHistory.csv",n=5)
train<-read.csv("data/trainHistory.csv",header=TRUE,sep=",")

# Explore
head(train)
summary(train)

# Convert necesary columns to factors
train[,1:4]<-lapply(train[,1:4],as.factor)

# Calculate response rate
T<-addmargins(table(train$offer,train$repeater))
names(T)
round(prop.table(T,margin=1),2)*200
