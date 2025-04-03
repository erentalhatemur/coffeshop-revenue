#İLERİ REGRESYON PERŞEMBE KENDİ UYG. 6.HAFTA
library(faraway)
library(olsrr)
library(MASS)
library(ggplot2)
library(lmtest)
library(corrplot)
library(carData) 
library(fpp2)
options(scipen = 999)

#VERİNİN EĞİTİM TEST OLARAK AYRILMASI
datam<-coffee_shop_revenue
summary(datam)
sum(is.na(datam)) #NA VERİ YOK

set.seed(123)
n<-nrow(datam)
indexx<-sample(1:n,size = 0.80*n)
trainset<-datam[indexx,]
testset<-datam[-indexx,]

#Train üzerinden model kurulması
model_1<-lm(Daily_Revenue~.,data = trainset)
summary(model_1)

#accuracy üzerinden setlerin değerlendirilmesi
accuracy(model_1) #training verinin hata metriği
accuracy(predict(model_1,newdata = testset),testset$Daily_Revenue)

###VARSAYIM KONTROLÜ###
model_2<-lm(Daily_Revenue~.,data=datam)
summary(model_2)

#1.NORMALLİK VARSAYIMI
r<-residuals(model_2)
qqnorm(r)
qqline(r)
#NORMAL DAĞILIMA ÇOK İYİ UYUYOR
ols_test_normality(model_2)
#N>50 OLDUGUNDAN KOLMOGOROV<-H0 KABUL EDİLİR YANİ NORMAL DAĞILIM VAR

#2.SABİT VARYANS VARSAYIMI
fitted<-fitted(model_2)
dat<-data.frame(fitted,r)
ggplot(dat,aes(x=fitted,y=r))+geom_point()+
  geom_hline(yintercept=0,linetype="dashed",color="red")
#megafon şekli yok bptest yapacağız
bptest(model_2)
#H0 REDDEDİLEMEZ YANİ DEĞİŞEN VARYANS DURUMU YOKTUR.

#3.SIRADIŞI GÖZLEM KONTROLÜ
#LEVERAGE:
hatvalue<-hatvalues(model_2)
p<-sum(hatvalue)
n<-nrow(datam)
cutoff<-(2*p)/n
halfnorm(hatvalue)
abline(h=cutoff)
#282 ve 1502 leverage potansiyellidir.
which(hatvalue>cutoff)

#OUTLIER TEST:
ols_test_outlier(model_2)
#bonferroni değeri 1.10>0.05 oldugundan h0 reddedilemez! 1029. gözlem 
#bonferroni'ye göre outlier değildir
#grafik test
rst<-rstudent(model_2)
cutBENF<-qt(1-0.05/(2*n),n-p-1)
cutADJ<-qt(1-0.05/(2),n-p-1)
halfnorm(rst)
abline(h=cutBENF)
abline(h=cutADJ) #unadj göre çok fazla outlier görünüyor!

#4.ETKİLİ GÖZLEM KONTROLÜ:
#cookd.
cooks<-cooks.distance(model_2)
cutoffs<-qf(0.5,p,n-p)
which(cooks>cutoffs)
#COOKD'YE GÖRE HİÇ ETKİLİ YOK 
halfnorm(cooks)
abline(h=cutoffs)

#DFFIT
dffitm<-dffits(model_2)
p<-sum(hatvalue)
cutm<-2*sqrt(p/n)
which(abs(dffitm)>cutm)

halfnorm(dffitm)
abline(h=cutm)


#4.MULTICOL PROBLEMİ
mat<-model.matrix(model_2)[,-1]
corrdat<-cor(mat)
corrplot(corrdat)
#multicol problemi yok gibi duruyor.

vif(model_2)
#kosul indexi
ozdeg<-eigen(t(mat)%*%mat)$values 
k<-sqrt(max(ozdeg)/min(ozdeg))
k
#100'den yüksek,GÜÇLÜ COLL GÖSTERGESİ!
