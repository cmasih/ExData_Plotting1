## Reading the dataset 

epc <- read.table("household_power_consumption.txt",header = TRUE, sep = ";")


## Subsetting data from 1st and 2nd February of 2007 to examine energy use

epcsubset<-subset(epc, Date == "1/2/2007" | Date == "2/2/2007")


## Changing class of columns

epcsubset$Date<- as.Date(epcsubset$Date, format = "%e/%m/%Y") #Date

epcsubset$Time<- strptime(epcsubset$Time, format = "%H:%M:%S") # Time

epcsubset[,3:7] <- lapply(epcsubset[,3:7], as.numeric) # Non date/time variables


## Formating the Time variable to use for plotting
## rows 1 to 1440 are 1st and 1440 to 2880 are the 2nd

epcsubset[1:1440,"Time"] <- format(epcsubset[1:1440,"Time"],"2007-02-01 %H:%M:%S")

epcsubset[1441:2880,"Time"] <- format(epcsubset[1441:2880,"Time"],"2007-02-02 %H:%M:%S")



## Creating file to save plot to

png("plot4.png", width = 480, height = 480) #creating file to save plot to

par(mfrow= c(2,2))

hist(as.numeric(epcsubset$Global_active_power), 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

plot(epcsubset$Time,epcsubset$Voltage, 
     type="l",
     xlab="datetime",
     ylab = "Voltage")

plot(epcsubset$Time, epcsubset$Sub_metering_1, 
     type = "l",
     ylab="Energy sub metering",
     xlab = "")

lines(epcsubset$Time,epcsubset$Sub_metering_2, col = "red")

lines(epcsubset$Time,epcsubset$Sub_metering_3, col = "blue")

legend("topright",
       col=c("black","red","blue"),
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=1)

plot(epcsubset$Time,epcsubset$Global_reactive_power, 
     type="l",
     xlab="datetime",
     ylab = "Global_reactive_power")


## Closing connection with file created in order to create new plot 

dev.off() #closing connection with file created
