# Bordeaux wines
For the given dataset of 25 Bordeaux wines from 1952 to 1998, this research aims to find out the impact of each wine characteristics like production year and rating quality, as well as others influence like weather variables, on the price of Bordeaux wines.
## Justification of the chosen regression model
### 1.	Dataset
The raw dataset includes 47 observations for 7 variables. In this context, we aim to build a model with the response variable price as a function of the other variables.

<img width="453" alt="image" src="https://user-images.githubusercontent.com/92025453/159124500-8b097062-681e-4ecf-9bb4-20cbb795bba7.png">

_Figure 1. Patterns of missing values_

In this dataset, there are some mising values for variable “parker” and “price”. In this case, the missing data for these two variables are not missing at random (Figure 1), we cannot do listwise deletion as it will introduce biased. Therefore, we will do the imputation, which will prevent the case of default discarding by replacing missing data with an estimated value based on other available information. By running the R code, we set m = 5, which is a default number of desired imputated datasets, then get complete data which is the second out of 5 imputed data sets. 

### 2.	Methodology:

<img width="453" alt="image" src="https://user-images.githubusercontent.com/92025453/159124699-340cea20-bd5d-4900-9c06-6f6006b62082.png">

_Figure 2. Histogram pattern_
  
<img width="453" alt="image" src="https://user-images.githubusercontent.com/92025453/159124754-6dabf898-bfd8-4d32-9a30-d089e6e8af5d.png">

_Figure 3. Trends between response and explanatory variables_

Plotting in R Studio, we found out that most of explanatory variables are uncontinuous, as shown in Figure 2. Additionally, Figure 3 shows that some of our explanatory variables seems to have non-linear relationships with response variable, as a consequence, we have no a prior reason to choose a one particular parametric form over another for describing the shape of the relationship between the response variable and the explanatory variables. Hence, to capture the shape of a relationship between response variable and the explanatory variables without prejudging the issue by choosing a particular parametric form, we will use GAMs (Generalized Addictive Models) to analyse the dataset.

### 3.	Correlation:
For data inspection, it is always a good idea to look at all the correlation by using pairs() (Firgure 4). The response variable, “price”, is shown on the y axis of the second row of panels: there is a negative correlation with “year” and “h.rain”, there might be positive the corelation with “parker” and “s.temp”, the others two variables seem to have unclear correlation. 

<img width="454" alt="image" src="https://user-images.githubusercontent.com/92025453/159124762-8479c266-73a4-4004-a0b4-dc36f05ddc81.png">

_Figure 4. Correlation_

## Summary of the empirical findings and interpretation of the result
### 1.	Fitting model:
At is shown in Figure 3, “s.temp”and “h.temp” having wiggle relationship with our response variable, therefore, we will fit these explanatory variables using the non-parametric smoother s(). 
First and foremost, we can see that “h.rain” is insignificant (p-value = 0.8648 > 0.05) , hence, we exclude it from our model. After fitting model again, our model has improved. All explanatory variables have been significant now. 
Noted that intercept, along with “w.rain”, “parker” and “year” are fitted with parametric terms, and others variables are fitted with smooth terms.For smooth term, coefficients are not printed. This is because each smooth has several coefficients - one for each basis function. Instead, edf (effective degrees of freedom) represents the complexity of the smooth. As it has been shown in the table, our edf are 2.4 and 2.9, which indicate the complexity of the curve. This also prove that there is non-lnear relationship between “s.temp’, “h.temp” and “price”.
On the one hand, when we compare result to the previous model, we notice that deviance explained has been improved. Deviance explained of 71.4% indicates that the resulting fit is quite good and the model explains more than 71% of the deviance in y.
Moreover, GCV score in the new model is lower than the previous one. Since our aim is to minimize the GCV to better fit to noisy dataset, our new model is obviously better than the previous one.  

### 2.	Checking model:
Table 2 is the statistical result for patterns in model residuals. Large p-value for both variables indicate that residuals are randomly distributed. Neither has significant patterns in their residuals and both have enough basis functions.
Figure 5 illustrates four plots, each of these gives a different way of looking at your model residuals. On the top left is a Q-Q plot, which shows that our model has been fairly fitted. On bottom left is a histogram of residuals, a nearly symmetrical bell shaped also indicates fairly fitted model. The plot of response against fitted values closely formed a straight line, which is a good sign for us. However, in the plot of residual values, evenly distributed around zero does not appear. 

### 3.	Interprete GAM result:
A combinations of linear and smooth terms in our model can be rewrite as follow:

> price = 1891.36132 +0.02588*w.rain + 0.8223*parker – 0.98604*year + f(s.temp) + f(h.temp)

The visualized results in figure 5 show that there is positive correlation between temperature and “price”. However, this relationship is not a straight line, so there is still at some point to be noticed. In terms of “s.temp”, it looks like after temperature of nearly 18, “price” seems to go down. Similarly, relationship between harvest temperature and price is also a quadratic curve, which also illustrates that after temperature of 18, wine price tends to increase faster. 

<img width="453" alt="image" src="https://user-images.githubusercontent.com/92025453/159124854-cf2c429b-a48e-46d4-ba4a-9a79b187804d.png">

_Figure 5. Check GAM model_

For “w.rain”, the higher the rain, the higher price the wine is.  Additionally, it seems like high rated wine quality bottle would also more expensive than the others. Finally, the most recently productions are worth less than the older one.

<img width="453" alt="image" src="https://user-images.githubusercontent.com/92025453/159124910-3ed7c4eb-a62b-4df2-aa6f-8639f58906f0.png">

_Figure 6. GAM visualization_

## Recommendation and limitation 
Firstly, our residual vs linear prediction plot seems to not good, however, all others plots have proved that our assumptions about non-linear relationship is correct. 
Secondly, the primary limitation of GAM models is a propensity to overfit data when it comes to choose basis functions and smoothing parameter. Hence, GAM with reasonable spline and valid degrees of freedom can improve model.
Thirdly, this research has not investigate the possibility that there might be an interaction between amount of rain and temperature in the same seasons. Future research can be improved by adding these feature into the model.

## Lesson from analysis and improvement
After investigation model, it is noticeable that harvest rain and are not influence to the price of wine. Instead, all others variables are more likely to affect the wine price. 
For answering out initial questions, it can be quoted that more older bottle are worth more than the recent one. High rating and amount of winter rain can contribute to the higher price of wine. Also, it is worth to notice that, temperature also affect the wine price, and it also depends on which season to determine exactly volatility of wine price.
As for the improvement of analysis, as for the predictability of GAM model depends greatly on it arguments, chosen of more strict arguments may be set out. Different spline term selection, degrees of freedom, smoothing parameter, knots may be used as complex combination to improve the results of model. In this research, we want to keep the simplicity of the model, therefore, setting a default family may easier for interpretation. However, the research may be improved by another family like Gamma since the value for price should always be positive.










