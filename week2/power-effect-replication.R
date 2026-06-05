library(tidyverse)

####################################################################################
# IST Chapter 12, Exercise 12.1
magnets <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/magnets.csv")

#  Consider a medical condition that does not have a standard
# treatment. The recommended design of a clinical trial for a new treatment
# to such condition involves using a placebo treatment as a control. A placebo
# treatment is a treatment that externally looks identical to the actual treatment
# but, in reality, it does not have the active ingredients. The reason for using
# placebo for control is the “placebo effect”. Patients tent to react to the fact that
# they are being treated regardless of the actual beneficial effect of the treatment

# As an example, consider the trial for testing magnets as a treatment for pain
# that was described in Question 9.1. The patients that where randomly assigned
# to the control (the last 21 observations in the file “magnets.csv”) were treated
# with devises that looked like magnets but actually were not. The goal in this
# exercise is to test for the presence of a placebo effect in the case study “Magnets
# and Pain Relief” of Question 9.1 using the data in the file “magnets.csv”.


# 1. Let X be the measurement of change, the difference between the score of
#   pain before the treatment and the score after the treatment, for patients
#   that were treated with the inactive placebo. Express, in terms of the
#   expected value of X, the null hypothesis and the alternative hypothesis
#   for a statistical test to determine the presence of a placebo effect. The null
#   hypothesis should reflect the situation that the placebo effect is absent
x = magnets$score1 - magnets$score2
#   X = pain before - pain after
#   So, X > 0: pain decreased (improvement)
#   X = 0: no change on average
#   Null hypothesis (no placebo effect)
#   No improvement on average, so E[X] = 0
#   Alternative hypothesis (placebo effect exists)
#   Patients improve even though treatment is inactive:
#   E[X] > 0.
#   This is a one-sided test.
# 2. Identify the observations that can be used in order to test the hypotheses.
#   last 21 observations = placebo group (inactive magnets)
placebo <- magnets %>% tail(21)
x_placebo <- placebo$score1 - placebo$score2
# 3. Carry out the test and report your conclusion. (Use a significance level of
#    5%.)
#    E[X] = 0 (null) & E[X] > 0 (alternative)
t.test(x_placebo, mu = 0, alternative = "greater")
#   Conclusion: At the 5% significance level, we reject the null hypothesis. There is sufficient statistical evidence to conclude
#   that the mean change in pain score for the placebo group is greater than 0. This suggest the presence of a placebo effect in the study.

####################################################################################
# IST Chapter 13, Exercise 13.1

magnets <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/magnets.csv")
#  In this exercise we would like to analyze the results of the
# trial that involves magnets as a treatment for pain. The trial is described in
# Question 9.1. The results of the trial are provided in the file “magnets.csv”

# Patients in this trail where randomly assigned to a treatment or to a control.
# The responses relevant for this analysis are either the variable “change”, which
# measures the difference in the score of pain reported by the patients before and
# after the treatment, or the variable “score1”, which measures the score of pain
# before a device is applied. The explanatory variable is the factor “active”.
# This factor has two levels, level “1” to indicate the application of an active
# magnet and level “2” to indicate the application of an inactive placebo.

# In the following questions you are required to carry out tests of hypotheses.
# All tests should conducted at the 5% significance level:
# 1. Is there a significance difference between the treatment and the control
#    groups in the expectation of the reported score of pain before the application of the device?
t.test(score1 ~ active, data = magnets)
# p-value is 0.68
# mean(active = 1) = 9.62
# mean(active = 2) = 9.52
# difference is small
# u1 = u2
# u1 is different than u2
# Since 0.68 > 0.05, we fail to reject H0
# There is no statistically significant difference in the mean baseline pain score (score1) between the treatment
# and control groups (p = 0.68). This suggest that random assignment was successful and the groups were comparable before
# treatment.
# 2. Is there a significance difference between the treatment and the control
#    groups in the variance of the reported score of pain before the application
#    of the device?
var.test(score1 ~ active, data = magnets)
# p-value = 0.36. Fail to reject H0
# There is no statistically significant difference in the variance of baseline pain scores
# between the two groups. This suggests similar variability before treatment.
# 3. Is there a significance difference between the treatment and the control
#    groups in the expectation of the change in score that resulted from the
#    application of the device?
t.test(change ~ active, data = magnets)
# p-value < 0.05 -> reject H0
# There is strong statistical evidence that the mean change in pain differs between the treatment and control groups.
# Patients receiving the active magnets experienced a significantly greater reduction in pain
# than those receiving the placebo.
# 4. Is there a significance difference between the treatment and the control
#    groups in the variance of the change in score that resulted from the application of the device?
var.test(change ~ active, data = magnets)
# p-value (0.0015) < 0.05 -> Reject H0
# There is a statistically significant difference in the variance of pain change between the two groups. The
# active treatment not only changes the mean response but also affects how variable patient responses are.