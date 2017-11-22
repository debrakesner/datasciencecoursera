## creates 4 plots

#read file
setwd("C:/Users/Debra/datasciencecoursera/explorProject1")
fileLoc <- "C:/Users/Debra/datasciencecoursera/explorProject1/household_power_consumption.txt"
data <- read.table(fileLoc,header = TRUE,sep = ";")

#rename columns
names(data) <- c("date","time","globalactivepower","globalreactivepower","voltage","globalintensity","meterkitchen","meterlaundry","meterairh2o")

#format/add date/time columns
data$datetime <- strptime(paste(data$date,data$time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
data$date <- as.Date(data$date, "%d/%m/%Y")

#restrict dataset
smalldata <- data[(data$date >=as.Date("02/01/2007", format = "%m/%d/%Y") & data$date <=as.Date("02/02/2007", format = "%m/%d/%Y")),]

#format number columns
for (i in 3:8) {smalldata[,i] <- as.numeric(as.character(smalldata[,i]))}

# set the panel
par(mfcol = c(2,2))

#create line graph #1
with(smalldata, plot(smalldata$datetime,smalldata$globalactivepower, type = "l", col = "black",xlab = "",ylab = "Global Active Power (kilowatts)"))

#create graph #2
with(smalldata, plot(smalldata$datetime,smalldata$meterkitchen, type = "l", col = "black",xlab = "",ylab = "Energy sub metering"))
lines(smalldata$datetime,smalldata$meterlaundry, col = "red")
lines(smalldata$datetime,smalldata$meterairh2o, col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1), col = c("black","red","blue"),cex = .5, bty = "n",y.intersp = .4, xjust =1)

#create line graph #3
with(smalldata, plot(smalldata$datetime,smalldata$voltage, type = "l", col = "black",xlab = "datetime",ylab = "Voltage"))

#create line graph #4
with(smalldata, plot(smalldata$datetime,smalldata$globalreactivepower, type = "l", col = "black",xlab = "datetime",ylab = "Global_reactive_power"))

#copy graph to png fle
dev.copy(png, file = "plot4.png",width = 480, height = 480) 
dev.off()
