########## Reading data 

col.names=c("No","Type","BusinessID","City"
            ,"Stat","Latitude","Longitude","Stars"
            ,"Review","Categories","Accepts Credit Cards"
            ,"Price Range","Take-out","Wi-Fi","Noise Level"
            ,"Takes Reservations","Has TV","Delivery","Ambience-romantic"
            ,"intimate","touristy","hipster","divey","classy","trendy","upscale"
            ,"casual","Outdoor Seating","Attire","Alcohol","Waiter Service"
            ,"Good for Kids","Good For Groups","Parking-garage","street"
            ,"validated","lot","valet")
data=read.table("business3.txt",col.names=col.names,header=F,na.strings=TRUE, 
                stringsAsFactors=FALSE, fill=TRUE,sep="%")

View(data)

Cat=data[,10]
D=rep(0,15584) ##This is going to store the categories without the "[ ]"
C=rep(0,15584) ##This is going to be the number of categories in each row of categories
require(stringr)
for (i in 1:15584)
{
  D[i]=substr(Cat[i],2,nchar(Cat[i])-1)
  C[i]=length(unlist(strsplit(D[i], ",")))
}


N=which(C=="0") ## find out which rows of categories are missing, there are 115 missing values
D1=D[-N] ## subset the non-missing rows, there are 15469 left

R=rep(0,15469) ## indicator variable for identifying "Restaurant"
regexp="Restaurant"

for (i in 1:15469)
{
  if (grepl(pattern=regexp, x=D1[i])==TRUE) R[i]=1
}

r=which(R==1) ## find out which rows have restaurant

length(r) ## there are 5556 rows

data1=data[-N,]
data2=data1[r,]
data2[,10]=D1[r]
View(data2)


##### Removing u
Cat=data2[,10] ## data2 is the data that contains the 5556 restaurants
cat=Cat ## new variable to store the category
require(gdata)

for (i in 1:5556)
{
  X=""
  Y=""
  for (j in 1:length(unlist(strsplit(Cat[i], ","))))
  {
    X[j]=trim(unlist(strsplit(Cat[i], ","))[j])
    Y[j]=substr(X[j],2,nchar(X[j]))
  }
  cat[i]=paste(Y,collapse=",")
}
length(cat)

data2[,10]=cat
View(data2)


#################### Exploratory data analysis

library(ggplot2)
library(grid)
dev.off()

# Figure 1 - Star distribution
StarRating <- ggplot(data2, aes(factor(Stars)))
StarRating + geom_bar(stat="bin", fill = "salmon", colour="salmon", binwidth =.2) +
  xlab("Stars") +
  ylab("Count") +
  ggtitle("Figure1. Star rating distribution of Restaurants in AZ")

# Fig2 -Star with Price range (pricier, higher score)
ggplot(data2, aes(Price.Range, Stars, fill=Price.Range)) + geom_boxplot() + # more pricy, higher score
  xlab("Price Range") +
  ylab("Stars") +
  ggtitle("Figure2. A distribution of Star by Price Range of Restaurants in AZ")
  
# Fig3 - Star with Noise level (very_loud,low stars)
ggplot(data2, aes(Noise.Level, Stars, fill=Noise.Level)) + geom_boxplot() +
  xlab("Noise Level") +
  ylab("Stars") +
  ggtitle("Figure3. A distribution of Star by Noise Level of Restaurants in AZ")

# Price range count
StarRating <- ggplot(data2, aes(Price.Range))
StarRating + geom_bar(stat="bin", fill = "skyblue", colour="skyblue", binwidth =.2) +
  xlab("Price Range") +
  ylab("Count") +
  ggtitle("Figure1. Star rating distribution of Restaurants in AZ")

# number of buinesses in each city
ggplot(data2) + geom_bar(aes(x=City), fill="blue") +
  coord_flip()
#Reorder
data2 = transform(data2, City=reorder(City, 
                                      1+numeric(dim(data2)[1]),                      
                                      FUN=sum))
ggplot(data2) + geom_bar(aes(x=City), fill="blue") +
  coord_flip() + 
  theme(axis.text.y=element_text(size=rel(0.8)))

# I wanted to explore how each city assigns stars to businesses 

library(data.table)
dt <- data.table(data2)
city_stars <- dt[, count(Stars), by=(City)]
colnames(city_stars) <- c("city", "stars", "freq")

ggplot(city_stars, aes(x=stars, y=city)) +
  geom_tile(aes(fill=freq)) +
  # xlim(stars) +
  scale_fill_gradient(low="white", high="red")+theme_bw() +
  labs(title = "Cities by Stars score")

# Then, I realized because the number of businesses varies significantly (e.g. phoenix has 2018 businesses )
# so I calculated percentage of stars within city
# to see distribution of ratings within city 

#Figure 4. A heatmap of Average Star Rating by different cities
dt1 <- data.table(city_stars)
percent <- dt1[, freq/sum(freq)*100, by=city]
city_stars <- cbind(city_stars, percent)
names(city_stars)[5] <- "percent"

ggplot(city_stars, aes(x=stars, y=city)) +
  geom_tile(aes(fill=percent)) +
  # xlim(stars) +
  scale_fill_gradient(low="white", high="red")+ theme_bw() +
  labs(title = "Cities by Stars score") +
xlab("Average Stars") +
  ylab("City") +
  ggtitle("Figure4. A heatmap of Average Star Rating of Restaurants in different cities of AZ")

#scatterplot by city
library(ggplot2)
ggplot(data2, aes(x= Stars, y= Review, color=Price.Range)) + 
  facet_wrap(~City) + geom_point(size=4)+ 
  scale_color_discrete(name = "Price Range")

# Statistics
table(data2$Price.Range) # 1 to 4: 4 levels
summary(unique(data2$City)) # 51 cities
table(data2$Stars) # 1 to 5: 9 levels
unique(table(data2$Review)) # 58 different number of reviews

########## create sparse matrix

creating sparse matrix:
  data=read.table("restaurant.txt",header=T)
View(data)

which(data$Accepts.Credit.Cards=="{}")
data[1560,11]="Miss"

require("caret")
##from 11th col, create dummy vars
##Accepts.Credit.Cards
ccdummy=dummyVars(~Accepts.Credit.Cards,data)
ccmatrix=predict(ccdummy, newdata = data)
ccmatrix=ccmatrix[,-1]
ccmatrix=ccmatrix[,-2]
head(ccmatrix)


##Price.Range
prdummy=dummyVars(~Price.Range,data)
prmatrix=predict(prdummy, newdata = data)
prmatrix=prmatrix[,-5]
head(prmatrix)

##Take.out
todummy=dummyVars(~Take.out,data)
tomatrix=predict(todummy, newdata = data)
tomatrix=tomatrix[,-2]
head(tomatrix)

##Wi.Fi
wfdummy=dummyVars(~Wi.Fi,data)
wfmatrix=predict(wfdummy, newdata = data)
wfmatrix=wfmatrix[,-2]
head(wfmatrix)

##Noise.Level
nldummy=dummyVars(~Noise.Level,data)
nlmatrix=predict(nldummy, newdata = data)
nlmatrix=nlmatrix[,-3]
head(nlmatrix)

##Takes.Reservations
trdummy=dummyVars(~Takes.Reservations,data)
trmatrix=predict(trdummy, newdata = data)
trmatrix=trmatrix[,-2]
head(trmatrix)

##Has.TV
htdummy=dummyVars(~Has.TV,data)
htmatrix=predict(htdummy, newdata = data)
htmatrix=htmatrix[,-2]
head(htmatrix)

##Delivery
ddummy=dummyVars(~Delivery,data)
dmatrix=predict(ddummy, newdata = data)
dmatrix=dmatrix[,-2]
head(dmatrix)

##Ambience.romantic
ardummy=dummyVars(~Ambience.romantic,data)
armatrix=predict(ardummy, newdata = data)
armatrix=armatrix[,-2]
head(armatrix)

##intimate
idummy=dummyVars(~intimate,data)
imatrix=predict(idummy, newdata = data)
imatrix=imatrix[,-2]
head(imatrix)

##touristy
tdummy=dummyVars(~touristy,data)
tmatrix=predict(tdummy, newdata = data)
tmatrix=tmatrix[,-2]
head(tmatrix)

##hipster
hdummy=dummyVars(~hipster,data)
hmatrix=predict(hdummy, newdata = data)
hmatrix=tmatrix[,-2]
head(hmatrix)

##divey
didummy=dummyVars(~divey,data)
dimatrix=predict(didummy, newdata = data)
dimatrix=dimatrix[,-2]
head(dimatrix)

##classy
cdummy=dummyVars(~classy,data)
cmatrix=predict(cdummy, newdata = data)
cmatrix=cmatrix[,-2]
head(cmatrix)

##trendy
tydummy=dummyVars(~trendy,data)
tymatrix=predict(tydummy, newdata = data)
tymatrix=tymatrix[,-2]
head(tymatrix)

##upscale
udummy=dummyVars(~upscale,data)
umatrix=predict(udummy, newdata = data)
umatrix=umatrix[,-2]
head(umatrix)

##casual
cadummy=dummyVars(~casual,data)
camatrix=predict(cadummy, newdata = data)
camatrix=camatrix[,-2]
head(camatrix)

##Outdoor.Seating
osdummy=dummyVars(~Outdoor.Seating,data)
osmatrix=predict(osdummy, newdata = data)
osmatrix=osmatrix[,-2]
head(osmatrix)

##Attire
adummy=dummyVars(~Attire,data)
amatrix=predict(adummy, newdata = data)
amatrix=amatrix[,-4]
head(amatrix)

##Alcohol
aldummy=dummyVars(~Alcohol,data)
almatrix=predict(aldummy, newdata = data)
almatrix=almatrix[,-3]
head(almatrix)

##Waiter.Service
wsdummy=dummyVars(~Waiter.Service,data)
wsmatrix=predict(wsdummy, newdata = data)
wsmatrix=wsmatrix[,-2]
head(wsmatrix)

##Good.for.Kids
gkdummy=dummyVars(~Good.for.Kids,data)
gkmatrix=predict(gkdummy, newdata = data)
gkmatrix=gkmatrix[,-2]
head(gkmatrix)

##Good.For.Groups
ggdummy=dummyVars(~Good.For.Groups,data)
ggmatrix=predict(ggdummy, newdata = data)
ggmatrix=ggmatrix[,-2]
head(ggmatrix)

##Parking.garage
pgdummy=dummyVars(~Parking.garage,data)
pgmatrix=predict(pgdummy, newdata = data)
pgmatrix=pgmatrix[,-2]
head(pgmatrix)

##street
sdummy=dummyVars(~street,data)
smatrix=predict(sdummy, newdata = data)
smatrix=smatrix[,-2]
head(smatrix)

##validated
vdummy=dummyVars(~validated,data)
vmatrix=predict(vdummy, newdata = data)
vmatrix=vmatrix[,-2]
head(vmatrix)

##lot
ldummy=dummyVars(~lot,data)
lmatrix=predict(ldummy, newdata = data)
lmatrix=lmatrix[,-2]
head(lmatrix)

##valet
vadummy=dummyVars(~valet,data)
vamatrix=predict(vadummy, newdata = data)
vamatrix=vamatrix[,-2]
head(vamatrix)

sparse=cbind(ccmatrix,prmatrix,tomatrix,wfmatrix,nlmatrix,trmatrix,htmatrix,dmatrix,
             armatrix,imatrix,tmatrix,hmatrix,dimatrix,cmatrix,tymatrix,umatrix,
             camatrix,osmatrix,amatrix,almatrix,wsmatrix,gkmatrix,ggmatrix,
             pgmatrix,smatrix,vmatrix,lmatrix,vamatrix)
dim(sparse)


############## 1. Multinomial Logistic Regression 
require(foreign)
require(nnet)
require(ggplot2)
require(reshape2)

names(sparse)
attach(restaurant)
data=cbind(sparse,Stars)
data2=as.data.frame(data)
attach(data2)

##cross validation to get the average MSE
size=round(n/5)
n=nrow(data2)
m=1:n
index1=sample(m,size)
index2=sample(m[-index1],size)
index3=sample(m[-index1-index2],size)
index4=sample(m[-index1-index2-index3],size)
index5=sample(m[-index1-index2-index3-index4],size+1)
index=list(index1,index2,index3,index4,index5)
avg_mean=rep(0,5)

for(i in 1:5)####for which fold to be the test set
{
  #multinomial logistic regression, set baseline first
  train.data=data2[-index[[i]],]
  test.data=data2[index[[i]],]
  mlogistic.train<- multinom(train.data[,63] ~., data = train.data[,-63])
  ## extract the coefficients from the model and exponentiate
  exp(coef(mlogistic.train))
  ##calculate predicted value for each of our outcome levels
  pp <- predict(mlogistic.train,test.data[,-63])
  ##compute MSE
  avg_mean[i]=mean((as.numeric(levels(pp))[pp]-Stars[index[[i]]])^2)
}
avg_mse=mean(avg_mean)
avg_mse

par(mfrow=c(3,3))
#ridge
library(glmnet)
n=nrow(data)
train.data=data[1:(n/2),]
test.data=data[((n/2)+1):n,]
cv.ridge<-cv.glmnet(x=train.data[,-63],y=Stars.train,alpha=0,nfold=5,type.measure="class")
plot(cv.ridge)
plot(cv.ridge$glmnet.fit)
abline(v=c(cv.ridge$lambda.min))
#mse of ridge regression
ridge.pred<-predict(cv.ridge,newx=test.data[,-63])
mean((ridge.pred-Stars.test)^2)
# 0.4907801

#lasso
cv.lasso<-cv.glmnet(x=train.data[,-63],y=Stars.train,alpha=1,nfold=5,type.measure="class")
plot(cv.lasso)
plot(cv.lasso$glmnet.fit)
abline(v=c(cv.lasso$lambda.min))
lasso.pred<-predict(cv.lasso,newx=test.data[,-63])
mean((lasso.pred-Stars.test)^2)
#0.4833703 

############ 2. Naive Bayes

restaurant=read.table("/Users/stinelee/Desktop/Final/YelpData/restaurant.txt",header=T,na.strings=TRUE, stringsAsFactors=FALSE, fill=TRUE,sep=" ")
newv=read.table("/Users/stinelee/Documents/Final4249/res_foodfreq.txt",header=T,na.strings=TRUE, stringsAsFactors=FALSE, fill=TRUE,sep="")
library(plyr)
names(restaurant)[3]=c("BusinessID")
names(newv)[1]=c("BusinessID")
joint=join(y=newv,x=restaurant,by="BusinessID")

#check
sum(joint[,44]-restaurant[,1])
nn=cbind(restaurant,joint[,43])
View(nn)
restaurant=nn
write.table(restaurant, file="Nrestaurant.txt",row.names=TRUE,sep=",")


View(restaurant)
Class=restaurant[,8]
plot(table(Class))
#table(restaurant[,2]) 
#all business
#table(restaurant[,30])
#4 lever: ?;beer_and_wine;full_bar;none
Category=restaurant[,10]
View(Category)
#Well...let's do it without Category first!
delete=c(1,2,3,5,6,7,8,10)#
new=restaurant[,-delete]
View(new)
#Step1: calculate class priors:
calculate.priors <- function(class.vector){
  priors <- c()
  for (class in unique(sort(class.vector))){
    priors <- rbind(priors, c(class, length(class.vector[class.vector==class])/length(class.vector)))
    colnames(priors) <- c("classification", "probability")
  }
  return (priors)
}
priors <- calculate.priors(Class)#priors for different classes
priors
#check sum(priors[,2])
#-------------------------------------------------------------
table(new[,6])
table(new[,21])
unique(new[,22])
table(new[,22])
#-------------------------------------------------------------
#Step2.1 handling review Counts.---------------
Reviewcount=new[,2]
plot(table(Reviewcount))
RCC=cbind( Freq=table(Reviewcount), Cumul=cumsum(table(Reviewcount)), relative=prop.table(table(Reviewcount)),cumpro=(cumsum(table(Reviewcount))/5556))
colnames(RCC)<-c("Frequency","Cumsum","relative Probability","CumProbability")
View(RCC)
RCL=c(1:5556)#2778
for( i in 1:5556){
  if(Reviewcount[i]<6)
    RCL[i]="Low"
  else if (Reviewcount[i]>=6 & Reviewcount[i]<16) 
    RCL[i]="Medium"
  else if (Reviewcount[i]>=16 & Reviewcount[i]<52) 
    RCL[i]="High"
  else 
    RCL[i]="Popular"
}
table(RCL)
new[,2]=RCL
write.table(new, file="newtest.txt",row.names=TRUE,sep=",")
new=read.table("/Users/stinelee/Documents/Final4249/newtest.txt",header=T,na.strings=TRUE, stringsAsFactors=FALSE, fill=TRUE,sep=",")
#End 2.1-----------------------------------------
#2.1.1 Check Review with stars
likelihood.list <- list()
priors <- calculate.priors(Class)
feature.values <- new[, 2]
unique.feature.values <- unique(feature.values)
likelihood.matrix <- matrix(rep(NA), nrow=nrow(priors), ncol=length(unique.feature.values))
colnames(likelihood.matrix) <- unique.feature.values
rownames(likelihood.matrix) <- priors[, "classification"]
for (item in unique.feature.values){
  likelihood.item <- vector()
  for (class in priors[, "classification"]){
    feature.value.inclass <- feature.values[Class==class]
    likelihood.value <- length(feature.value.inclass[feature.value.inclass==item])/length(feature.value.inclass)
    likelihood.item <- c(likelihood.item, likelihood.value)
  }
  likelihood.matrix[, item] <- likelihood.item
}
likelihood.list[[1]] <- likelihood.matrix
View(likelihood.matrix)
mmm=matrix(1:36,nrow=9)
mmm[,1]=likelihood.matrix[,1]
mmm[,2]=likelihood.matrix[,3]
mmm[,3]=likelihood.matrix[,4]
mmm[,4]=likelihood.matrix[,2]
colnames(mmm) <- c("Low","Medium","High","Popular")
rownames(mmm) <- priors[, "classification"]
myImagePlot(mmm)
remove(mmm)
remove(likelihood.matrix)
remove(likelihood.list)
remove(feature.values)
remove(unique.feature.values)

#Step2: Learn the features by calculating likelihood------------
likelihood.list <- list()
for (i in 1:ncol(new)){
  feature.values <- new[, i]
  unique.feature.values <- unique(feature.values)
  likelihood.matrix <- matrix(rep(NA), nrow=nrow(priors), ncol=length(unique.feature.values))
  colnames(likelihood.matrix) <- unique.feature.values
  rownames(likelihood.matrix) <- priors[, "classification"]
  for (item in unique.feature.values){
    likelihood.item <- vector()
    for (class in priors[, "classification"]){
      feature.value.inclass <- feature.values[Class==class]
      likelihood.value <- length(feature.value.inclass[feature.value.inclass==item])/length(feature.value.inclass)
      likelihood.item <- c(likelihood.item, likelihood.value)
    }
    likelihood.matrix[, item] <- likelihood.item
  }
  likelihood.list[[i]] <- likelihood.matrix
}
View(likelihood.list)


#------Now have the conditional Probability for different variable
# colbind to new 
#Step 3: train dataset first.
test.features <- new
test.target.class <- Class
test.predict.class <- rep(NA, nrow(test.features))
#priors[,2]=rep(1/9,9)
#calculate posteriors for each test data record
a=c(1:length(test.predict.class))
for (i in 1:dim(test.features)[1]){
  record <- test.features[i, ]
  posterior <- vector()
  #calculate posteriors for each possible class of that record###
  for (class in priors[, "classification"]){
    #initialize posterior as the prior value of that class
    posterior.value <- as.numeric(priors[priors[, "classification"]==class, 2])
    likelihood.v <- c()
    for (j in 1:length(record)){
      likelihood.value <- likelihood.list[[j]][class, as.character(record[1, j])]
      likelihood.v <- c(likelihood.v, likelihood.value)
      posterior.value <- as.numeric(posterior.value) * as.numeric(likelihood.value)
    }
    posterior <- rbind(posterior, c(class, posterior.value)) 
  }###
  a[i]=which(posterior[,2]==max(posterior[,2]))
  predict.class <- posterior[a[i],1]
  test.predict.class[i] <- predict.class
}
miss=abs(test.predict.class-Class)
missrate=c(1:5556)
for (i in 1:5556){
  if (miss[i]<=0.5)
    missrate[i]=0
  else
    missrate[i]=1
}
sum(missrate)/5556 #0.7485601/#0.6232901 for 1st+2nd/2

#################NB works better on 2 catagory...
#MSE and choose u for smoothing
View(cbind(test.predict.class,Class))
MSE=sum((test.predict.class-Class)^2)/5556
MSE#1.518179
RMSE=sqrt(MSE)
RMSE
plot(table(test.predict.class))

test=read.table("/Users/stinelee/Documents/Final4249/text.txt",header=T,na.strings=TRUE, stringsAsFactors=FALSE, fill=TRUE,sep=",")
test=as.vector(test)
new1=restaurant[test[,1],]
new=new1[,-delete]

#Test
prediction=test.predict.class
real=new1[,8]

tMSE=sum((prediction-real)^2)/2778
tMSE#2.118161
miss=abs(prediction-real)

missrate=c(1:2778)
for (i in 1:2778){
  if (miss[i]==0)
    missrate[i]=0
  else
    missrate[i]=1
}
sum(missrate)/2778 #0.9262059 strict error rate

missrate=c(1:2778)
for (i in 1:2778){
  if (miss[i]<=0.5)
    missrate[i]=0
  else
    missrate[i]=1
}
sum(missrate)/2778 #0.75054 flexible error rate.

########3 1. Random forests
Random Forest:
  
  data=read.table("restaurant.txt",header=T)
View(data)
names(data)
## deal with missing values and some obvious wrong values.
data[data=="Miss"]=NA


##make dummy var of City
## only catch the 99%, the rest are classified to "Other"

cityorder=sort(table(data$City))
dim(cityorder)
## 49 values
table(data$City)
cityorder1=as.vector(cityorder)
N=rep(0,5556)
for (i in 2:51){
  N[i]=sum(cityorder1[1:i])
  if (N[i-1]<55&N[i]>=55) break
  print(i);
}
##Get the first 20 cover 1% of them all.

a=names(sort(table(data$City)))[1:20]

data$City=as.character(data$City)
for (i in 1:5556)
{
  for (j in 1:20)
  {
    if (grepl(pattern =a[j],x=data$City[i])==TRUE) data$City[i]="Other"
  }
}
table(data$City)
data$City=as.factor(data$City)

require("caret")
cdummy=dummyVars(~City,data)
cmatrix=predict(cdummy, newdata = data)
head(cmatrix)


##making the new data
s=c(-1,-2,-3,-4,-5,-6,-7,-10)
data=data[,s]
data=cbind(data,cmatrix)
View(data)

## removing the space in the variable names
require(stringr)
name=names(data)

for (i in 31:60)
{
  X=unlist(strsplit(name[i]," "))
  name[i]=paste(X,collapse="")
}
names(data)=name

##rf


data=read.table("rfdata.txt",header=T)
set.seed(1)
train=sample(1:nrow(data),nrow(data)/2)
data=data[,-61]
data.train=data[train,]
data.test=data[-train,]

##first try doing it by ignoring the missing values
## Do rf 100 times
require(randomForest)
A=rep(0,100)
for (i in 1:100)
{
  rf.train=randomForest(Stars~.,data.train,mtry=20,importance=TRUE,na.action = na.omit)
  yhat.rf=predict(rf.train, newdata =data.test)
  N=which(yhat.rf!="NA")
  A[i]=mean((yhat.rf[N] - data.test[N,1])^2)*5556/(5556-59-1)
}

#rf.train
#importance(rf.train)

## adding a new feature
data=read.table("rfdata.txt",header=T)
data.train=data[train,]
data.test=data[-train,]

B=rep(0,100)
for (i in 1:100)
{
  rf.train=randomForest(Stars~.,data.train,mtry=20,importance=TRUE,na.action = na.omit)
  yhat.rf=predict(rf.train, newdata =data.test)
  M=which(yhat.rf!="NA")
  B[i]=mean((yhat.rf[M] - data.test[M,1])^2)*5556/(5556-60-1)
}

C=cbind(A,B)

write.table(C,"rfresult.txt",row.names=F)

C=read.table("rfresult.txt",header=T)
attach(C)
plot(A,type="o",xlab="Run time",ylab="MSE",main="Random Forest results",ylim=c(0.245,0.252),col="blue")
lines(B,type="o",,col="red")


##then try with imputation

data.imputed=rfImpute(Stars~.,data.train)
rf.train2=randomForest(Stars~.,data.imputed,mtry=20,importance=TRUE)
yhat.rf2=predict(rf.train2, newdata =data.test)
X=which(yhat.rf2!="NA")
mean((yhat.rf[X] - data.test[X,1])^2)*5556/(5556-59-1)



