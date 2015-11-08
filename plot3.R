###########################
# plot3.R
# Produce a line graph of energy by each sub meter by day
#
###########################

### Read the data in and prep it for plotting

# Check for and install data.table package if req'd
if(!require("data.table")){
    install.packages("data.table")   
}

library(data.table)

# Check to see if the data file is downloaded
if (!file.exists("./household_power_consumption.txt")) {
    
    # Download data
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    fileName <- "household_power_consumption.zip"
    download.file(fileUrl, fileName, method = "curl")
    
    # Unzip file
    unzip(fileName)
}

fileName <- "./household_power_consumption.txt"

# Read data
dat <- fread(input = fileName, na.strings = "?")

## Subset data to only dates 2007-02-01 and 2007-02-02

# convert Date variable to Date class
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")

# return subset data
subsetDat <- dat[dat$Date == "2007/02/01" | dat$Date == "2007/02/02", ]

### Create plot

with(subsetDat, {
    png(filename = "plot3.png")
    x <- strptime(paste(subsetDat$Date, subsetDat$Time), "%Y-%m-%d %H:%M:%S")
    plot(x, subsetDat$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
    lines(x, subsetDat$Sub_metering_1, col = "black")   # Sub metering 1
    lines(x, subsetDat$Sub_metering_2, col = "red")     # Sub metering 2
    lines(x, subsetDat$Sub_metering_3, col = "blue")    # Sub metering 3
    legend("topright", lty = 1, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    dev.off()
})