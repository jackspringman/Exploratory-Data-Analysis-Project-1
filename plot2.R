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

# Create Plot 2  

plot(subset_data$Global_active_power~subset_data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

# Copy to file

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()


