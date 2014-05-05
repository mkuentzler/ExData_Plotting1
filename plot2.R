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
data <- transform(data, Global_active_power = as.numeric(Global_active_power))

datetimes <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
data$Datetime <- datetimes
data$Date <- NULL
data$Time <- NULL

# Prepare plot annotations.
ylabel <- 'Global Active Power (kilowatts)'

# Plot into .png file.
png(file = 'plot2.png', bg = 'transparent')
plot(data$Datetime, data$Global_active_power,
     type = 'l', ylab = ylabel, xlab = '')
dev.off()