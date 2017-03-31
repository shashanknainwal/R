# Capstone Project MoneyBall Project
batting<- read.csv('Batting.csv')
print(head(batting))
#Code
#batting$BA<- batting$H/batting$AB
# Create more new columns.On Base Percentage (OBP) and Slugging Percentage (SLG). Hint: For 
#SLG, you need 1B (Singles), this isn't in your data frame. However you can calculate it by
#subtracting doubles,triples, and home runs from total hits (H): 1B = H-2B-3B-HR
#batting$OBP<-(batting$H+batting$BB+batting$HBP)/(batting$AB+batting$BB+batting$HBP+batting$SF)

#Code
#batting$X1B<- batting$H-batting$X2B-batting$X3B-batting$HR
#Slugging Average SLG
#Code
#batting$SLG<-(batting$X1B+2*batting$X2B+3*batting$X3B+4*batting$HR)/batting$AB
# Code to check structure
#str(batting)

# Code to merge Merging Salary Data with Batting Data

sal<- read.csv('Salaries.csv')
print(head(sal))
#Our batting data goes back to 1871! Our salary data starts at 1985, meaning we need to remove the batting 
#data that occured before 1985.Use subset() to reassign batting to only contain data from 1985 and onwards
 #Code
#batting<-subset(batting,yearID>1984)

#Use the merge() function to merge the batting and sal data frames by c('playerID','yearID'). 
#Call the new data frame combo
#Code
#combo<- merge(batting,sal,by=c('playerID','yearID'))



#Analyzing the Lost Players

#Use the subset() function to get a data frame called lost_players from the combo data frame consisting 
#of those 3 players.
#code
#lost_player<-subset(combo,playerID %in% c('giambja01','damonjo01','saenzol01'))

#Since all these players were lost in after 2001 in the offseason, let's only concern ourselves with 
#the data from 2001.
#code

#lost_player<-subset(lost_player,yearID==2001)
#Reduce the lost_players data frame to the following columns: playerID,H,X2B,X3B,HR,OBP,SLG,BA,AB

#Code
#lost_players <- lost_players[,c('playerID','H','X2B','X3B','HR','OBP','SLG','BA','AB')]


# Replacement Player
#Constrainst
#The total combined salary of the three players can not exceed 15 million dollars.
#Their combined number of At Bats (AB) needs to be equal to or greater than the lost players.
#Their mean OBP had to equal to or greater than the mean OBP of the lost players

#Code
#library(dplyr)
#replacement.player<-filter(combo,year==2001)

# library(ggplot2)
#ggplot(replacement.player,aes(x=OBP,y=salary))+geom_point()

#replacement.player <- filter(replacement.player,salary<8000000,OBP>0)
#head(replacement.player,desc(OBP))

#replacement.player<-replacement.player[,c('playerID','OBP','AB','Sal')]
