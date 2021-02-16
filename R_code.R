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



#Plotting the data

## Plot 1
hist(hpc$Global_active_power, col = 'Red', main = "Global Active Power", xlab = "Global Active Power (kilowatts)")


## Plot 2
with(hpc, plot(Global_active_power, type = 'l', xaxt = "n", ylab = "Global Activer Power (kilowatts)", xlab = ""))


## Plot 3
with(hpc, plot(Sub_metering_1, type = 'l', xaxt = "n", ylab = "Global Activer Power (kilowatts)", xlab = ""))
with(hpc, points(Sub_metering_2, type = 'l', col = "red"))
with(hpc, points(Sub_metering_3, type = 'l', col = "blue"))
legend("topright",lty = 1:2, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


## Plot 4
par(mfcol = c(2,2))
with(hpc, {
  plot(Global_active_power, type = 'l', xaxt = "n", ylab = "Global Activer Power (kilowatts)", xlab = "")
  plot(Sub_metering_1, type = 'l', xaxt = "n", ylab = "Energy sub metering", xlab = "")
  points(Sub_metering_2, type = 'l', col = "red")
  points(Sub_metering_3, type = 'l', col = "blue")
  legend("topright",lty = 1:2, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(Voltage, type = 'l', xaxt = "n", xlab = "datetime")
  plot(Global_reactive_power, type = 'l', xaxt = "n", xlab = "datetime")
  })
