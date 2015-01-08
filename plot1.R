## Exploratory Data Analysis Course Project 1
# Plot 1

# Download data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "project1.zip", method = "curl")

# Extract data from zip file
unzip("project1.zip")

# Read data file
proj1 <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Summary
summary(proj1)
str(proj1)

# Convert dates and times
library(lubridate)
proj1$datetime <- dmy_hms(paste(proj1$Date, proj1$Time, sep = " "))

# First adjust system time zone, since R is smart that way.
Sys.setenv(TZ = "GMT")

# Subset data we want - February 1 and 2, 2007.  Drops old date and time fields
proj1 <- proj1[proj1$datetime >= "2007-02-01" & proj1$datetime < "2007-02-03", 3:10]

# Return to normal time zone
Sys.unsetenv("TZ")

# Create first plot
png(filename = "plot1.png")
hist(proj1$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()