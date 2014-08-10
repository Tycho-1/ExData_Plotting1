## The source of the data is stored in fileURL
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Checks if fille exists, and if not, downloads and unarchives it 
if (!file.exists("./Course Project 1/household_power_consumption.txt")) {
    download.file(fileURL,destfile = "./Course Project 1/power_cons.zip")
    unzip("./Course Project 1/power_cons.zip",exdir="./Course Project 1")
}

## Checks if the data is loaded into the global environment, if not - loads it
## and creates a data subset for the required dates
if (!exists("el_power"))  {
    el_power <- read.table("./Course Project 1/household_power_consumption.txt",
                           sep = ";", header=TRUE, stringsAsFactors = FALSE)
    
    # Merges 'Date' and 'Time' columns from the data and converts the 
    # resulting column into class 'POSIXlt' 'POSIXt' 
    el_power$Date <- strptime(paste(el_power$Date, el_power$Time), "%d/%m/%Y %H:%M:%S")
    
    # Subsetting the required part of the data and creating a separate dataset fot it
    index_subset <- (as.Date(el_power[,1]) == "2007-02-01")|(as.Date(el_power[,1]) == "2007-02-02")
    el_power_subset <- el_power[index_subset,]
    
    # Converting the rest of the data into class 'numeric'
    el_power_subset[3:9] <- sapply((el_power_subset[,3:9]), as.numeric)
}

##Plot2

# Opens a png graphics device
png(filename = "./Course Project 1/plot2.png",
    width = 480, height = 480, units = 'px', type = "cairo-png")
# Plotting the graph
with(el_power_subset, plot(Date,Global_active_power,type="l",
                           xlab = "", ylab = "Global Active Power (kilowatts)"))
# Closing the graphics device
dev.off()
