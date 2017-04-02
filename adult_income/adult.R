adult<-read.csv('adult_sal.csv')
#print(head(adult))

library(dplyr)
# removing duplicate column
adult<-select(adult,-X)
library(Amelia)
#print(head(adult))
#print(str(adult))
#print(summary(adult))

#print(table(adult$type_employer))
#? gives the number of null values. In this case 1836 are null values in this column

# Combine "Never worked and Without pay"into 1 group- Unemployed
unemployed<- function(a){
  a<- as.character(a)
  if (a=="Never-worked" | a =='Without-pay'){
    return ("Unemployed")}
  else{
    return (a)
  }
}
adult$type_employer<-sapply(adult$type_employer,unemployed)
#print(table(adult$type_employer))


#Combine State and Local gov jobs into a category called SL-gov and combine self-employed jobs 
#into a category called self-emp.
SL_gov<- function(b){
  b<- as.character(b)
  if (b=="Federal-gov" | b =='Local-gov'){
    return ("SL_gov")}
  else{
    return (b)
  }
}
adult$type_employer<-sapply(adult$type_employer,SL_gov)

self_emp<- function(c){
  c<- as.character(c)
  if (c=="Self-emp-inc" | c =='Self-emp-not-inc'){
    return ("self-emp")}
  else{
    return (c)
  }
}
adult$type_employer<-sapply(adult$type_employer,self_emp)

#print(table(adult$type_employer))

#print(table(adult$marital))
# married, not married and never married


marr<- function(c){
  c<- as.character(c)
  if (c=="Divorced" | c =='Separated'|c=='Widowed'){
    return ("not-married")}
 
    else if (c=="Never-married"){
      return ("never-married")
    }
    else{
      return ('Married')
    }
  }

adult$marital<-sapply(adult$marital,marr)

#print(table(adult$marital))


#print(table(adult$country))

Asia <- c('China','Hong','India','Iran','Cambodia','Japan', 'Laos' ,
          'Philippines' ,'Vietnam' ,'Taiwan', 'Thailand')

North.America <- c('Canada','United-States','Puerto-Rico' )

Europe <- c('England' ,'France', 'Germany' ,'Greece','Holand-Netherlands','Hungary',
            'Ireland','Italy','Poland','Portugal','Scotland','Yugoslavia')

Latin.and.South.America <- c('Columbia','Cuba','Dominican-Republic','Ecuador',
                             'El-Salvador','Guatemala','Haiti','Honduras',
                             'Mexico','Nicaragua','Outlying-US(Guam-USVI-etc)','Peru',
                             'Jamaica','Trinadad&Tobago')
Other <- c('South')
group_country <- function(ctry){
  if (ctry %in% Asia){
    return('Asia')
  }else if (ctry %in% North.America){
    return('North.America')
  }else if (ctry %in% Europe){
    return('Europe')
  }else if (ctry %in% Latin.and.South.America){
    return('Latin.and.South.America')
  }else{
    return('Other')      
  }
}  
adult$country <- sapply(adult$country,group_country)
#print(table(adult$country))

#print(str(adult))

adult$type_employer<- sapply(adult$type_employer,factor)
adult$marital<- sapply(adult$marital,factor)
adult$country<- sapply(adult$country,factor)
#print(str(adult))






########################
# Working with Missing Data

#missmap(adult,main='missing map',col=c('yellow','black'))
# convert ? to na
#adult[adult=='?']<- NA
#missmap(adult,main='missing map',col=c('yellow','black'))
# Omit all na values from the df

#adult<- na.omit(adult)
#missmap(adult,main='missing map',col=c('yellow','black'))






########################
# Working with EDA
library(ggplot2)
library(dplyr)
#print(ggplot(adult,aes(x=age))+geom_histogram(aes(color=income)))

#Plot a histogram of hours worked per week
#print(ggplot(adult,aes(x=hr_per_week))+geom_histogram())


#Rename the country column to region column to better reflect the factor levels.

adult<-rename(adult,region=country)

#print(str(adult))
#Create a barplot of region with the fill color defined by income class
#print(ggplot(adult,aes(x=region))+geom_bar(aes(color=income)))




##################################
# TRAIN TEST

  library(caTools)
set.seed(101)
sample<- sample.split(adult$income,SplitRatio = 0.7)
train<- subset(adult,sample=TRUE)
test<- subset(adult,sample=FALSE)

#Training the model

log.model<- glm(income~.,family=binomial(logit),data=adult)
#print(summary(log.model))

#Choose a model by AIC in a Stepwise Algorithm
#Reading about the variable inflation factor (VIF) and vif() function to explore other options for comparison criteria. In the meantime
#let's continue on and see how well our model performed against the test set.
newstepmodel<- step(log.model)
print(summary(newstepmodel))



# PREDICT AND CONFUSION MATRIX
 
test$predicted.income<-predict(log.model,newdata=test,type='respose')
table(test$income,test$predicted.income>0.5)
 





