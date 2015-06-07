# The script reads the Electric Power Consumption dataset, obtains a subset, 
# and generates a Line Graph as 'plot4.png' file as required.
#
# PRE-REQUISITES: 
#   (1) This script expects the zipped file 'exdata-data-household_power_consumption.zip'
#       in the working directory.
#   (2) Sourcing and executing the function gen_plot4() without any parameters.
#
gen_plot4 <- function() {
    # read the dataset after unzipping the file
    powerdata <- read.table(unz("exdata-data-household_power_consumption.zip", 
            "household_power_consumption.txt"), 
            header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings="?");
    
    # rename variable names for ease of processing and readability
    names(powerdata) <- tolower(gsub("_", "", names(powerdata)));
    
    # subset the data only for two days worth of observations i.e. dates 2007-02-01 and 2007-02-02
    reqdata <- subset(powerdata, date == "1/2/2007" | date == "2/2/2007");
    
    # create new variable to hold the timestamp i.e. date and time as POSIXlt type
    reqdata$datetime <- strptime(paste(reqdata$date, reqdata$time, sep = " "), "%d/%m/%Y %H:%M:%S");
    
    ## generate the PNG file with the required plot
    # open the PNG device with a custom background
    png(file = "plot4.png", bg = "white");
    
    # set parameter to add four plots to the graphic device; generating column-wise
    par(mfcol=c(2,2));
    
    ## Plot 1 (Top Left) ##
    # generating plot with custom color, title, and X-axis label
    plot(reqdata$datetime, reqdata$globalactivepower, type="l", xlab = "", 
         ylab = "Global Active Power");
    
    ## Plot 2 (Bottom Left) ##
    # generating plot with first line (sub metering 1) and required labels
    plot(reqdata$datetime, reqdata$submetering1, type="l", xlab = "", ylab = "Energy sub metering");
    # adding 2nd line (sub metering 2) with custom color - red
    lines(reqdata$datetime, reqdata$submetering2, col="red");
    # adding 3rd line (sub metering 3) with a different custom color
    lines(reqdata$datetime, reqdata$submetering3, col="blue");
    # adding legend
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
            col = c("black", "red", "blue"), lty = 1, bty = "o");
    
    
    ## Plot 3 (Top Right) ##
    plot(reqdata$datetime, reqdata$voltage, type="l", xlab = "datetime", ylab = "Voltage");
    
    ## Plot 4 (Bottom Right) ##
    plot(reqdata$datetime, reqdata$globalreactivepower, type="l", xlab = "datetime", 
            ylab = "Global_reactive_power");
    
    # closing the PNG device
    dev.off();
    
    print("Plot generated on file: plot4.png")
}