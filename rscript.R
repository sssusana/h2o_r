https://github.com/h2oai/h2o-3/blob/c9939425783cc8459278afa4e1ab527542e27ff7/h2o-r/demos/rdemo.citi.bike.small.R

#Unistall
if ("package:h2o" %in% search()) { detach("package:h2o", unload=TRUE) }
if ("h2o" %in% rownames(installed.packages())) { remove.packages("h2o") }

#Installing dependencies
pkgs <- c("RCurl","jsonlite")
for (pkg in pkgs) {
  if (! (pkg %in% rownames(installed.packages()))) { install.packages(pkg) }
}
#Installing H20 from repo
install.packages("h2o", type="source", repos=(c("http://h2o-release.s3.amazonaws.com/h2o/latest_stable_R")))

#Installing from CRAN
#install.packages("H2O")
#At https://cran.r-project.org/web/packages/h2o/

#Init
library(h2o)
localH2O = h2o.init()

#Loading Data
library(readr)
print("Importing bike data...")
starttime <- Sys.time()
data1 <- read_csv("C:/Users/SISS/Desktop/h20_test1/data1.csv")
nrow1<-nrow(data1)
data2 <- read_csv("C:/Users/SISS/Desktop/h20_test1/data1.csv")
nrow2<-nrow(data2)
endtime <- Sys.time()
importduration <- endtime - starttime
print(importduration)

print("TotalTime = ")
#Checking if datasets have equal variables
colnames(data1) == colnames(data2)

#Merging Datasets
dataset <- rbind(data1, data2)
nrowT<-nrow(dataset)
#N rows
dsvalid<-nrow1 + nrow2 == nrowT
dsvalid
if(dsvalid == TRUE) { print ("Join was successfully done")} else {print ("Check the join between DS")}

#Calculating dates
print('Calculate the dates and day of week based on starttime of trip (dataset')
secsPerDay <- 1000*60*60*24
starttime  <- dataset$starttime
dataset$days  <- floor(starttime/secsPerDay)
dataset$year  <- year(starttime) + 1900
dataset$month <- month(starttime)
dataset$dayofweek <- dayOfWeek(starttime)
dataset$day   <- day(starttime)
dataset$age   <- dataset$year - data$"birth year"

