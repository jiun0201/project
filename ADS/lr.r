rm(list = ls())
theURL="https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data"
data=read.table(theURL, header=FALSE,sep=",")


names(data)=c("age","workclass","fnlwgt","education","edunum","maritalstatus","occupation","relationship","race","sex","capitalgain","capitalloss","hoursperweek","nativecountry","salary")
# create dummy variables for workclass, education, maritalstatus, occupation, relationship, race, sex, nativecountry and salary.

#delete rows with "?"
check=(data==" ?")
answer=which(check,arr.ind=TRUE)
dim(answer)
answer=as.data.frame(answer)
uni=as.data.frame(unique(answer[,1]))
dim(uni)
head(uni)
dim(data)
data=data[-uni[,1],]
dim(data)





#make dummy variables
require("caret")


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
#head(samatrix)
#dim(samatrix)


sparse=cbind(data$fnlwgt,data$age,wcmatrix1,edumatrix,data$edunum,msmatrix,ocmatrix1,rsmatrix,rcmatrix,sexmatrix,data$capitalgain,data$capitalloss,data$hoursperweek,ncmatrix1)
dim(sparse)
sparse1=cbind(data$fnlwgt,data$age,wcmatrix1,edumatrix,data$edunum,msmatrix,ocmatrix1,rsmatrix,rcmatrix,sexmatrix,data$capitalgain,data$capitalloss,data$hoursperweek,ncmatrix1)
train.sparse1=sparse1[1:15081,]
test.sparse1=sparse1[15082:30162,]

# 0 for <=50K, 1 for >50K
y=samatrix[,2]
trainy=y[1:15081]
testy=y[15082:30162]
train.sparse=sparse[1:15081,]
test.sparse=sparse[15082:30162,]
trainy=as.factor(trainy)
null=lm(trainy~1,data=train.sparse1,family="binomial")
full=lm(trainy~.,data=train.sparse1)
forward=step(null, scope=list(lower=null, upper=full), direction="forward")
summary(forward)

glm=glm(trainy~.,data=train.sparse1,family=binomial)

require(glmnet)
fit=glmnet(train.sparse,trainy,family="binomial")
plot(fit, xvar = "dev", label = TRUE)
pred1=predict(fit,newx=train.sparse,type ="class",s=0.01)
table(pred1,trainy)
(1730+654)/15081
#0.1580797

#Misclassification rate for salary >50K, i.e. y=1
1730/3728
#0.4640558

pred2=predict(fit,newx=test.sparse,type="class",s=0.01)
table(pred2,testy)
(1743+646)/15081
#0.1584112

#Misclassification rate for salary >50K, i.e. y=1
1743/3780
#0.4611111


#choosing the best lambda using cv.glmnet

cvfit = cv.glmnet(train.sparse, trainy, family = "binomial", type.measure = "class")
plot(cvfit)
cvfit$lambda.min
cvfit$lambda.1se
coef(cvfit, s = "lambda.min")
pred3=predict(cvfit, newx=train.sparse, s = "lambda.min", type = "class")
table(pred3,trainy)
(1498+805)/15081
#0.1527087

#Misclassification rate for salary >50K, i.e. y=1
1498/3728
#0.401824

pred4=predict(cvfit, newx=test.sparse, s = "lambda.min", type = "class")
table(pred4,testy)
(1500+789)/15081
#0.1517804

#Misclassification rate for salary >50K, i.e. y=1
1500/3780
#0.3968254

