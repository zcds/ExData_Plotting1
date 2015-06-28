# Load the required libraries
library('sqldf')

# Download the data if not already download. 
if (!file.exists('./household_power_consumption.txt')) {
  print("Downloading data...")
  download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', destfile = 'household_power_consumption.zip', method = 'curl')
  
  # Since the data is in a zipfile, unzip it
  unzip('household_power_consumption.zip')
}

# Load only the data for the two days (2007-02-01 and 2007-02-02)
print("Reading data into memory...")
data = read.csv.sql(file = 'household_power_consumption.txt', sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"', header = TRUE, sep = ';')

# Transform the data to our desire
print("Transforming data...")
data$Global_active_power[data$Global_active_power == '?'] <- NA

# Plot the data as required
print("Plotting data...")

# Plot on the PNG file device
png("plot1.png", width = 480, height = 480)

# Ensure the correct layout
par(mfrow = c(1,1))

hist(df$Global_active_power, main = 'Global Active Power', col = 'red', xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency')

dev.off()

print("plot1.png is generated!")
