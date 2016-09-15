sample.data <- read.csv(file = file.choose())




Timedifference  <- read.table("Acquisitions.csv", header = TRUE, sep = ",", quote = "\"")
########################################################################################
#1A
library("lubridate")

timedifference <- function(timeinterval){
timeinterval1 <- read.table("Acquisitions.csv", header = TRUE,sep = ",",quote ="\"" )
timeinterval<- as.Date(timeinterval,format="%m/%d/%Y")
#timeinterval <-as.Date(sample.data$Date,format="%m/%d/%Y")
diff(timeinterval)
print(diff(timeinterval))
min(diff(timeinterval))
print(min(diff(timeinterval)))
}

timedifference()


###############################################
#2-1)
Bird.data <- read.table("Bird Strikes.csv", header = TRUE , sep = ",",quote = "\"",fill = TRUE)

bird.data.reported <- function(Bird.data1){
bird.strikes.noreport <- sum(Bird.data$Reported=="")
print(bird.strikes.noreport)
  }

#bird.data.reported(Bird.data)
bird.data.reported()

######################################################################

#2-2

Flight.date <- function(Maximum.date){
Bird.data.1 <- as.Date(Bird.data$FlightDate ,format = "%m/%d/%Y")
table.data <- table(format(Bird.data.1,"%Y"))
print(table.data)
R <- print(max(table(format(Bird.data.1,"%Y"))))

print("The year which had the maximum bird strikes is R")
# Print the answer here
}

Flight.date()

system.time(Flight.date())



#########################################################################
#2-3
Flight.data <- function(Maximum.dataframe){
  Bird.data.1 <- as.Date(Bird.data$FlightDate ,format = "%m/%d/%Y")
  table.dataframe <- data.frame(table(format(Bird.data.1,"%Y")))
  print(table.dataframe)
print(class(table.dataframe))
  }

sample.data <- Bird.data[c(1:100),]


Flight.data(Bird.data.1)

#system.time(Flight.data(Bird.data))
Flight.data(sample.data)
sample.data <- head(Bird.data)




#########################################################################
#2-4
A <- Bird.data[15]

A1 <- table(A)

names(A1)


View(A1)


B <- sort(A1,decreasing = TRUE)


print(B[2])
#########################################################################

system.time(Flight.date())
system.time(Flight.data())


system.time(bird.data.reported())

E <-paste(system.time(list.function.a))
print(E)




double <- rbind(Bird.data,Bird.data)
quad <- rbind(double,double)
eight <- rbind(quad,quad)

datafile<- list(double,quad,eight)

View(datafile)

time <- matrix(nrow=3,ncol=length(datafile)) 


View(time)

for(i in 1:length(datafile)) {
time[1,i]<- paste(system.time(Flight.date((datafile[[i]]))))
                  print(i)

                  }


time[2,i]<- system.time(Flight.data()(datafile[[i]]))
time[3,i]<- system.time(bird.data.reported()(datafile[[i]]))
print(i)
}

  



for (i in 1:length(file_list)){ 
  assign(file_list[i], 
         read.csv(paste(folder, file_list[i], sep=''))
  )}













