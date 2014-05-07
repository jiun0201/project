library(XML)

# Reading data url
url <- "http://www.census.gov/dataviz/visualizations/045/508.php"
lang = readHTMLTable(url, header=T, which=1)

# Extracting ","
rmComaNum = function(x) as.numeric(gsub(",", "", as.character(x), fixed=T))
years = sapply(lang[,2:5], rmComaNum) 

# Scaling - dividing by 1000
years <- years/1000

# Extract the 'total raw'
newyears<- years[c(-1),]

years.matrix <- as.matrix(newyears)
#barplot(years.matrix, border=NA, space=0.25)

data <- data.frame(lang[,1])
data
data <- cbind(data, years)
names(data) <- c("language", "1980","1990","2000","2010")

#check the sum of 17 languages with the total
sapply(data[(2:18),(2:5)], sum)

#reshape the data into long format
reshape.data <- reshape(data, dir = "long", varying = 2:5,times=c(1980, 1990, 2000, 2010), v.names= "numbers",sep = "_")

#Total spoken languages other than English#
#Subset the total
Total <- subset(reshape.data[c(1, 19, 37, 55),])
require(useful)
#qplot(time, numbers, data=Total, geom="line") 
#barplot(Total$numbers, Total$time, border=NA) 

#Subset the rest except for total
newdata <- reshape.data[c(-1,-19,-37,-55),]
sort <- newdata[order(newdata$language),] 

class(sort$language)

gg <- ggplot(data = sort, aes(x=time, y=numbers))
gg <- gg + geom_point(aes(color = time), size=3)
# make strips by nosql db factor
gg <- gg + facet_grid(language~.)
# rotate the plot
gg <- gg + coord_flip()
# get rid of most of the junk
gg <- gg + theme_bw()
# add a title
gg <- gg + labs(x="h", title="AA")
# get rid of the legend
gg <- gg + theme(legend.position = "none")
# ensure the strip is gone
gg <- gg + theme(strip.text.x = element_blank())
gg

# Stacked bar graph
#ggplot(data=sort, aes(x=time, y=numbers, fill=language)) + geom_bar(stat="identity")

# Bar graph
sort$time <- as.factor(sort$time)

bar <- ggplot(data=sort, aes(x=language, y=numbers, fill=time)) + geom_bar(stat="identity", position=position_dodge()) + xlab("Languages") + ylab("The total number (000') of each languages spoken in the US over time") + labs(title = "Top Languages Other than English Spoken in 1980-2010")
bar

exceptforspanishbar <- ggplot(data=sort[-c(53:56),], aes(x=language, y=numbers, fill=time)) + geom_bar(stat="identity", position=position_dodge()) + xlab("Languages") + ylab("The total number (000') of each languages spoken in the US over time") + labs(title = "Top Languages Other than English and Spanish Spoken in 1980-2010")
exceptforspanishbar

######ChangeinLine
ChangeinLine <- ggplot(data=sort, aes(x=time, y=numbers, color=language, group=language)) + geom_line() + facet_wrap(~language, scales="free_y") + xlab("Years") + ylab("The total number (000') of each languages spoken in the US over time") + labs(title = "Top Languages Other than English Spoken in 1980-2010")
ChangeinLine

#reorder(g$y, sort$numbers)
#g +  gap.plot(sort$language,sort$numbers,gap=c(10000, 20000),gap.axis="sort$numbers",bgcol="white",breakcol="black",brw=0.02)
#axis.break(axis=2,breakpos=10000, bgcol="white",breakcol="black", style="zigzag", brw=0.02)
#breakpos=NULL,pos=NA, ,style="slash",)


ggplot(data=sort, aes(x=time, y=numbers, fill=language)) + geom_bar(stat="identity", position=position_dodge())
class(sort$time)

#break axis
g <- ggplot(data=sort[-c(53:56),], aes(x=language, y=numbers, fill=time)) + geom_bar(stat="identity", binwidth = 0.4, position=position_dodge())
g
g + facet_wrap(~time, scales="free_y")




ggplot(data=sort, aes(x=factor(language), y=numbers, fill=time)) + geom_bar(stat="identity",colour="black", position=position_dodge())



require(plotrix)
#require(gap.barplot)
#gap.barplot(sort,gap=c(10000000,30000000),xlab="Language",ytics=c(11000000,30000000),ylab="Values",main="Barplot with gap")


#qplot(language, data=sort, geom = "bar", fill = time,position="dodge")
#qplot(cut, data = diamonds, geom = "bar", fill = cut) + facet_grid(. ~ color) + opts(axis.text.x = theme_text(angle = 90, hjust = 1, size = 8,colour = "grey50"))
#Line graph
#qplot(time,numbers,color=language,group=language, data=sort,geom=c("point","line"),main="OH-01 2006 General Turnout by Age Group, Last 4 (Full)",xlab="Language",ylab="numbers") + scale_colour_hue(name="Langugage")



