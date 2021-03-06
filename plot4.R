install.packages("sqldf")
library(sqldf)
dat <- read.csv.sql("household_power_consumption.txt",sql="select * from file where Date = '1/2/2007' or Date='2/2/2007'", header = TRUE, sep = ";")
dat$Time <- paste(dat$Date,dat$Time)
dat$Date <-as.Date(dat$Date,"%d/%m/%Y")
dat$Time <-strptime(dat$Time,"%d/%m/%Y %H:%M:%S")
png(filename = "plot4.png", bg = "transparent", width = 480, height = 480, units = 'px')
par(mfrow = c(2, 2))
with(dat, {
    plot(Time, Global_active_power, type = "l", xlab = '', ylab = "Global Active Power")
  
    plot(Time, Voltage, type = "l", xlab = 'datetime', ylab = "Voltage")
    
    plot(Time, Sub_metering_1, type = 'l', col = 'Black', xlab = "", ylab = "Energy sub metering")
    lines(Time, Sub_metering_2, type = 'l', col = 'Red', xlab = "", ylab = "")
    lines(Time, Sub_metering_3, type = 'l', col = 'Blue', xlab = "", ylab = "")
    legend("topright", lty = 1,bty = "n", col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(Time, Global_reactive_power, type = "l", xlab = 'datetime', ylab = "Global_reactive_power")
})
dev.off()