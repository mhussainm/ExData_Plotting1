# The script reads the Electric Power Consumption dataset, obtains a subset, 
# and generates a histogram as 'plot1.png' file as required.
#
# PRE-REQUISITES: 
#   (1) This script expects the zipped file 'exdata-data-household_power_consumption.zip'
#       in the working directory.
#   (2) Sourcing and executing the function gen_plot1() without any parameters.
#
gen_plot1 <- function() {
    # read the dataset after unzipping the file
    powerdata <- read.table(unz("exdata-data-household_power_consumption.zip", 
            "household_power_consumption.txt"), 
            header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings="?");
    
    # rename variable names for ease of processing and readability
    names(powerdata) <- tolower(gsub("_", "", names(powerdata)));
    
    # subset the data only for two days worth of observations i.e. dates 2007-02-01 and 2007-02-02
    reqdata <- subset(powerdata, date == "1/2/2007" | date == "2/2/2007");
    
    ## generate the PNG file with the required plot
    # open the PNG device with a custom background
    png(file = "plot1.png", bg = "white");
    # generating plot with custom color, title, and X-axis label
    hist(pwrd$globalactivepower, col = "red", main = "Global Active Power", 
            xlab="Global Active Power (kilowatts)");
    # closing the PNG device
    dev.off();
    
    print("Plot generated on file: plot1.png")
}