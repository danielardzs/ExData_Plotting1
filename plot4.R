# Read file
full_table <- read.table('household_power_consumption.txt', header = TRUE, sep = ";", na.strings = '?', colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# read only dates
my_table <- subset(full_table, Date == "1/2/2007" | Date == "2/2/2007")

# classes
my_table$Date <- as.Date(my_table$Date, "%d/%m/%Y")
my_table$Global_active_power <- as.numeric(my_table$Global_active_power)

my_table <- my_table[complete.cases(my_table),]

# combine date and time
dateTime <- paste(my_table$Date, my_table$Time)
dateTime <- setNames(dateTime, "DateTime")
my_table <- my_table[,!(names(my_table) %in% c("Date","Time"))]

#add column
my_table <- cbind(dateTime, my_table)
my_table$dateTime <- as.POSIXct(dateTime)

# Plot
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with (my_table,{
  plot(Global_active_power~dateTime, type = 'l',
        ylab = "Global Active Power (kilowatts)", xlab ="")
  plot(Voltage~dateTime, type = 'l', ylab = "Voltage (volt)", xlab ="")
  plot(Sub_metering_1~dateTime, type = 'l', ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2~dateTime, col = 'red')
  lines(Sub_metering_3~dateTime, col = 'blue')
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1:3, cex = 0.8)
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})       
# Save
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()


