df<-read.csv('student-mat.csv',sep=';')
#install catools to be able to randomly select test and train data
#install.packages('caTools')
library(caTools)

# To find na values in a df.
any(is.na(df))

# To check that categorical data has "factor" set
#str(df)
library(ggplot2)
library(ggthemes)
library(dplyr)

#EDA - To find correlation, lets first get all the variables that have numeric values
num.cols<-sapply(df,is.numeric)
#print(num.cols)
dfnew<-df[,num.cols]

print(dfnew)
dfnew<-(cor(dfnew))
print(dfnew)
 # to plot corelation, there is a very nice package
library(corrplot)
library(corrgram)
library(plotly)
corrplot(dfnew,method='color')

corrgram(dfnew,order=TRUE, lower.panel = panel.shade, upper.panel = panel.pie)
    
# Histogram of G3Score
print(ggplot(df,aes(x=G3))+geom_histogram(bins=20),alpha=0.5,fill='blue')+theme_economist_white()

pls<-ggplot(df,aes(x=age,y=G3))+geom_point(color='red')
gpl<-ggplotly(pls)
print(gpl)

# Building a Model

# Using train and test  data to split our data. Us caTools library to do it easily
library(caTools)
set.seed(101)
#Sample the data
sample<- sample.split(df$G3,SplitRatio = 0.7)

#Train data
train=subset(df,sample==TRUE)
#Test data
test=subset(df,sample==FALSE)

# Training the model

model<- lm(G3~.,train)
#print(summary(model))

#Visualize our Model.We can visualize our linear regression model by plotting out the residuals, 
#the residuals are basically a measure of how off we are for each point 
#in the plot versus our model (the error).

res<-residuals(model)
res<-as.data.frame(res)
#Plot histrogram for residual to check if it's normally distributed
print(head(res))

print(ggplot(res,aes(res)) +  geom_histogram(fill='blue',alpha=0.5))

#Looks like there are some suspicious residual values that have a value less than -5.
#We can further explore this by just calling plot on our model.
#plot(model)

# Let's make these all zeros when running our results against our predictions.
#Let's test our model by predicting on our testing set:
G3.predictions<-predict(model,test)
results<-cbind(G3.predictions,test$G3)
colnames(results)<- c('prediction','actual')
results<-as.data.frame(results)
print(results)

# Calculate MSE
mse <- mean((results$actual-results$prediction)^2)
print(mse)

# Calculate RMS
print(rms<-mse^0.5)

# Calculate R-Squared Value for our model (just for the predictions)


SSE<- sum((results$prediction-results$actual)^2)
SST<-sum((mean(df$G3)-results$actual)^2)
R2<- 1-SSE/SST
print(R2)









