getwd()



library(RCurl)
library(ROAuth)
library(streamR)
library(base64enc)
library(httr)
library(twitteR)

download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")


outFile<-"tweets_sample.json"

requestURL<-"https://api.twitter.com/oauth/request_token"

accessURL<-"https://api.twitter.com/oauth/access_token"

authURL<-"https://api.twitter.com/oauth/authorize"

consumerKey<-"mJVRxj9ki77Eojd2yyaHmulPl"

consumerSecret<-"ATtQ9IdnQDS976f3vjPWWUlkzkm1yNkEeCNULhePZyU3nh2tAL"

oauth_token<-"1173879488-OVOkaw1WV55c6cMMxQYCnJnC74SnhXqGZ7nbyCx"

oauth_token_secret<-"kSHVOTuHBv5853uOr8icpKfncshRYwalMIsfBA3YiyGik"


install.packages("devtools")

install.packages("twitteR")

devtools::install_version("httr",version="0.6.0",repos="http://cran.us.r-project.org")

library(RCurl)
library(ROAuth)
library(streamR)
library(twitteR)
library(base64enc)
library(httr)

download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")				
																															

#	Configuration	for	twitter																																																
#outFile<- "tweets_sample.json"

my_oauth<-OAuthFactory$new( consumerKey=consumerKey,
  consumerSecret=consumerSecret,
  requestURL=requestURL,
  accessURL=accessURL,
  authURL=authURL)

my_oauth$handshake(cainfo="cacert.pem")

setup_twitter_oauth(consumerKey,
                    consumerSecret,
                    oauth_token,
                    oauth_token_secret)

sampleStream(file=outFile,oauth = my_oauth)




follow<-""
track<-"Boston,RedSoxs"
location<-c(23.786699,60.878590,37.097000,77.840813)

filterStream(file.name=outFile,follow=follow,
  track=track,locations=location,oauth=my_oauth,
  timeout=10800)







