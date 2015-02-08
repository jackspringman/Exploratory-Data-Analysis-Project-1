# source data from household_power_consumption.txt and convert to a data table

source <- "household_power_consumption.txt"
data <- read.table(source, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

# convert Date column from characters to dates  

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subset data to the period required and remove original file from workspace

subset_data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data)

datetime <- paste(as.Date(subset_data$Date), subset_data$Time)
subset_data$Datetime <- as.POSIXct(datetime)

# Create Plot 4 

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subset_data, {
    plot(Global_active_power~Datetime, type="l", 
         ylab="Global Active Power", xlab="", cex.axis=0.75, cex.lab=0.75)
    plot(Voltage~Datetime, type="l", 
         ylab="Voltage", xlab="datetime", cex.axis=0.75, cex.lab=0.75)
    plot(Sub_metering_1~Datetime, type="l",
         ylab="Energy sub-metering", xlab="", cex.axis=0.75, cex.lab=0.75)
    lines(Sub_metering_2~Datetime,col="red")
    lines(Sub_metering_3~Datetime,col="blue")
    legend("topright", cex= 0.5, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col=c("black", "red", "blue"), lty=1, lwd=1)
    plot(Global_reactive_power~Datetime, type="l", 
         ylab="Global_reactive_power",xlab="datetime", cex.axis=0.75, cex.lab=0.75)
})

# Copy to file

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()


