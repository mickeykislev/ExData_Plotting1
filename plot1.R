## Downloading the data zip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip";
if(!file.exists("/data")){ dir.create("./data")};
download.file(fileUrl, destfile = "./data/Electric power consumption.zip");

## Unzip data zip file to the data directory
unzip(zipfile="./data/Electric power consumption.zip", exdir="./data");

## Reading the data table
data <- read.table("./data/household_power_consumption.txt", 
                   header = TRUE, sep = ";", na.strings = "?")

## Chcking memory needs, and memory hardware
library(pryr)
object_size(data);
memory.size()

## Defining the date and time variables
data$DateTime <- paste(data$Date, data$Time);

library(lubridate);
data$DateTime <- dmy_hms(data$DateTime);

## filtering  the dates we need
library(dplyr);
ggsource <- filter(data, DateTime >= "2007-02-01" & DateTime < "2007-02-03");

## Remuve the old dataframes
rm(data);

## Target file spacifications 
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12);

## Produce the graph
par(bg = NA);
hist(ggsource$Global_active_power, 
     bg = "transparent",
     col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power");

## Close the file
dev.off();


