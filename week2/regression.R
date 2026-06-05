##################################################################################
# ISRS Exercise 5.20
# Part III. Exercise 5.13 introduces data on shoulder girth and
# height of a group of individuals. The mean shoulder girth is 
# 108.20 cm with a standard deviation of 10.37 cm. The mean height 
# is 171.14 cm with a standard deviation of 9.41 cm. The correlation
# between height and shoulder girth is 0.67
# See textbook for image

# a. Write the equation of the regression line for predicting height.
# b = r * (Sy / Sx)
# b = 0.67 * (9.41 / 10.37) = 0.607
# intercept = 171.14 - b * 108.2 = 105.46
# y_hat = 105.46 + 0.607x
# b. Intepret the slope and the intercept in this context.
# For the slope interpretation, for every 1 cm increase in shoulder girth,
# the model predicts that height increases by a certain number of cm. (0.60 in our case)
# The intercept represents the predicted height when shoulder girth is 0 cm, which
# is not meaningful in this context since such a value is not realistic.
# c. Calculate R^2 of the regression line for predicting height from 
#    shoulder girth, and interpret in the context of the application.
# R^2 = (0.67)^2 = 0.448
# About 45% of the variation in height is explained by the linear relationship with shoulder girth. 
# d. A randomly selected student from your class has a shoulder girth 
#    of 100 cm. Predict the height of this student using the model.
# it would be 105.46 + 0.607(100) = 166.16
# e. The student from part (d) is 160 cm tall. Calculate the residual, 
#    and explain what this residual means.
# Residual = observed - predicted = 160 - 166.16 = - 6.16 (negative residual). The model overestimated
# the student's height by about 6.16 cms.
# f. A one year old has a shoulder girth of 56 cm. Would it be 
#    appropriate to use this linear model to predict the height of this child?
# No. A shoulder girth of 56 cm is far outside the range of the data used to create
# the model, so using the model would be an extrapolation and may not be reliable.

##################################################################################
# ISRS Exercise 5.29
# The scatterplot and least squares summary below show the relationship
# between weight measured in kilograms and height measured in centimeters
# of 507 physically active individuals
# See textbook for scatterplot.

# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)  -105.0113      7.5394   -13.93    0.0000
# height          1.0176      0.0440    23.13    0.0000

# a. Describe the relationship between height and weight.
# There is a positive, moderately strong linear relationship between height
# and weight. As height increases, weight tends to increase.
# b. Write the equation of the regression line. Interpret the slope
#    and intercept in context.
# Equation = -105.0113 + 1.0176(height)
# Slope: For each additional 1 cm in height, predicted weight increases
# by about 1.0176 kg, on average.
# Intercept: Whein weight is 0 cm, the predicted weight is -105.0113 kg. This is not
# meaningful because a height of 0 cm is not realistic.
# c. Do the data provide strong evidence that an increase in height 
#    is associated with an increase in weight? State the null and 
#    alternative hypotheses, report the p-value, and state your conclusion.
# H0: Beta1 = 0
# HA: Beta1 > 0
# The p-value is < 0.0001 (reported as 0.0000)
# Conclusion: Reject H0. The data provide strong evidence that greater height
# is associated with greater weight.
# d. The correlation coefficient for height and weight is 0.72. 
#    Calculate R^2 and interpret it in context.
# R^2 = r^2 = (0.72)^2 = 0.5184, approx. 0.52
# About 52% of the variability in weight can be explained by its linear
# relationship with height.