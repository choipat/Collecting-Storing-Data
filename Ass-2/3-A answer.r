#loading library lubridate
library("lubridate")

#Reading the data into a file named Timedifference
Timedifference  <- read.table("Acquisitions.csv", header = TRUE, sep = ",", quote = "\"")

#Defining the function leastInvInterval
#leastInvInterval:Input timedifference calculates timedifference between two intervals
#leastInvInterval takes a particular timedifference and returns the minimum
#difference between two intervals for that #particular timedifference 
#Output : Minimum difference between two sucessive intervals of dates 

leastInvInterval <- function(timedifference){
timeinterval <- timedifference
timeinterval <- as.Date(timeinterval$Date,format="%m/%d/%Y")
diff(timeinterval)
cat("The minumium difference between two successive investments is", "\"")
print(min(diff(timeinterval,na.rm = FALSE)))
}

leastInvInterval(Timedifference)
