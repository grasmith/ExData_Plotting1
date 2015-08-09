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

# set margins
par(bg="transparent",mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
# plot histogram
hist(dat$Global_active_power,col="red",
     xlab="Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.copy(png, file = "plot1.png",height=480, width=480)
dev.off()
