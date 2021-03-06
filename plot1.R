# IMPORTANT: make sure that you have enough memory and disk space for this download

# read data
download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="household_power_consumption.zip",method="curl")
unzip("household_power_consumption.zip")
exp<-read.delim("household_power_consumption.txt",sep=";")
dataset<-exp[exp$Date=="1/2/2007" | exp$Date=="2/2/2007",]
#sapply(dataset,class)
dataset[,c(3,4,5,6,7,8,9)]<-sapply(dataset[,c(3,4,5,6,7,8,9)],function(x){as.numeric(as.character(x))})
dataset$time_stamp<-as.POSIXct(x=paste(as.character(dataset$Date),as.character(dataset$Time),sep=" "),format="%d/%m/%Y %H:%M:%S",tz="UTC")

# plot1
png(filename = "plot1.png", width=480, height=480,units="px") 
hist(dataset$Global_active_power,xlab="Global Active Power (Kilowatts)",col="Red",main = "Global Active Power")
dev.off()