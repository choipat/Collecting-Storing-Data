
#install.packages("RSQLite")
library(RSQLite)
db <- dbConnect(SQLite(),dbname = "test_data.sqlite")
summary(db)
#rm(db)

################################################################################################################
setwd("C:/Users/Michael Propp/Desktop/Information Assignemnt/Ass-10/")


library(RSQLite)
database <- dbConnect(SQLite(),dbname="BIRD.new.sqlite")

Aircraft_data <- read.csv("Bird Strikes.csv", header=TRUE)
# reading the csv file into the system

#Aircraft

Aircraft_data_new <- unique(cbind.data.frame
                            (as.character(Aircraft_data$Aircraft..Type),
                            as.character(Aircraft_data$Aircraft..Make.Model),
                            as.character(Aircraft_data$Aircraft..Flight.Number),
                            as.character(Aircraft_data$Aircraft..Number.of.engines.)))

View(Aircraft_data_new)



colnames(Aircraft_data_new) <- c("Type of aircraft","Make of model","Flight number", "Number of engines")
#chaning col names 
View(Aircraft_data_new)


Aircraft_data_new$Aircraft_data_newID <- sample(1:nrow(Aircraft_data_new))
View(Aircraft_data_new)
# creating unique Id 

dbWriteTable(conn = database, name = "Aircraft_table_new", value = Aircraft_merge,
             row.names = F)
#creating a table 

#View(dbReadTable(database,"Aircraf_table_new"))

#colnames(Aircraft_data)
colnames(Aircraft_data_new)


Aircraft_merge <- merge(Aircraft_data, Aircraft_data_new, by.x=c("Aircraft..Type",
                                    "Aircraft..Make.Model",
                                    "Aircraft..Flight.Number",
                                    "Aircraft..Number.of.engines."),
                            by.y=c("Type of aircraft",
                                    "Make of model",
                                    "Flight number", 
                                    "Number of engines"))
View(Aircraft_merge)

# mergeing the table 
####################################################################################################
#TESTING example 
Aircraft_merge_test  <- merge(Aircraft_data, Aircraft_data_new, by.x=c("Aircraft..Type",
                                                                 "Aircraft..Make.Model",
                                                                 "Aircraft..Flight.Number",
                                                                 "Aircraft..Number.of.engines."),
                        by.y=c("Type of aircraft",
                               "Make of model",
                               "Flight number", 
                               "Number of engines"))
View(Aircraft_merge_test)

dbGetQuery(database, "SELECT [Type of aircraft],[Flight number],[NUmber of engines] from Aircraft_table")

##############################################################################################################

#Birdstrike

Birdstrike <- unique(cbind.data.frame(as.character(Aircraft_data$Effect..Impact.to.flight),
                                      as.character(Aircraft_data$Effect..Other),
                                      as.character(Aircraft_data$Reported..Date),
                                      as.character(Aircraft_data$Remains.of.wildlife.collected.),
                                      as.character(Aircraft_data$Pilot.warned.of.birds.or.wildlife.),
                                      as.character(Aircraft_data$When..Time..HHMM.),
                                      as.character(Aircraft_data$When..Time.of.day),
                                      as.character(Aircraft_data$Remains.of.wildlife.sent.to.Smithsonian)))


View(Birdstrike)

colnames(Birdstrike) <- c("Impact",
                          "Other effect",
                          "Reported Date",
                          "Remians collected",
                          "Pilot warned",
                          "Time HHMM",
                          "Time of day",
                          "Smithsonian collection")

View(Birdstrike)

Birdstrike$BirdstrikeID <- sample(1:nrow(Birdstrike))
View(Birdstrike)

dbWriteTable(conn = database , name = "Birdstrike_table_new", value = Birdstrike_merge,
             row.names = F)

#dbReadTable(database ,"Birdstrike_table")



Birdstrike_merge  <- merge(Aircraft_merge,Birdstrike,
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


View(Birdstrike_merge)
#rm(Birdstrike_merge)

colnames(Birdstrike_merge)

dbGetQuery(database, "SELECT Aircraft_data_newID [Type of aircraft], [Make of model] from Birdstrike_table_new")


























# Airport
Airport <- unique(cbind.data.frame(as.character(Aircraft_data$Airport..Name),
                                      as.character(Aircraft_data$Record.ID)))

colnames(Airport) <- c("Airportname","RecordID")
#Airport$ID <- sample(1:nrow(Airport))
View(Airport)


#rm(Airport)
Airport$AirportID <- sample(1:nrow(Airport))

Airport_merge <- merge(Birdstrike_merge,Airport, 
                       by.x = c("Airport..Name",
                                 "Record.ID"),
                       by.y = c("Airportname",
                                "RecordID"))
View(Airport_merge)

colnames(Airport_merge)



#Wildlife                       
Wildlife  <- unique(cbind.data.frame(as.character(Aircraft_data$Wildlife..Number.struck),
                                     as.character(Aircraft_data$Wildlife..Size)))

colnames(Wildlife) <- c("Wildlife struck","Wildlifesize") 
Wildlife$ID <- sample(1:nrow(Wildlife))
View(Wildlife)

                         

Wildlife_merge <- merge(Airport_merge,Wildlife,
                        by.x = c("Wildlife..Number.struck",
                        "Wildlife..Size"),
                        by.y = c("Wildlife struck",
                                 "Wildlifesize"))
##################################################################################################































































#Operations                         
Operations <- unique(cbind.data.frame(as.character(Aircraft_data$Aircraft..Airline.Operator),
                                      as.character(Aircraft_data$Origin.State),
                                      as.character(Aircraft_data$When..Phase.of.flight),
                                      as.character(Aircraft_data$Conditions..Precipitation),
                                      as.character(Aircraft_data$Altitude.bin),
                                      as.character(Aircraft_data$Conditions..Sky)))

colnames(Operations) <- c("operator","origin","phase","precipitation","altitude","conditions")

Operations$ID <- sample(1:nrow(Operations))
View(Operations)

Operations_merge <- merge(Wildlife_merge,Operations,
                          by.x =  c("Aircraft..Airline.Operator",
                            "Origin.State",
                            "When..Phase.of.flight",
                            "Conditions..Precipitation",
                            "Altitude.bin",
                            "Conditions..Sky"),
                          by.y = c("operator","origin","phase","precipitation","altitude","conditions"))

View(Operations_merge)
colnames(Operations_merge)

combined.data <- data.frame(Operations_merge)
View(combined.data)

names(combined.data)



dbWriteTable(conn = database,name = "Final_table", value = combined.data,
             row.names = F)




dbGetQuery(database, "SELECT [Type of aircraft],[origin],[altitude] from Final_table")


dbGetQuery(database, "SELECT [Type of aircraft] from Final_table")

















#########################################################################################
db<-dbConnect(SQLite(),dbname="booksData.sqlite")
dbGetQuery(db, " SELECT [Student Name], [Student Email] from Students")

#removing redundancy
###################################################################################################################
setwd("C:/Users/Michael Propp/Desktop/Information Assignemnt/Ass-10/")
db <- dbConnect(SQLite(),dbname="books.Data.new.sqlite")
book_data <- read.csv("bookData.csv", header=TRUE)
#dbGetQuery(db, " SELECT [Student Name], [Student Email] from Students")

authors <- unique(cbind.data.frame(as.character(book_data$AuthorName),as.character(book_data$AuthorDetails))) # removing 
#View(authors)

colnames(authors)<- c("Author Name", "Author Details")
authors$AuthorID <- sample(1:20,nrow(authors)) 
dbWriteTable(conn = db, name = "Authors", value = authors,
             row.names = FALSE)

#dbReadTable(db,"Authors")
View(authors)
View(book_data)


merge.data <- merge(book_data,authors,by.x=c("AuthorName","AuthorDetails"),
                    by.y=c("Author Name","Author Details"))


books <- unique(cbind.data.frame(as.character(book_data$BookName),as.character(book_data$BookGenre))) #removing redundancy
colnames(books)<- c("Book Name", "Book Genre")
books$bookID<-sample(100:130,nrow(books))
names(books)


finalmerge<- merge(merge.data,books, by.x=c("BookName","BookGenre"),by.y=c("Book Name","Book Genre"))
View(finalmerge)
names(finalmerge)

dbWriteTable(conn = db,name = 'FinalTable',value = finalmerge)


dbGetQuery(db, "SELECT [AuthorName],[BookGenre] from FinalTable")

View(finalmerge)
names(finalmerge)


studentsData <-unique(cbind.data.frame(finalmerge$StudentID,finalmerge$StudentName,
                                       finalmerge$StudentEmail,finalmerge$bookID))

colnames(studentsData) <- c("StudentID", "Student Name","Student Email", "BookID")




dbWriteTable(conn = db, name = "Students", value = studentsData,
             row.names = F)



names(studentsData)

dbGetQuery(db, "SELECT [AuthorName],[BookGenre],[Student Email] from Students")


query3<- dbSendQuery(db, "Select [Author Name], COUNT(*) from Students
                     INNER JOIN Books ON StudentsData$bookID = books$BookID
                     INNER JOIN Authors ON Books.AuthorID = Authors.AuthorID
                     WHERE [Author Name]='Bill Bryson'")


dbGetQuery(db, " SELECT StudentID, [Student Name],[Student Email] from Students LIMIT 10")

dbGetQuery(db, " SELECT StudentID AS [Student ID], [Student Name] AS StudentName from Students LIMIT 10")


dbGetQuery(db, " SELECT StudentID,[Student Name], [Student Email] from Students WHERE [Student Name] = 'Michelle'")










########################################################################################################################
db <- dbConnect(SQLite(),dbname = "bird_data.sqlite")
# connecting to data base and giving a db name 
df <- read.csv("Bird Strikes.csv",header = T)
# reading a csv file 
bird.data <- head(df)
names <- c(names(bird.data))
bird_data <- unique(cbind.data.frame(as.character(bird.data$Aircraft..Type),as.character(bird.data$Aircraft..Make.Model)))
#using a unique function to bind the variables 
#we use as.character becuase R stores the values in factors 
bird_data$aircraftID <- sample(1:6,nrow(bird_data))
# we are creating a new primary key 
#bird_data$aircraftID is the name we give 
#syntax goes like sample to how many rows 
#bird_data$AircraftID <- sample(1:nrow(bird_data))
# we can also use sample(1:nrow(df name))

dbWriteTable(conn = db, name = "bird_data",value =bird_data,
             row.names = F)

# writing a table 
# conn = db which is the db name which we gave 
#name is the the data file which we want to name it, we can give it any name 
#value is the data which we want to keep into the table

dbReadTable(db,"bird_data")
#reading the table finally for the values 

####################################################################################################################














