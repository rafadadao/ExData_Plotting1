#Loading the data

temp <- tempfile()

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = temp)

datazip <- unzip(temp, files = 'household_power_consumption.txt')

data <- read.csv2(datazip)

#Filtering the data
library(dplyr)

hpc <- data %>% 
  filter(Date %in% c('1/2/2007','2/2/2007'))

hpc[,1]

#Viewing the data
summary(hpc)
head(hpc,10)

#Transforming the Data
hpc$Global_active_power <- as.numeric(hpc$Global_active_power)
is.numeric(hpc$Global_active_power)

hpc$Sub_metering_1 <- as.numeric(hpc$Sub_metering_1 )
hpc$Sub_metering_2 <- as.numeric(hpc$Sub_metering_2 )
hpc$Sub_metering_3 <- as.numeric(hpc$Sub_metering_3 )

hpc$Date <- as.Date(strptime(hpc$Date, "%d/%m/%Y"))
class(hpc$Date)

#Change the Date/Time column
hpc$datetime <- as.POSIXct(strptime(paste(hpc$Date, hpc$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S"))

#Plotting the data

## Plot 1
#Save plot png
png("plot1.png", width = 480, height = 480)

hist(hpc$Global_active_power, col = 'Red', main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#Closing file device
dev.off()


## Plot 2
#Save plot png
png("plot2.png", width = 480, height = 480)

with(hpc, plot(datetime, Global_active_power, type = 'l', ylab = "Global Activer Power (kilowatts)", xlab = ""))

#Closing file device
dev.off()

## Plot 3
#Save plot png
png("plot3.png", width = 480, height = 480)

with(hpc, plot(datetime, Sub_metering_1, type = 'l', ylab = "Global Activer Power (kilowatts)", xlab = ""))
with(hpc, points(datetime, Sub_metering_2, type = 'l', col = "red"))
with(hpc, points(datetime, Sub_metering_3, type = 'l', col = "blue"))
legend("topright",lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Closing file device
dev.off()

## Plot 4
#Save plot png
png("plot4.png", width = 480, height = 480)

par(mfcol = c(2,2))
with(hpc, {
  plot(datetime, Global_active_power, type = 'l', ylab = "Global Activer Power (kilowatts)", xlab = "")
  plot(datetime, Sub_metering_1, type = 'l', ylab = "Energy sub metering", xlab = "")
  points(datetime, Sub_metering_2, type = 'l', col = "red")
  points(datetime, Sub_metering_3, type = 'l', col = "blue")
  legend("topright",lty = 1, cex = 0.75, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(datetime, Voltage, type = 'l', xlab = "datetime")
  plot(datetime, Global_reactive_power, type = 'l', xlab = "datetime")
  })

#Closing file device
dev.off()