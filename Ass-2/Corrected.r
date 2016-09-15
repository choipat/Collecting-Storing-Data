#########################################################################################
#3B-1
Bird.data <- read.csv("Bird Strikes.csv", header = TRUE , sep = ",",quote = "\"",fill = TRUE)

bird.data.reported <- function(bird.data.reported){
  bird.reported <- bird.data.reported
  bird.strikes.noreport <- sum(bird.reported$Reported=="")
  print(bird.strikes.noreport)
}

#bird.data.reported(Bird.data)
bird.data.reported(Bird.data)
###############################################################################################
#3B-2

Flight.date <- function(Flight.Date){
  flightdata<- Flight.Date
  
  flightdate.data <- as.Date(flightdata$FlightDate,format= "%m/%d/%Y")
  
flightdate.data.table <- table(format(flightdate.data,"%Y"))
flight.sorted <- sort(flightdate.data.table,descending = TRUE)
print(flight.sorted[12])   
 }
Flight.date(Bird.data)

#########################################################################################
#3B- 3 ( As.data.frame)
Bird.strikes.maximum <- function(Bird.strikes.maximum){
  Bird.maximum.death <- Bird.strikes.maximum
  Bird.data.maximum <- as.Date(Bird.maximum.death$FlightDate ,format="%m/%d/%Y")
  Bird.data.maximum <- data.frame(table(format(Bird.data.maximum,"%Y")))
  print(Bird.data.maximum)
}

Bird.strikes.maximum(Bird.data)
#####################################################################################
#3B-4
Airlines.birdstrikes <- function(Airlines.birdstrikes){
  airlines.data <- Airlines.birdstrikes
  airline.data <- table(airlines.data[15])
  #print(airline.data)
  maximum.birdstrikes(airline.data)
}

maximum.birdstrikes<- function(airline.data){
  airline.data <- as.data.frame(airline.data)
  View(airline.data)
  airline.data.sorted <- airline.data[with(airline.data, order(-Freq)), ]
  maximum.airline.data.sorted <- airline.data.sorted[2,] 
  cat("The airline which is not  unknown and has the maximum bird strikes is: ")
  print(maximum.airline.data.sorted) #INSTEAD OF PRINTING RETURN THIS VALUE
}

Airlines.birdstrikes(Bird.data)

#########################################################################

#3B-6 
bird.data.reported()
Flight.date()
Bird.strikes.maximum()
Airlines.birdstrikes()


double<-rbind(Bird.data,Bird.data)

quad<-rbind(double,double)

datafile<-list(Bird.data,double,quad)

time<-matrix(nrow=4,ncol =length(datafile))

for(i in 1: length(datafile)){
  time[1,i]<-system.time(bird.data.reported(datafile[[i]]))[3]
  time[2,i]<-system.time(Flight.date(datafile[[i]]))[3]
  time[3,i]<-system.time(Bird.strikes.maximum(datafile[[i]]))[3]
  time[4,i]<-system.time(Airlines.birdstrikes(datafile[[i]]))[3]
}

time
######################################################################################

data_size = c(1,2,4)
function1<-plot(data_size,time[1,],type="b",xlim = c(0.5,4.5), ylim = c(0.005,0.035), xlab = "Data size", ylab = "elapsed time")
abline(lm(time[1,]~data_size), col="red")
function2<-plot(data_size,time[2,],type="b",xlim = c(0.5,4.5), ylim = c(0.2,0.9), xlab = "Data size", ylab = "elapsed time") 
abline(lm(time[2,]~data_size), col="red")
function3<-plot(data_size,time[3,],type="b",xlim = c(0.5,4.5), ylim = c(0.8,3.0), xlab = "Data size", ylab = "elapsed time") 
abline(lm(time[3,]~data_size), col="red")
function4<-plot(data_size,time[4,],type="b",xlim = c(0.5,4.5), ylim = c(0.005,0.04), xlab = "Data size", ylab = "elapsed time") 
abline(lm(time[4,]~data_size), col="red")
