###########################
# plot2.R
# Produce a line graph of global active power by day
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
    png("plot2.png", width = 480, height = 480)
    plot(subsetDat$Date, subsetDat$Global_active_power, type = "l")
    dev.off()
})