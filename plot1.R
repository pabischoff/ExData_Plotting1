#read in the file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
powerdata <- read.table(unz(temp,"household_power_consumption.txt"), sep=";", header=TRUE)
unlink(temp)

#convert data strings to date types
powerdata$Date = as.Date(powerdata$Date, "%d/%m/%Y")

#subset to dates specified: 2007-02-01 and 2007-02-02
mypowerdata <- powerdata[powerdata$Date >= "2007-02-01" & powerdata$Date <= "2007-02-02",]

#convert global active power column to numeric
mypowerdata$Global_active_power = as.numeric(as.character(mypowerdata$Global_active_power))

#plot the histogram
par(mfrow=c(1,1))

hist(mypowerdata$Global_active_power, col="red", xlab="Global active power (kilowatts)",
     main="Global Active Power", axes=TRUE)

#spit out the png file
dev.copy(png, '~/ExData_Plotting1/plot1.png', width=480, height=480)
dev.off()

