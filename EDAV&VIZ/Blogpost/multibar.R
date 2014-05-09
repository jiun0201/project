####################1. ggplot attempt
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

#Subset the rest except for total
newdata <- reshape.data[c(-1,-19,-37,-55),]
sort <- newdata[order(newdata$language),] 

class(sort$language)

######  Bar Chart Language
BarChartLang <- ggplot(data=sort, aes(x=time, y=numbers, color=language, 
                                      group=language, fill=language)) + 
  geom_bar(stat="identity", position=position_dodge()) + 
  facet_wrap(~language, scales="free_y") + 
  xlab("Years") + 
  ylab("The total number (000') of each languages spoken in the US over time") + 
  labs(title = "Top Languages Other than English Spoken in 1980-2010")
BarChartLang

###################### 2.nvd3

d<-read.csv("toplanguagespoken.csv", header=T)
names(d) <- c("label", "1980", "1990", "2000", "2010")


library(reshape2)
newd<-melt(d, variable.name="year")


names(newd)
class(newd$label)
newd$label <- as.character(newd$label)
newd <- newd[c(-1,-19,-37,-55),]
newd$label[newd$label == "Spanish or Spanish Creole (2)"] <- "Spanish or Spanish Creole"
newd$label[newd$label == "French (2)"] <- "French"
newd$label[newd$label == "Portuguese (2)"] <- "Portuguese"
newd <-newd[order(newd$label, newd$year,decreasing = F), ]

#1) csv to json by language
require(RJSONIO)
makeList<-function(x){
  if(ncol(x)>2){
    listSplit<-split(x[-2],x[2],drop=T)
    lapply(names(listSplit),function(y){list(name=y,children=makeList(listSplit[[y]]))})
  }else{
    lapply(seq(nrow(x[1])),function(y){list(label=x[,1][y],value=x[,2][y])})
  }
}


jsonOut<-toJSON(list(name="newd",values=makeList(newd[-1])))

cat(jsonOut)

#2) csv to json by year
require(RJSONIO)
makeList<-function(x){
  if(ncol(x)>2){
    listSplit<-split(x[-1],x[1],drop=T)
    lapply(names(listSplit),function(y){list(name=y,children=makeList(listSplit[[y]]))})
  }else{
    lapply(seq(nrow(x[1])),function(y){list(label=x[,1][y],value=x[,2][y])})
  }
}


jsonOut<-toJSON(list(name="newd",values=makeList(newd[-2])))

cat(jsonOut)
