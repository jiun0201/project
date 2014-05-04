##############KNN###################################
#k=1
library(class)
knn.pred=knn(traindata, testdata, usedata[(1:(n/2)),m],k = 1)
testtable=table(knn.pred ,usedata[15082:30162,m])
traintable=table(knn.pred ,usedata[1:15081,m])
knn.misrate.test=(testtable[1,2]+testtable[2,1])/n
knn.misrate.train=(traintable[1,2]+traintable[2,1])/n
knn.misrate.test
knn.misrate.train

#k=3
library(class)
knn.pred=knn(traindata, testdata, usedata[(1:(n/2)),m],k = 3)
testtable=table(knn.pred ,usedata[15082:30162,m])
traintable=table(knn.pred ,usedata[1:15081,m])
knn.misrate.test=(testtable[1,2]+testtable[2,1])/n
knn.misrate.train=(traintable[1,2]+traintable[2,1])/n
knn.misrate.test
knn.misrate.train

#k=5
library(class)
knn.pred=knn(traindata, testdata, usedata[(1:(n/2)),m],k = 5)
testtable=table(knn.pred ,usedata[15082:30162,m])
traintable=table(knn.pred ,usedata[1:15081,m])
knn.misrate.test=(testtable[1,2]+testtable[2,1])/n
knn.misrate.train=(traintable[1,2]+traintable[2,1])/n
knn.misrate.test
knn.misrate.train

#k=10
library(class)
knn.pred=knn(traindata, testdata, usedata[(1:(n/2)),m],k = 10)
testtable=table(knn.pred ,usedata[15082:30162,m])
traintable=table(knn.pred ,usedata[1:15081,m])
knn.misrate.test=(testtable[1,2]+testtable[2,1])/n
knn.misrate.train=(traintable[1,2]+traintable[2,1])/n
knn.misrate.test
knn.misrate.train

#k=15
library(class)
knn.pred=knn(traindata, testdata, usedata[(1:(n/2)),m],k = 15)
testtable=table(knn.pred ,usedata[15082:30162,m])
traintable=table(knn.pred ,usedata[1:15081,m])
knn.misrate.test=(testtable[1,2]+testtable[2,1])/n
knn.misrate.train=(traintable[1,2]+traintable[2,1])/n
knn.misrate.test
knn.misrate.train

#k=20
library(class)
knn.pred=knn(traindata, testdata, usedata[(1:(n/2)),m],k = 20)
testtable=table(knn.pred ,usedata[15082:30162,m])
traintable=table(knn.pred ,usedata[1:15081,m])
knn.misrate.test=(testtable[1,2]+testtable[2,1])/n
knn.misrate.train=(traintable[1,2]+traintable[2,1])/n
knn.misrate.test
knn.misrate.train

#k=25
library(class)
knn.pred=knn(traindata, testdata, usedata[(1:(n/2)),m],k = 25)
testtable=table(knn.pred ,usedata[15082:30162,m])
traintable=table(knn.pred ,usedata[1:15081,m])
knn.misrate.test=(testtable[1,2]+testtable[2,1])/n
knn.misrate.train=(traintable[1,2]+traintable[2,1])/n
knn.misrate.test
knn.misrate.train

#k=30
library(class)
knn.pred=knn(traindata, testdata, usedata[(1:(n/2)),m],k = 30)
testtable=table(knn.pred ,usedata[15082:30162,m])
traintable=table(knn.pred ,usedata[1:15081,m])
knn.misrate.test=(testtable[1,2]+testtable[2,1])/n
knn.misrate.train=(traintable[1,2]+traintable[2,1])/n
knn.misrate.test
knn.misrate.train

misrate.test=rep(0,4)
misrate.train=rep(0,4)
for(i in 1:4)
{
knn.pred=knn(traindata, testdata, usedata[(1:(n/2)),m],k = i+25)
testtable=table(knn.pred ,usedata[15082:30162,m])
traintable=table(knn.pred ,usedata[1:15081,m])
knn.misrate.test=(testtable[1,2]+testtable[2,1])/n
knn.misrate.train=(traintable[1,2]+traintable[2,1])/n
misrate.test[i]=knn.misrate.test
misrate.train[i]=knn.misrate.train
}
