library(tidyverse)

####################################################################################
# 12.2.1. Exercise 2
# Compute the rate for table2, and table 4a + table4b. You will need
# to perform four operations:

#   1. Extract the number of TB cases per country per year.
#   2. Extract the matching population per country per year.
#   3. Divide cases by population, and multiply by 10000.
#   4. Store back in the appropriate place.

table2 %>%
  pivot_wider(names_from = type, values_from = count) %>%
  group_by(country, year) %>%
  mutate(ratio = (cases/population)*10000)

table_4a <- table4a %>% pivot_longer(names_to = "year", values_to = "cases", cols = c('1999', '2000'))
table_4b <- table4b %>% pivot_longer(names_to = "year", values_to = "population", cols = c('1999', '2000'))

joined_table <- inner_join(table_4a, table_4b)

joined_table %>%
  mutate(ratio = (cases/population*10000))

# Which representation is easiest to work with? Which is hardest? Why?
# Add your answer as a comment.

# I liked both approaches. I believe the first representation is easier to work with since we do
# not have to create two dataframes and store both restructured tables into them like we did in the 
# second representation. It may be easier to perform other operations after we used pivot_longer(),
# and join the tables, but it depends on usability.

####################################################################################
# 12.3.3 Exercise 1
# 1. Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
# Carefully consider the following example:
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

# (Hint: look at the variable types and think about column names.)
# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). 
# What does it do? Add your answer as a comment.
# it changes the type of the variable, that's why it is not always symmetrical
####################################################################################
# 12.3.3 Exercise 3
# What would happen if you widen this table? Why? # It would attempt to create different entries, but
# since there is a duplicate entry with the same name, but different value, it would throw an error at us.
# How could you add a new column to uniquely identify each value? # Using the pivot_wider() function
#  Add your answers as a comment.
people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)