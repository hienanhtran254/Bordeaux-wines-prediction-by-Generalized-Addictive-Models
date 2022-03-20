# Bordeaux wines
For the given dataset of 25 Bordeaux wines from 1952 to 1998, this research aims to find out the impact of each wine characteristics like production year and rating quality, as well as others influence like weather variables, on the price of Bordeaux wines.
## Justification of the chosen regression model
### 1.	Dataset
The raw dataset includes 47 observations for 7 variables. In this context, we aim to build a model with the response variable price as a function of the other variables.

### 2.	Methodology:

Some of our explanatory variables seems to have non-linear relationships with response variable, as a consequence, we have no a prior reason to choose a one particular parametric form over another for describing the shape of the relationship between the response variable and the explanatory variables. Hence, to capture the shape of a relationship between response variable and the explanatory variables without prejudging the issue by choosing a particular parametric form, we will use GAMs (Generalized Addictive Models) to analyse the dataset.
<img width="453" alt="image" src="https://user-images.githubusercontent.com/92025453/159124754-6dabf898-bfd8-4d32-9a30-d089e6e8af5d.png">

## Summary of the empirical findings and interpretation of the result

A combinations of linear and smooth terms in our model can be rewrite as follow:

> price = 1891.36132 +0.02588*w.rain + 0.8223*parker – 0.98604*year + f(s.temp) + f(h.temp)

The visualized results in figure 5 show that there is positive correlation between temperature and “price”. However, this relationship is not a straight line, so there is still at some point to be noticed. In terms of “s.temp”, it looks like after temperature of nearly 18, “price” seems to go down. Similarly, relationship between harvest temperature and price is also a quadratic curve, which also illustrates that after temperature of 18, wine price tends to increase faster. 

For “w.rain”, the higher the rain, the higher price the wine is.  Additionally, it seems like high rated wine quality bottle would also more expensive than the others. Finally, the most recently productions are worth less than the older one.

## Recommendation and limitation 
Firstly, our residual vs linear prediction plot seems to not good, however, all others plots have proved that our assumptions about non-linear relationship is correct. 

Secondly, the primary limitation of GAM models is a propensity to overfit data when it comes to choose basis functions and smoothing parameter. Hence, GAM with reasonable spline and valid degrees of freedom can improve model.

Thirdly, this research has not investigate the possibility that there might be an interaction between amount of rain and temperature in the same seasons. Future research can be improved by adding these feature into the model.

## Lesson from analysis and improvement
After investigation model, it is noticeable that harvest rain and are not influence to the price of wine. Instead, all others variables are more likely to affect the wine price. 

For answering out initial questions, it can be quoted that more older bottle are worth more than the recent one. High rating and amount of winter rain can contribute to the higher price of wine. Also, it is worth to notice that, temperature also affect the wine price, and it also depends on which season to determine exactly volatility of wine price.

As for the improvement of analysis, as for the predictability of GAM model depends greatly on it arguments, chosen of more strict arguments may be set out. Different spline term selection, degrees of freedom, smoothing parameter, knots may be used as complex combination to improve the results of model. In this research, we want to keep the simplicity of the model, therefore, setting a default family may easier for interpretation. However, the research may be improved by another family like Gamma since the value for price should always be positive.










