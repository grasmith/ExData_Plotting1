library(dplyr)
# download the data from the source file.
# Since the source file is large, only load the records for the two days
# required records found by trial and error
dat2 <- read.csv("household_power_consumption.txt",
                 sep = ";",header = FALSE,
                 nrows = 3000, skip = 66637,
                 col.names = c("Date","Time","Global_active_power",
                    "Global_reactive_power","Voltage","Global_intensity",
                    "Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                 na.strings="NA", stringsAsFactors = FALSE)
# filter to get the exact records for 1/2/2007 and 2/2/2007
dat <- filter(dat2,Date=="1/2/2007"|Date=="2/2/2007" )
# get rid of the source file to save space
rm(dat2)
# convert dates and times from chr
dat$Date <- as.Date(dat$Date,format="%d/%m/%Y")
dat$Time <- as.POSIXct(paste(dat$Date,dat$Time))

# the data now all ready so make the plots
# plot directly to png device to avoid distortions in copying
png(file = "plot4.png",height=480, width=480)
par(mfrow = c(2, 2))
with(dat, {plot(dat$Time,dat$Global_active_power,pch=NA_integer_,type="o",
               ylab="Global Active Power",xlab="")
          plot(dat$Time,dat$Voltage,pch=NA_integer_,type="o",
               ylab="Voltage", xlab="datetime")
          plot(dat$Time,dat$Sub_metering_1,pch=NA_integer_,type="o",
               ylab="Energy sub metering",xlab="")
               lines(dat$Time,dat$Sub_metering_2,pch=NA_integer_,type="o",col="red")
               lines(dat$Time,dat$Sub_metering_3,pch=NA_integer_,type="o",col="blue")
               legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                      bty="n",lty = 1,col=c("black", "red", "blue"))
               plot(dat$Time,dat$Global_reactive_power,pch=NA_integer_,type="o",
                    ylab="Global_reactive_power", xlab="datetime")})
dev.off()
