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
plot(my_table$Global_active_power, type = 'l', ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, "plot2.png, width - 480,height= 480")




