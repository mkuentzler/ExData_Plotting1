# Read in and filter data. The source raw file is assumed to be in the working
# directory.
options(stringsAsFactors=FALSE)
data <- read.table('household_power_consumption.txt', sep=';', header = TRUE)
data <- transform(data, Global_active_power = as.numeric(Global_active_power))

filtered_data <- subset(data, 
                        data$Date == '1/2/2007' | data$Date == '2/2/2007')

# Prepare plot annotations.
title <- 'Global Active Power'
xlabel <- 'Global Active Power (kilowatts)'
ylabel <- 'Frequency'

# Plot into .png file.
png(file = 'plot1.png', bg = 'transparent')
hist(filtered_data$Global_active_power, main = title, col = 'Red',
     xlab = xlabel, ylab = ylabel)
dev.off()