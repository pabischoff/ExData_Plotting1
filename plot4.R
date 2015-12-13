library(gdata)
library(grDevices)

#read in the file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
powerdata <- read.table(unz(temp,"household_power_consumption.txt"), sep=";", header=TRUE)
unlink(temp)

#convert data strings to date types
powerdata$Date = as.Date(powerdata$Date, "%d/%m/%Y")

#subset to dates specified: 2007-02-01 and 2007-02-02
mypowerdata <- powerdata[powerdata$Date >= "2007-02-01" & powerdata$Date <= "2007-02-02",]

#clean up data, fix dates, make everything numeric, change '?' to NA
mypowerdata$Sub_metering_1 <- unknownToNA(mypowerdata$Sub_metering_1, unknown="?")

datetime <- as.POSIXct(paste(mypowerdata$Date, mypowerdata$Time), format="%Y-%m-%d %H:%M:%S")

mypowerdata$Global_active_power = as.numeric(as.character(mypowerdata$Global_active_power))
mypowerdata$Voltage = as.numeric(as.character(mypowerdata$Voltage))
mypowerdata$Global_reactive_power = as.numeric(as.character(mypowerdata$Global_reactive_power))


#plot the data
png(filename="~/ExData_Plotting1/plot4.png", width=480, height=480, units="px")

par(mfrow=c(2,2))

#plot 1
plot(mypowerdata$Global_active_power, ylab="Global active power (kilowatts)",
     labels=FALSE, tck=FALSE, type="l", xlab="")
axis(1, at=seq(1, 3692, 1450), c("Thu","Fri","Sat"))
axis(2)


#plot 2
plot(datetime, mypowerdata$Voltage, type="l", ylab="Voltage")

#plot 3
plot(datetime, mypowerdata$Sub_metering_1, ylab="Energy sub metering", type="l", xlab="")
lines(datetime, mypowerdata$Sub_metering_2, col="red")
lines(datetime, mypowerdata$Sub_metering_3, col="blue")
legend("topright", paste("Sub_metering_", 1:3), lty = 1, col=c(1,2,4), cex=0.8)

#plot 4
plot(datetime, mypowerdata$Global_reactive_power, type="l", ylab="Global_reactive_power")

dev.off()




