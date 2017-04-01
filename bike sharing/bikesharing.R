
df<-read.csv('bikeshare.csv')

library(ggplot2)
library(ggthemes)
library(dplyr)
#Create a scatter plot of count vs temp
print(ggplot(df,aes(x=temp,y=count))+geom_point(alpha=0.1,aes(color=temp)))

# scatter plot of date time vs count
df$datetime<-as.POSIXct(df$datetime)
print(ggplot(df,aes(x=datetime,y=count))+geom_point(alpha=0.1,aes(color=temp))+scale_color_continuous(high='red',low='blue')+theme_dark())

#correlation between temp and count
num.cols<-sapply(df,is.numeric)
dfnew<-df[,num.cols]
#print(head(dfnew))
dfnew<-(cor(dfnew[,c('temp','count')]))
print(head(dfnew))

# box plot y d indicating count and x axis a box for each season

print(ggplot(df,aes(x=season,y=count))+geom_boxplot(aes(color=factor(season))))


# Create hour column that takes hour from entire dataframe
#to_hour<-function(datetime){
#time.stamp<- df$datetime[4]
##format(time.stamp,"%H")
#}

df$hour<-sapply(df$datetime, function(x){format(x,"%H")})

#scatter plot of count vs hour using color scale based on temp where working day==1

dfnew<-filter(df,workingday==1)
print(ggplot(dfnew,aes(x=hour,y=count))+geom_point(alpha=0.1,aes(color=temp))+scale_color_continuous(high='red',low='blue')+theme_dark())


dfnew2<-filter(df,workingday==0)
print(ggplot(dfnew2,aes(x=hour,y=count))+geom_point(alpha=0.1,aes(color=temp))+scale_color_continuous(high='red',low='blue')+theme_dark())
  
# Building the Model
library(caTools)
set.seed(101)
sample<- sample.split(df$count,SplitRatio = 0.7)
  #Train data
train=subset(df,sample==TRUE)
  #Test data
test=subset(df,sample==FALSE)
  
  # Training the model
  
model<- lm(count~temp,df)
  
res<-residuals(model)
res<-as.data.frame(res)
#Plot histrogram for residual to check if it's normally distributed
print(head(res))
print(summary(model))




# How many bike rental would we predict if the temperature was 25 degree celcius. Calculate using above values and predict function

temp.test<-data.frame(temp=c(25))
print(temp.test)

bike.predictions<-predict(model,temp.test)
print(bike.predictions)


# use sapply as as.numeric to change hour column to numeric values

df$hour<- sapply(df$hour,as.numeric)

# Finally build a model that predicts count based off the following features. 
#season, holiday, workingday, weather, temp, humidity, windspeed, hour(factor)

model2<- lm(count~.,df)
print(summary(model2))







