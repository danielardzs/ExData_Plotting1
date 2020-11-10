# Read file
full_table <- read.csv('household_power_consumption.txt', header = TRUE, sep = ";")
# read only dates
my_table <- subset(full_table, Date == "1/2/2007" | Date == "2/2/2007")

# classes
my_table$Date <- as.Date.character(my_table$Date)
my_table$Time <- strptime(my_table$Time, "%H:%M:%S", tz = "US")
my_table$Global_active_power <- as.numeric(my_table$Global_active_power)

# Plot
png(file="plot1.png",width=480, height=480)
hist(hist(my_table$Global_active_power, col = 'red', xlab = "Global Active Power (kilowatts)", ylim = c(0,1200), main = "Global Active Power"))
dev.off()


