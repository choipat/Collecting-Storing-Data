

library(RSQLite)
database <- dbConnect(SQLite(),dbname="BIRD.new.sqlite")

#Bird.data <- read.csv("Bird Strikes.csv", header=TRUE)
Bird.data <- read.csv("Bird Strikes.csv",header = T)

# reading the csv file into the system

#Aircraft

Aircraft.data <- unique(cbind.data.frame
                            (as.character(Bird.data$Aircraft..Type),
                            as.character(Bird.data$Aircraft..Make.Model),
                            as.character(Bird.data$Aircraft..Flight.Number),
                            as.character(Bird.data$Aircraft..Number.of.engines.)))

colnames(Aircraft.data) <- c("Type of airplane","Make of model","Flight number", "Number of engines")
#chaning col names 


Aircraft.data$Bird.data_newID <- sample(1:nrow(Aircraft.data))

View(Aircraft.data)

# creating unique Id 
dbWriteTable(conn = database, name = "Aircraft_new_table", value = Aircraft.data,
             row.names = F)


Aircraft_merge <- merge(Bird.data, Aircraft.data, by.x=c("Aircraft..Type",
                                                             "Aircraft..Make.Model",
                                                             "Aircraft..Flight.Number",
                                                             "Aircraft..Number.of.engines."),
                        by.y=c("Type of airplane",
                               "Make of model",
                               "Flight number", 
                               "Number of engines"))

#dbListFields(database,"Aircraft_new_table")
dbGetQuery(database, "SELECT [Flight number],[Number of engines] from Aircraft_new_table")

#Works fine till here 
#Wrote a table =, inserted the data merged with the parent data 
# Querired the type of columns we need from the table 


#Birdstrike

Birdstrike.data <- unique(cbind.data.frame(as.character(Bird.data$Effect..Impact.to.flight),
                                      as.character(Bird.data$Effect..Other),
                                      as.character(Bird.data$Reported..Date),
                                      as.character(Bird.data$Remains.of.wildlife.collected.),
                                      as.character(Bird.data$Pilot.warned.of.birds.or.wildlife.),
                                      as.character(Bird.data$When..Time..HHMM.),
                                      as.character(Bird.data$When..Time.of.day),
                                      as.character(Bird.data$Remains.of.wildlife.sent.to.Smithsonian)))


colnames(Birdstrike.data) <- c("Impact",
                          "Other effect",
                          "Reported Date",
                          "Remians collected",
                          "Pilot warned",
                          "Time HHMM",
                          "Time of day",
                          "Smithsonian collection")
#nrow(Birdstrike)

Birdstrike.data$BirdstrikeID <- sample(32436:nrow(Birdstrike.data))
View(Birdstrike.data)


Birdstrike_merge  <- merge(Aircraft_merge,Birdstrike.data,
                           by.x=c("Effect..Impact.to.flight",
                                  "Effect..Other",
                                  "Reported..Date",
                                  "Remains.of.wildlife.collected.",
                                  "Pilot.warned.of.birds.or.wildlife.",
                                  "When..Time..HHMM.",
                                  "When..Time.of.day",
                                  "Remains.of.wildlife.sent.to.Smithsonian")
                           
                           , by.y=c("Impact",
                                    "Other effect",
                                    "Reported Date",
                                    "Remians collected",
                                    "Pilot warned",
                                    "Time HHMM",
                                    "Time of day",
                                    "Smithsonian collection"))

dbWriteTable(conn = database , name = "Birdstrike_new_table", value = Birdstrike_merge,row.names = F)
dbGetQuery(database,"SELECT [When..Time.of.day],[Remains.of.wildlife.sent.to.Smithsonian] from Birdstrike_new_table")


#dbWriteTable(conn = database , name = "Birdstrike_new_table_final", value = Birdstrike.data,row.names = F)
#Here we are inserting the original data and not merged data, so the col names will be the ones which we changed 
#dbListFields(database,"Birdstrike_new_table_final")
#this table will have data of original bird.data and hence the col names will be changed 
#dbGetQuery(database,"SELECT [Impact],[Other effect] from Birdstrike_new_table_final")

# this gives me the result of Impact and Other effect from the table 

#Wildlife
Wildlife  <- unique(cbind.data.frame(as.character(Bird.data$Wildlife..Number.struck),
                                     as.character(Bird.data$Wildlife..Size)))


colnames(Wildlife) <- c("Wildlife struck","Wildlifesize") 
Wildlife$ID <- sample(19:nrow(Wildlife))
View(Wildlife)


Wildlife_merge <- merge(Birdstrike_merge,Wildlife,
                        by.x = c("Wildlife..Number.struck",
                                 "Wildlife..Size"),
                        by.y = c("Wildlife struck",
                                 "Wildlifesize"))

dbWriteTable(database,name = "Wildlife_table", value = Wildlife_merge, row.names = F)

dbGetQuery(database,"SELECT [Wildlife..Number.struck],
           [Wildlife..Size] from  Wildlife_table")





#Airport
Airport <- unique(cbind.data.frame(as.character(Bird.data$Airport..Name),
                                   as.character(Bird.data$Record.ID)))

nrow(Airport)
Airport$AirportID <- sample(99404:nrow(Airport))

Airport_merge <- cbind.data.frame(Wildlife_merge,Airport$AirportID)

dbWriteTable(database,name = "Airport_table", value = Airport_merge, row.names = F)
dbGetQuery(database,"SELECT [Airport..Name] from Airport_table")


#Operations                         
Operations <- unique(cbind.data.frame(as.character(Bird.data$Aircraft..Airline.Operator),
                                      as.character(Bird.data$Origin.State),
                                      as.character(Bird.data$When..Phase.of.flight),
                                      as.character(Bird.data$Conditions..Precipitation),
                                      as.character(Bird.data$Altitude.bin),
                                      as.character(Bird.data$Conditions..Sky)))


colnames(Operations) <- c("operator","origin","phase","precipitation","altitude","conditions")

Operations$OperationsID <- sample(24531:nrow(Operations))

Operations_merge_final <- merge(Airport_merge,Operations,
                          by.x =  c("Aircraft..Airline.Operator",
                                    "Origin.State",
                                    "When..Phase.of.flight",
                                    "Conditions..Precipitation",
                                    "Altitude.bin",
                                    "Conditions..Sky"),
                          by.y = c("operator","origin","phase","precipitation","altitude","conditions"))

dbWriteTable(database, name = "Operations_table",value = Operations_merge_final, row.names = F)


#Operations_merge_exp <- cbind.data.frame(Airport_merge,Operations$OperationsID)

dbGetQuery(database, "SELECT [When..Phase.of.flight],
           [Conditions..Precipitation] from Operations_table")

Operations_merge_final$Aircraft_data_newID
Operations_merge_final$BirdstrikeID
Operations_merge_final$ID
View(Operations_merge_final)
