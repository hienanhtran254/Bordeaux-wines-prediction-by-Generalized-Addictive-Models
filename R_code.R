# Install package
library(mgcv)
library(mice)
library(visdat)

# Load data
data <- read.table('wine.txt',header=TRUE) 
head(data, 6)

#Cleansing  
## Find missing data
vis_miss(data)

##imputation 
imputed_Data <- mice(data, m=5, maxit = 50, method = 'pmm', seed = 500)
data <- complete(imputed_Data,2)
attach(data)

#Víualize 
## hist plot
par(mfrow = c(2,3)) 
hist(price, breaks=25, col="red")
hist(h.rain, breaks=30, col="red")
hist(s.temp, breaks=30, col="red")
hist(w.rain, breaks=30, col="red")
hist(h.temp, breaks=30, col="red")
hist(parker, breaks=30, col="red")

## scatter plot
par(mfrow = c(2,3)) 
plot(year, price)
plot(h.rain,price)
plot(s.temp,price)
plot(w.rain, price)
plot(h.temp, price)
plot(parker, price)

# Correlation
cor(data)
pairs(data, panel = function(x,y) {points(x,y) ; lines(lowess(x,y))})

#Fitted model GAM
## all explanatory variables
model <- gam(price ~ h.rain + s(s.temp) 
             + s(h.temp) + w.rain 
             + parker + year )
summary(model) 

## exclude h.rain
model1 <- gam(price ~ s(s.temp) 
              + s(h.temp) + w.rain
              + parker + year)
summary(model1) 

# Model checking 
par(mfrow = c(2,2)) 
gam.check(model1)

#Visualize
par(mfrow = c(2,2)) 
plot(model1, rug = TRUE, shade = TRUE)

#Question 2
## generate data
Speed <- c(1,2,3,4,5)
Mistakes <- c(2,7,25,47,121)

## plot
par(mfrow = c(1,2)) 
plot(x = Speed, y = Mistakes, main="Scatterplot of Mistakes vs Speed",
     xlab = "Speed", ylab = "Mistakes")
plot(x = Speed, y = log(Mistakes),main="Plot of log(Mistakes) vs Speed",
     xlab = "Price", ylab = "log(Mistakes)")

## fit GLM
speed.glm <- glm(Mistakes ~ Speed, family=poisson)
summary(speed.glm)

## fit LM
logMistakes <- log(Mistakes)
llm <- lm(logMistakes ~ Speed)
summary(llm)

## plot 
plot(Speed, logMistakes)
abline(coef(llm))
abline(coef(speed.glm), lty=2)
plot(Speed,logMistakes)
legend(1,4.5,c("Normal linear model with logMistakes",
               "Poisson GLM with log link"), lty=1:2)




