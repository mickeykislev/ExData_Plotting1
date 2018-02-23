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
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12);


## Produce the graph and the first line
par(bg = NA);
plot(ggsource$DateTime, ggsource$Sub_metering_1, 
     bg = "transparent",
     type = "l",
     xlab = "",
     ylab = "Energy sub metering");

## Adding the second line
lines(ggsource$DateTime, ggsource$Sub_metering_2, col="red",lty=2);

## Adding the third line
lines(ggsource$DateTime, ggsource$Sub_metering_3, col="blue",lty=2);

## Adding legend
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black","red","blue"),
       lty = 1, 
       ncol=1);

## Close the file
dev.off();