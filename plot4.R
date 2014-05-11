# IMPORTANT: make sure that you have enough memory and disk space for this download

# read data
download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="household_power_consumption.zip",method="curl")
unzip("household_power_consumption.zip")
exp<-read.delim("household_power_consumption.txt",sep=";")
dataset<-exp[exp$Date=="1/2/2007" | exp$Date=="2/2/2007",]
#sapply(dataset,class)
dataset[,c(3,4,5,6,7,8,9)]<-sapply(dataset[,c(3,4,5,6,7,8,9)],function(x){as.numeric(as.character(x))})
dataset$time_stamp<-as.POSIXct(x=paste(as.character(dataset$Date),as.character(dataset$Time),sep=" "),format="%d/%m/%Y %H:%M:%S",tz="UTC")
dataset$day<-strftime(dataset$time_stamp,format="%a",tz="UTC")

# plot4
png(filename = "plot4.png", width=480, height=480,units="px")
par(mfrow=c(2,2))
with(dataset,plot(x=time_stamp,y=Global_active_power,type="l",ylab="Global Active Power",xlab=""))
with(dataset,plot(x=time_stamp,y=Voltage,type="l",ylab="Voltage",xlab=""))
plot(x=dataset$time_stamp,y=dataset$Sub_metering_1,type="l",ylab="Energy Sub Metering",xlab="")
lines(x=dataset$time_stamp,y=dataset$Sub_metering_2,type="l",col="red")
lines(x=dataset$time_stamp,y=dataset$Sub_metering_3,type="l",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,lwd=2,col=c("black","red","blue"),
       ncol=1,bty="n",cex=0.8,
       text.col=c("black","red","blue"))
with(dataset,plot(x=time_stamp,y=Global_reactive_power,type="l",xlab=""))
dev.off()
#inset=0.01)





