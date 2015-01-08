## Exploratory Data Analysis Course Project 1
# Plot 3

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

# Create third plot
png("plot3.png")
plot(proj1$datetime, proj1$Sub_metering_1, type = "n", xlab = NA, ylab = "Energy sub metering")
lines(proj1$datetime, proj1$Sub_metering_1)
lines(proj1$datetime, proj1$Sub_metering_2, col = "red")
lines(proj1$datetime, proj1$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()