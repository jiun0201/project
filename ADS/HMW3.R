require(XML)
library(RCurl)
# Importing data from URL#
theURL <- getURL("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data")
data=read.table(text=theURL, header=FALSE, sep=",", stringsAsFactors=FALSE)
names(data)=c("age","workclass","fnlwgt","education","edunum","maritalstatus","occupation","relationship","race","sex","capitalgain","capitalloss","hoursperweek","nativecountry","salary")
check<-(data==" ?")
answer<-which(check,arr.ind=TRUE)
# 4262 cells fil led with "?" which accounts for less than 1 % and in terms of obs, it becomes 30162 rows after removing 32561.
# So we decided to delete them.
delete<-unique(answer[,1])
data=data[-delete,]
require("outliers")
chisq.out.test(data$fnlwgt, variance=var(data$fnlwgt), opposite = FALSE) # Test cannot reject the null hypothesis that no outlier

#make dummy variables
require("caret")
data$age=as.character(data$age)
age=data$age
agdummy=dummyVars(~age,data)
agmatrix=predict(agdummy, newdata=data)
#check
#head(agmatrix)
#dim(agmatrix)
wcdummy=dummyVars(~workclass,data)
wcmatrix=predict(wcdummy, newdata=data)
#check
#head(wcmatrix)
#dim(wcmatrix)
#delete "?"
wcmatrix1=wcmatrix[,-1]
edudummy=dummyVars(~education,data)
edumatrix=predict(edudummy, newdata=data)
#check
#head(edumatrix)
#dim(edumatrix)
data$edunum=as.character(data$edunum)
edunum=data$edunum
endummy=dummyVars(~edunum,data)
enmatrix=predict(endummy, newdata=data)
#check
#head(enmatrix)
#dim(enmatrix)
msdummy=dummyVars(~maritalstatus,data)
msmatrix=predict(msdummy, newdata=data)
#check
#head(msmatrix)
#dim(msmatrix)
ocdummy=dummyVars(~occupation,data)
ocmatrix=predict(ocdummy, newdata=data)
#check
#head(ocmatrix)
#dim(ocmatrix)
#delete "?"
ocmatrix1=ocmatrix[,-1]
rsdummy=dummyVars(~relationship,data)
rsmatrix=predict(rsdummy, newdata=data)
#check
#head(rsmatrix)
#dim(rsmatrix)
rcdummy=dummyVars(~race,data)
rcmatrix=predict(rcdummy, newdata=data)
#check
#head(rcmatrix)
#dim(rcmatrix)
sexdummy=dummyVars(~sex,data)
sexmatrix=predict(sexdummy, newdata=data)
#check
#head(sexmatrix)
#dim(sexmatrix)
data$capitalgain=as.character(data$capitalgain)
capitalgain=data$capitalgain
cgdummy=dummyVars(~capitalgain,data)
cgmatrix=predict(cgdummy, newdata=data)
#check
#head(cgmatrix)
#dim(cgmatrix)
data$capitalloss=as.character(data$capitalloss)
capitalloss=data$capitalloss
cldummy=dummyVars(~capitalloss,data)
clmatrix=predict(cldummy, newdata=data)
#check
#head(clmatrix)
#dim(clmatrix)
data$hoursperweek=as.character(data$hoursperweek)
hoursperweek=data$hoursperweek
hwdummy=dummyVars(~hoursperweek,data)
hwmatrix=predict(hwdummy, newdata=data)
#check
#head(hwmatrix)
#dim(hwmatrix)
ncdummy=dummyVars(~nativecountry,data)
ncmatrix=predict(ncdummy, newdata=data)
#check
#head(ncmatrix)
#dim(ncmatrix)
#delete "?"
ncmatrix1=ncmatrix[,-1]
sadummy=dummyVars(~salary,data)
samatrix=predict(sadummy, newdata=data)
#check
sparse=cbind(agmatrix,wcmatrix1,edumatrix,enmatrix,msmatrix,ocmatrix1,rsmatrix,rcmatrix,sexmatrix,cgmatrix,clmatrix,hwmatrix,ncmatrix1)
dim(sparse)

# 0 for <=50K, 1 for >50K
y=samatrix[,2]
y=as.factor(y)
trainy=y[1:15081]
testy=y[15082:30162]
train.sparse=sparse[1:15081,]
test.sparse=sparse[15082:30162,]
train=data[1:15081,]
test=data[15082:30162,]


require(glmnet)
# 1. logistic

fit1=glmnet(train.sparse,trainy,family="binomial")
print(fit1)

plot(fit1, xvar = "dev", label = TRUE)
plot(fit1, xvar = "lambda", label = TRUE)
plot(fit1, xvar = "norm", label = TRUE)

# using CV for choosing best lambda
cvfit1 <- cv.glmnet(train.sparse,trainy,family = "binomial", type.measure = "class")
plot(cvfit1)
cvfit1$lambda.min
cvfit1$lambda.1se
coef(cvfit1, s = "lambda.min")

pred1=predict(cvfit1,newx=train.sparse, s = "lambda.min", type ="class")
table(pred1,trainy)
pred2=predict(cvfit1,newx=test.sparse, s = "lambda.min", type ="class")
table(pred2,testy)

# 2. Lasso

Lfit=glmnet(train.sparse,trainy,family="binomial")
print(Lfit)

plot(Lfit, xvar = "dev", label = TRUE)
plot(Lfit, xvar = "lambda", label = TRUE)
plot(Lfit, xvar = "norm", label = TRUE)

# using CV for choosing best lambda
cvLfit <- cv.glmnet(train.sparse,trainy,family = "binomial", type.measure = "class", alpha=1)
plot(cvLfit)
cvLfit$lambda.min
cvLfit$lambda.1se
coef(cvLfit, s = "lambda.min")

Lpred1=predict(cvLfit,newx=train.sparse, s = "lambda.min", type ="class", alpha=1)
table(Lpred1,trainy)
Lpred2=predict(cvLfit,newx=test.sparse, s = "lambda.min", type ="class", alpha=1)
table(Lpred2,testy)


# 3. Ridge

Rfit=glmnet(train.sparse,trainy,family="binomial")
print(Rfit)

plot(Rfit, xvar = "dev", label = TRUE)
plot(Rfit, xvar = "lambda", label = TRUE)
plot(Rfit, xvar = "norm", label = TRUE)

# using CV for choosing best lambda
cvRfit <- cv.glmnet(train.sparse,trainy,family = "binomial", type.measure = "class", alpha=0)
plot(cvLfit)
cvRfit$lambda.min
cvRfit$lambda.1se
coef(cvRfit, s = "lambda.min")

Rpred1=predict(cvRfit,newx=train.sparse, s = "lambda.min", type ="class", alpha=0)
table(Rpred1,trainy)
Rpred2=predict(cvRfit,newx=test.sparse, s = "lambda.min", type ="class", alpha=0)
table(Rpred2,testy)

par(mfrow=c(2, 2))

# 4. Elastic net
#install.packages('elasticnet')
library(elasticnet)

