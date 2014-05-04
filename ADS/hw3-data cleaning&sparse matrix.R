#load the data in
data=read.csv("/Users/quwangguifen/adshw3/data.csv", header=FALSE)
head(data)
attach(data)
#1st sum the rows having missing values

#to find how many missing values in each column
sum((V1==" ?")==T)
sum((V2==" ?")==T)
sum((V3==" ?")==T)
sum((V4==" ?")==T)
sum((V5==" ?")==T)
sum((V6==" ?")==T)
sum((V7==" ?")==T)
sum((V8==" ?")==T)
sum((V9==" ?")==T)
sum((V10==" ?")==T)
sum((V11==" ?")==T)
sum((V12==" ?")==T)
sum((V13==" ?")==T)
sum((V14==" ?")==T)
sum((V15==" ?")==T)
names(data)=c("age","workclass","fnlwgt","education","edunum","maritalstatus","occupation","relationship","race","sex","capitalgain","capitalloss","hoursperweek","nativecountry","salary")
check<-(data==" ?")
answer<-which(check,arr.ind=TRUE)
delete<-unique(answer[,1])
#2nd delete the rows which have missing values
data=data[-delete,]

#since the number of rows with missing values is not big enough to affect the whole data, compared with
#total number of observations, we decide to delete the rows direcltly.

#3rd transform the category variables into dummy variables for later analysis
install.packages("caret")
require("caret")
age=data[,1];workclass=data[,2];fnlwgt=data[,3]
education=data[,4];edunum=data[,5];maritalstatus=data[,6]
occupation=data[,7];relationship=data[,8];race=data[,9]
sex=data[,10];capitalgain=data[,11];capitalloss=data[,12]
hoursperweek=data[,13];nativecountry=data[,14];salary=data[,15]

as.factor(workclass)
wcdummy=dummyVars(~workclass,data)
wcmatrix=predict(wcdummy, newdata=data)
wcmatrix1=wcmatrix[,-1]


edudummy=dummyVars(~education,data)
edumatrix=predict(edudummy, newdata=data)

msdummy=dummyVars(~maritalstatus,data)
msmatrix=predict(msdummy, newdata=data)

ocdummy=dummyVars(~occupation,data)
ocmatrix=predict(ocdummy, newdata=data)
ocmatrix1=ocmatrix[,-1]


rsdummy=dummyVars(~relationship,data)
rsmatrix=predict(rsdummy, newdata=data)

rcdummy=dummyVars(~race,data)
rcmatrix=predict(rcdummy, newdata=data)

sexdummy=dummyVars(~sex,data)
sexmatrix=predict(sexdummy, newdata=data)


ncdummy=dummyVars(~nativecountry,data)
ncmatrix=predict(ncdummy, newdata=data)
ncmatrix1=ncmatrix[,-1]

sadummy=dummyVars(~salary,data)
samatrix=predict(sadummy, newdata=data)
#check
head(samatrix)
dim(samatrix)
sparse=cbind(age,wcmatrix1,edumatrix,edunum,msmatrix,ocmatrix1,rsmatrix,rcmatrix,sexmatrix,capitalgain,capitalloss,hoursperweek,ncmatrix1,samatrix)
dim(sparse)
head(sparse)
##########finish data cleaning here#########################




