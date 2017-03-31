library(ggplot2)
library(data.table)
df <- fread('Economist_Assignment_Data.csv',drop=1)
head(df)
#Use ggplot() + geom_point() to create a scatter plot object called pl. You will need to specify 
#x=CPI and y=HDI and color=Region as aesthetics
pl<- ggplot(df,aes(x=CPI,y=HDI))+geom_point(aes(color=Region))
print(pl)
#Change the points to be larger empty circles. (You'll have to go back and add arguments to geom_point()
#and reassign it to pl.)
#You'll need to figure out what shape= and size=
pl11<- ggplot(df,aes(x=CPI,y=HDI))+geom_point(aes(color=Region),shape=21,size=3)
print(pl11)
#Add geom_smooth(aes(group=1)) to add a trend line
pl12<- ggplot(df,aes(x=CPI,y=HDI))+geom_point(aes(color=Region),shape=21,size=3)+geom_smooth(aes(group=1))
print(pl12)
#We want to further edit this trend line. Add the following arguments to geom_smooth (outside of aes):
 # method = 'lm'
#formula = y ~ log(x)
#se = FALSE
#color = 'red'
pl13<- ggplot(df,aes(x=CPI,y=HDI))+geom_point(aes(color=Region),shape=21,size=3)+geom_smooth(method='lm',formula=y~ log(x),se=FALSE,color='red',aes(group=1))
print(pl13)

#It's really starting to look similar! But we still need to add labels, we can use geom_text! Add geom_text(aes(label=Country)) to pl2 and see what happens.
#(Hint: It should be way too many labels)

pl14<-pl13+geom_text(aes(label=Country))
print(pl14)
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")
pl14<-pl13+geom_text(aes(label = Country), color = "gray20", data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)
print(pl14)
#Now let's just add some labels and a theme, set the x and y scales and we're done!
#Add theme_bw() to your plot and save this to pl4
pl15<-pl14+theme_bw()
print(pl15)
pl16<-pl15+scale_x_continuous("Corruption Perception Index",limits=c(1,10),breaks=1:10)
print(pl16)
pl17<-(pl16+scale_y_continuous("HDI",limits=c(0.2,1),breaks=0:0.1)+ggtitle("Corruption and Human development"))
library(ggthemes)
pl17 + theme_economist_white()
