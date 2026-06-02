library(tidyverse)

####################################################################################
# IST Chapter 4, Exercise 4.1
#
# Table 4.4 presents the probabilities of the random variable Y:
#
#   Value | Probability
#   ------|------------
#     0   |    1p
#     1   |    2p
#     2   |    3p
#     3   |    4p
#     4   |    5p
#     5   |    6p
#
# These probabilities are a function of the number p, the probability of
# the value "0". Answer the following questions:
#
# 1. What is the value of p? # p = 1/21
# 2. P(Y < 3) = ? # p = 6/21
# 3. P(Y = odd) = ? # p = 12/21
# 4. P(1 <= Y < 4) = ? # p = 9/21
# 5. P(|Y - 3| < 1.5) = ? # p = 12/21
# 6. E(Y) = ? # answer is 70/21 or 10/3, approx. 3.33
# 7. Var(Y) = ? # answer is approx. 2.22
# 8. What is the standard deviation of Y? # approx. 1.49

####################################################################################
# IST Chapter 4, Exercise 4.2
#
# One invests $2 to participate in a game of chance. In this game a coin
# is tossed three times. If all tosses end up "Head" then the player wins
# $10. Otherwise, the player loses the investment.
#
# 1. What is the probability of winning the game? # for one toss, probability to be heads is 1/2, for three tosses simultaneously, it would be 1/2 x 1/2 x 1/2 = 1/8
# 2. What is the probability of losing the game? # 1 - winning, which is 1 - 1/8 = 7/8
# 3. What is the expected gain for the player that plays this game?
#    (Notice that the expectation can obtain a negative value.) # answer is -3/4

####################################################################################
# IST Chapter 6, Exercise 6.1
#
# Consider the problem of establishing regulations concerning the maximum
# number of people who can occupy a lift. In particular, we would like to
# assess the probability of exceeding maximal weight when 8 people are
# allowed to use the lift simultaneously and compare that to the probability
# of allowing 9 people into the lift.
#
# Assume that the total weight of 8 people chosen at random follows a
# Normal distribution with a mean of 560kg and a standard deviation of 57kg.
# Assume that the total weight of 9 people chosen at random follows a
# Normal distribution with a mean of 630kg and a standard deviation of 61kg.
#
# 1. What is the probability that the total weight of 8 people exceeds 650kg? # answer is 0.057
1 - pnorm(650, mean = 560, sd = 57)
# 2. What is the probability that the total weight of 9 people exceeds 650kg? # answer is 0.371
1 - pnorm(650, mean = 630, sd = 61)
# 3. What is the central region that contains 80% of distribution of the
#    total weight of 8 people? # answer is interval [487, 633]
qnorm(0.10, mean = 560, sd = 57) # Lower Bound = 487
qnorm(0.90, mean = 560, sd = 57) # Upper Bound = 633
# 4. What is the central region that contains 80% of distribution of the
#    total weight of 9 people? # answer is interval [552, 708]
qnorm(0.10, mean = 630, sd = 61) # Lower Bound = 552
qnorm(0.90, mean = 630, sd = 61) # Upper Bound = 708

# Hint: use pnorm() and qnorm().

####################################################################################
# IST Chapter 7, Exercise 7.1
#
# The file "pop2.csv" contains information associated to the blood pressure
# of an imaginary population of size 100,000:
# http://pluto.huji.ac.il/~msby/StatThink/Datasets/pop2.csv
#
# Variables: id, sex, age, bmi, systolic, diastolic, group
#
# Our goal is to investigate the sampling distribution of the sample average
# of the variable "bmi". We assume a sample of size n = 150.
#
# 1. Compute the population average of the variable "bmi". # answer is 25
mean_of_bmi <- pop2 %>%
    summarize(mean(bmi))
# 2. Compute the population standard deviation of the variable "bmi". # answer is 4.19
st_dev_bmi <- pop2 %>%
    summarize(sd(bmi))
# 3. Compute the expectation of the sampling distribution for the sample
#    average of the variable. # it would be 25, the expectation would be the mean
# 4. Compute the standard deviation of the sampling distribution for the
#    sample average of the variable. # it would be standard deviation (4.19) / sqrt(150) = ~ 0.34
# 5. Identify, using simulations, the central region that contains 80% of
#    the sampling distribution of the sample average.
random_means <- replicate(1000, expr = mean(slice_sample(pop2, n = 150) $bmi))
lower_bound <- quantile(random_means, 0.10) # 24.55
upper_bound <- quantile(random_means, 0.90) # 25.44
# 6. Identify, using the Central Limit Theorem, an approximation of the
#    central region that contains 80% of the sampling distribution of the
#    sample average.
qnorm(0.10, mean = 25, sd = 0.34) # 24.56
qnorm(0.90, mean = 25, sd = 0.34) # 25.43

pop2 <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/pop2.csv")

# Hint: for (5), use replicate() to draw many samples of size 150,
# compute the mean of bmi for each, then use quantile().
# For (6), use qnorm() with the expectation and sd from (3) and (4).
