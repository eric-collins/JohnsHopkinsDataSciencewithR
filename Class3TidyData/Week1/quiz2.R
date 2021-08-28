library(readr)
library(dplyr)
library(Hmisc)
library(openxlsx)
library(XML)
library(rlist)
library(httr)
library(jsonlite)
library(httpuv)

#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "C:/Users/emcollin/OneDrive - Volusia County Schools/Desktop/R projects/JohnsHopkinsDataSciencewithR/Class3TidyData/Week1/Quiz1Download.csv")

#df <- read.csv("C:/Users/emcollin/OneDrive - Volusia County Schools/Desktop/R projects/JohnsHopkinsDataSciencewithR/Class3TidyData/Week1/Quiz1Download.csv")

#topvalue <- filter(df, df$VAL == 24)

#describe(topvalue)

#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx ", "C:/Users/emcollin/OneDrive - Volusia County Schools/Desktop/R projects/JohnsHopkinsDataSciencewithR/Class3TidyData/Week1/Quiz1Download2.xlsx")
#dat <- read.xlsx("Quiz1Download2.xlsx", rows = 18:23, cols = 7:15)
#sum(dat$Zip*dat$Ext,na.rm=T)

#file <- "getdata_data_restaurants.xml" 

#doc <- xmlTreeParse(file, useInternalNodes = TRUE)

#rootnode <- xmlRoot(doc)

#zips <- xpathSApply(rootnode, "//zipcode", xmlValue)

#zips <- as.numeric(zips)

#new_zips <- Filter(function(x) zips == 21231, zips)

#new_zips <- na.omit(new_zips)

#length(new_zips)

#myapp <- oauth_app(appname = "ericcollinscoursera",
                  #key = "1cbd070f86ae8b6e31f7",
                  #secret = "0e8458992392852fddb304b9fa18f252d3c01c57")

# Get OAuth credentials
#github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
#gtoken <- config(token = github_token)
#req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Take action on http error
#stop_for_status(req)

# Extract content from a request
#json1 = content(req)

# Convert to a data.frame
#gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
#gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 

#acs <- read.csv("Quiz1Download3.csv")


#htmlCode <- readLines("jeffrey leek contact.html")

#nchar(htmlCode[10])
#nchar(htmlCode[20])
#nchar(htmlCode[30])
#nchar(htmlCode[100])

widths <- c(-1, 9, -5, 4, -1, 3, -5, 4, -1, 3, -5, 4, -1, 3, -5,  4, -1, 3)

#read.table("Quiz1Download4.for", sep = "\t")
fixedfile <- read.fwf("Quiz1Download4.for", widths)

full_sum <- sum(fixedfile[4])
