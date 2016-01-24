##Download Data
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  zipTemp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",zipTemp)
  workFile <- unzip(zipTemp)
  unlink(zipTemp)
} else {
  zipTemp <- tempfile()
  workFile <- unzip("exdata-data-household_power_consumption.zip")
  unlink(zipTemp)
}

##Data preperation
pwTable <- read.table(workFile, header = T, sep = ";")
filtpwTable <- pwTable[pwTable == c("1/2/2007", "2/2/2007"),]
good <- complete.cases(filtpwTable)
cleanPWTable <- filtpwTable[good,]
cleanPWTable$Voltage <- as.numeric(as.character(cleanPWTable$Voltage))
cleanPWTable$Sub_metering_1 <- as.numeric(as.character(cleanPWTable$Sub_metering_1))
cleanPWTable$Sub_metering_2 <- as.numeric(as.character(cleanPWTable$Sub_metering_2))
cleanPWTable$Sub_metering_3 <- as.numeric(as.character(cleanPWTable$Sub_metering_3))
cleanPWTable$Global_active_power <- as.numeric(as.character(cleanPWTable$Global_active_power))
cleanPWTable$Global_reactive_power <- as.numeric(as.character(cleanPWTable$Global_reactive_power))
cleanPWTable$Date <- as.Date(cleanPWTable$Date, format="%d/%m/%Y")
cleanPWTable <- transform(cleanPWTable, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")


##Plot 3
plot(cleanPWTable$timestamp,cleanPWTable$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(cleanPWTable$timestamp,cleanPWTable$Sub_metering_2,col="red")
lines(cleanPWTable$timestamp,cleanPWTable$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
cat("plot3.png saved in following directory: ", getwd())