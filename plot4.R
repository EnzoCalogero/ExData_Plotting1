plot4<-function(){
        library(data.table)
        library(dplyr)
        library(lubridate)
        
        ##read the data set file 
        dataset<-fread("./household_power_consumption.txt")
        
        #Aggregate the date and the time and trasform in date using the 
        #lubridate library functions
        
        dataset<-mutate(dataset,  Date= dmy_hms(paste(dataset$Date,dataset$Time,sep="-")))
        
        #Filtered the data set for the two requested days
        dataset<-filter(dataset, Date >= ymd_hms("2007-02-01 00:00:00"),Date < ymd_hms("2007-02-03 00:00:00"))
        
        #Convert the variable "Global_active_power" from character to numeric
        dataset$Global_active_power<-as.numeric(dataset$Global_active_power)
        
        #Set the graphics devices to the PNG
        png(filename="plot4.png",width=480,height=480)
        
        #create the Plot 
        
        par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
        
        #Second Graph
        with(dataset, plot(Date,Global_active_power,col="black",xlab="",ylab="Global Active Power",type = "l"))
        
        #third graph
        with(dataset, plot(Date,Voltage,col="black",xlab="datetime",ylab="Voltage",type = "l"))
        
        #Graph first 
        with(dataset, plot(Date,Sub_metering_1,xlab="",ylab="Energy sub metering",type = "n"))
        with(dataset, lines(Date,Sub_metering_1,col="black",type = "l"))
        with(dataset, lines(Date,Sub_metering_2,col="red",type = "l"))
        with(dataset, lines(Date,Sub_metering_3,col="blue",type = "l"))
        legend("topright", lwd = 1, col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
        
        
        
        
        #fourth graph
        
        with(dataset, plot(Date,Global_reactive_power,col="black",xlab="datetime",ylab="Global_reactive_power",type = "l"))
        
        #with(dataset, plot(Date,Global_active_power,col="black",xlab="",ylab="Global Active Power (kilowatts)",type = "l"))
        #close the set device 
        dev.off()
}