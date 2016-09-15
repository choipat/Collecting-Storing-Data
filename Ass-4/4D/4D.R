#################################################################################
## DSCS 6020: Collecting, Storing, and Retrieving Data                         ##
## Submitted by Sarvani Vadali                                                 ##
## Question 4.d                                                                ##
#################################################################################

# parseLine:
# Parses a line from IMDB movie file and returns title and year.
# Assumes that the first four digit number in a given line is the
# the year the movie released.
# Returns:
# Title and Year.
parseLine <- function (line) {
  if (is.character(line)) {
    x <- strsplit(line, '@@')
    if (length(x) > 0 && length(x[[1]] > 2)) {
      title <- x[[1]][2] # Extract title.
      rest <- x[[1]][3] # Extract rest of the line.
      
      # Extract first four digit number as year.
      y <- regmatches(rest,gregexpr("(?<=\\().*?([0-9][0-9][0-9][0-9])", rest, perl=TRUE))
      
      year <- NA
      if (!is.na(y) && length(y) > 0) {
        year <- as.numeric(y[[1]][1])
      }
      
      return (c(title, year))
    }
  }
  
  return (c(NA, NA))
}

# parseIMDBFile:
# Parses give IMDB movie file list and returns a data.frame
# Assumption:
# A title is considered a TV series if it repeats more than once.
# A title having '(V)' is considered an adult movie.
# Returns:
# data.frame representation of given movie file list.
parseIMDBFile <- function (filePath, skip = 0, nrows = -1) {
  fh <- NA
  df <- data.frame("Title" = character(), "Year" = character(), stringsAsFactors=FALSE)
  tryCatch({
    fh <- file(filePath, open = "r")
    
    lineNumber <- 0
    
    # Keep track of counts current title is repeated
    prevTitle <- NA
    prevYear <- NA
    prevCount <- 1
    
    # Read line-by-line and add parsed result to data frame.
    while (length(line <- readLines(fh, n = 1, warn = FALSE, encoding = 'utf-8')) > 0) {
      lineNumber <- lineNumber + 1
      
      # Start processing only after skipping required number of lines.
      if (lineNumber > skip) {
        # Remove double quotes and tabs from line.
        line <- gsub('\t', ' ', line)
        line <- gsub('\"', '@@', line) # Replace quotes with '@@' for easrier parsing.
        
        # Parse given line from IMDB movie file.
        movieInfo <- parseLine(line)
        
        # Add given info to data.frame
        if (length(movieInfo) == 2 && !is.na(movieInfo[1]) && !is.na(movieInfo[2])) {
          title <- movieInfo[1]
          year <- movieInfo[2]
          
          # We have a new title. Check previous counts.
          if (is.na(prevTitle) || title != prevTitle) {
            if (is.na(prevTitle)) {
              prevTitle <- title
              prevYear <- year
              next
            }
            
            # Add this title only if it is unique
            if (prevCount == 1) {
              if (grepl('\\(V\\)', prevTitle)) {
                print(prevTitle)
                break
              }
              df <- rbind(df, data.frame("Title"= prevTitle, "Year"= prevYear))
            }
            
            prevTitle <- title
            prevYear <- year
            prevCount <- 1
          } else {
            # Same title as before (this is TV series)
            prevCount <- prevCount + 1
          }
        }
        
        # Check if we need to skip parsing lines.
        if (nrows > 0 && lineNumber - skip > nrows) {
          break
        }
      }
    }
    close(fh)
  }, error = function(e) {
    print(e$message)
    if (!is.na(fh)) {
      close(fh)
    }
    return (NA)
  })
  
  return (df)
}

df <- parseIMDBFile('movies.list', skip = 15, nrows = -1)
#head(df)