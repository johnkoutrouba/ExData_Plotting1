## Exploratory Data Analysis Course Project 1
# Plot 4

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

# Create fourth plot

# Open the file
png("plot4.png")

# Set to 2X2 grid
par(mfrow = c(2, 2))

# Top left
plot(proj1$datetime, proj1$Global_active_power, type = "n", xlab = NA, ylab = "Global Active Power")
lines(proj1$datetime, proj1$Global_active_power)

# Top right
plot(proj1$datetime, proj1$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(proj1$datetime, proj1$Voltage)

# Bottom left
plot(proj1$datetime, proj1$Sub_metering_1, type = "n", xlab = NA, ylab = "Energy sub metering")
lines(proj1$datetime, proj1$Sub_metering_1)
lines(proj1$datetime, proj1$Sub_metering_2, col = "red")
lines(proj1$datetime, proj1$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

# Bottom Right
plot(proj1$datetime, proj1$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(proj1$datetime, proj1$Global_reactive_power)

# Close graphics device
dev.off()