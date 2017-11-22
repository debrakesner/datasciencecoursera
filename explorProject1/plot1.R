## creates histogram png file of Global Active Power

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

#create histogram
hist(smalldata$globalactivepower, col = "red", border = "black", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
axis(2,at = c(0,200,400,600,800,1000,1200), labels = TRUE)

#copy histogram to png fle
dev.copy(png, file = "plot1.png",width = 480, height = 480) 
dev.off()

