#Assignment 3A:

#Problem1:
getwd()

getwd()
install.packages("lubridate")
library(lubridate)
investment_info<-read.csv("Acquisitions.csv", header = T, sep = ",", quote="\"", dec= "T")

#Problem2:
leastInvInterval<-function(leastInvInterval) {
  investmentinfo<-leastInvInterval
  leastInvInterval<-as.Date(investmentinfo$Date, format = "%m/%d/%Y")
  leastInvInterval<-c(diff(leastInvInterval))
  leastInvInterval<-min(leastInvInterval,na.rm = FALSE)
  cat("the smallest duration is", "\"")
  print(leastInvInterval)
}
leastInvInterval(investment_info)

#Assignment 3B:

#Problem1:
BirdStrikes_info<-read.csv("Bird Strikes.csv", header = T, sep = ",", quote="\"")
strikes_unreported <- function (strikes_unreported) {
  strikes <- strikes_unreported
  strikes_unreported <-sum(strikes$Reported=="")
  cat("The number of bird strikes that were not reported are", "\"")
  print(strikes_unreported)
}
strikes_unreported(BirdStrikes_info)

#Problem2:
maxbirdstrikes_year<- function (maxbirdstrikes_year) {
  strikes <- maxbirdstrikes_year
  maxbirdstrikes_year<-as.Date(strikes$FlightDate, format="%m/%d/%Y")
  maxbirdstrikes_year<-table(format(maxbirdstrikes_year, "%Y"))
  maxbirdstrikes_year<-sort(maxbirdstrikes_year,dec = T)
  maxbirdstrikes_year<-maxbirdstrikes_year[1]
  cat("The maximum bird strikes are for the year")
  print(maxbirdstrikes_year)
}
maxbirdstrikes_year(BirdStrikes_info)

#Problem3:
birdstrikes_year <- function (birdstrikes_year) {
  strikes <- birdstrikes_year
  birdstrikes_year <- as.Date(strikes$FlightDate, format="%m/%d/%Y")
  birdstrikesc_year <- table(format(birdstrikes_year, "%Y"))
  birdstrikes_year <- as.data.frame(birdstrikes_year)
  cat("The bird strikes for each ydear are:")
  print(birdstrikes_year)
  class_birdstrikesinfo <- class(birdstrikes_year)
  cat("The class of bird strikes info for each year is")
  print(class_birdstrikesinfo)
}
birdstrikes_year(BirdStrikes_info)

#Problem4:
birdstrikes_airline <- function (birdstrikes_airline) {
  strikes <- birdstrikes_airline
  birdstrikes_airline <- table(strikes[15])
  birdstrikes_airline
  maxbirdstrikes_airline(birdstrikes_airline) #STORE THIS FUNCTION CALL IN SOME VARIABLE AND THEN PRINT THAT VARIABLE IN NEXT LINE.
  
}

maxbirdstrikes_airline <- function (birdstrikes_airline) {
  birdstrikes_airline_dataframe <- as.data.frame(birdstrikes_airline)
  maxbirdstrikes_airline <- birdstrikes_airline_dataframe[with(birdstrikes_airline_dataframe, order(-Freq)), ]
  secondhighestbirdstrikes_airline <- maxbirdstrikes_airline[2,]
  cat("The airline that is not unknown and has maximum bird strikes is: ")
  print(secondhighestbirdstrikes_airline) #INSTEAD OF PRINTING RETURN THIS VALUE
}

birdstrikes_airline(BirdStrikes_info)

#Problem6:
double<-rbind(BirdStrikes_info,BirdStrikes_info)
quad<-rbind(double,double)
datafile<-list(BirdStrikes_info,double,quad)
time<-matrix(nrow=4,ncol =length(datafile))
for(i in 1: length(datafile)){
  time[1,i]<-system.time(strikes_unreported(datafile[[i]]))[3]
  time[2,i]<-system.time(maxbirdstrikes_year(datafile[[i]]))[3]
  time[3,i]<-system.time(birdstrikes_year(datafile[[i]]))[3]
  time[4,i]<-system.time(birdstrikes_airline(datafile[[i]]))[3]
}
time