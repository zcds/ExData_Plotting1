# Load the required libraries
library('sqldf')

# Download the data if not already download. 
if (!file.exists('./household_power_consumption.txt')) {
  print('Downloading data...')
  download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', destfile = 'household_power_consumption.zip', method = 'curl')
  
  # Since the data is in a zipfile, unzip it
  unzip('household_power_consumption.zip')
}

# Load only the data for the two days (2007-02-01 and 2007-02-02)
print('Reading data into memory...')
data = read.csv.sql(file = 'household_power_consumption.txt', sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"', header = TRUE, sep = ';')

# Transform the data to our desire
print('Transforming data...')
data$DateAndTime <- strptime(paste(data$Date, data$Time, sep = ' '), '%d/%m/%Y %H:%M:%S')
data$Sub_metering_1[data$Sub_metering_1 == '?'] <- NA
data$Sub_metering_2[data$Sub_metering_2 == '?'] <- NA
data$Sub_metering_3[data$Sub_metering_3 == '?'] <- NA

# Plot the data as required
print('Plotting data...')

# Plot on the PNG file device
png("plot3.png", width = 480, height = 480)

# Ensure the correct layout
par(mfrow = c(1,1))

plot(data$DateAndTime, data$Sub_metering_1, type = 'n', xlab = '', ylab = 'Energy sub metering')
lines(data$DateAndTime, data$Sub_metering_1, col = 'black')
lines(data$DateAndTime, data$Sub_metering_2, col = 'red')
lines(data$DateAndTime, data$Sub_metering_3, col = 'blue')
legend('topright', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty = c(1,1), lwd = c(1,1))

dev.off()

print('plot3.png is generated!')
