# Read in the raw data. The source raw file is assumed to be in
# the working directory.
options(stringsAsFactors=FALSE)
raw_data <- read.table('household_power_consumption.txt',
                       sep=';', header = TRUE)

# Filter the data for the relevant dates, and remove the raw data from memory.
data <- subset(raw_data,
               raw_data$Date == '1/2/2007' | raw_data$Date == '2/2/2007')
remove('raw_data')

# Clean the filtered data.
data <- transform(data, Sub_metering_1 = as.numeric(Sub_metering_1),
                  Sub_metering_2 = as.numeric(Sub_metering_2),
                  Sub_metering_3 = as.numeric(Sub_metering_3))

datetimes <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
data$Datetime <- datetimes
data$Date <- NULL
data$Time <- NULL

# Prepare plot annotations.
ylabel <- 'Energy sub metering'
legend_string <- c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')

# Plot into .png file.
png(file = 'plot3.png', bg = 'transparent')
plot(data$Datetime, data$Sub_metering_1,
     type = 'l', ylab = ylabel, xlab = '')
lines(data$Datetime, data$Sub_metering_2, col = 'Red')
lines(data$Datetime, data$Sub_metering_3, col = 'Blue')
legend('topright', legend = legend_string, 
       lty = c(1,1,1), col = c('Black','Red','Blue'))
dev.off()