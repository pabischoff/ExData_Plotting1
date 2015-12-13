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

#change ? to NA
mypowerdata$Sub_metering_1 <- unknownToNA(mypowerdata$Sub_metering_1, unknown="?")

#combine time and date
datetime <- as.POSIXct(paste(mypowerdata$Date, mypowerdata$Time), format="%Y-%m-%d %H:%M:%S")

#plot the data
png(filename="~/ExData_Plotting1/plot3.png", width=480, height=480, units="px")

par(mfrow=c(1,1))

plot(datetime, mypowerdata$Sub_metering_1, ylab="Energy sub metering", type="l", xlab="")
lines(datetime, mypowerdata$Sub_metering_2, col="red")
lines(datetime, mypowerdata$Sub_metering_3, col="blue")
legend("topright", paste("Sub_metering_", 1:3), lty = 1, col=c(1,2,4), cex=0.8)

dev.off()





