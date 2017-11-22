## creates line graph png file of sub-metering energy consumption vs. Time

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

#create graph
with(smalldata, plot(smalldata$datetime,smalldata$meterkitchen, type = "l", col = "black",xlab = "",ylab = "Energy sub metering"))
lines(smalldata$datetime,smalldata$meterlaundry, col = "red")
lines(smalldata$datetime,smalldata$meterairh2o, col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1), lwd=c(2.5,2.5), col = c("black","red","blue"))

#copy graph to png fle
dev.copy(png, file = "plot3.png",width = 480, height = 480) 
dev.off()
