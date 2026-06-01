########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')


########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration)) +
    geom_histogram(binwidth = 0.1) +
    scale_x_log10(label = comma)

ggplot(trips, aes(x = tripduration)) +
    geom_density() +
    scale_x_log10(label = comma)

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) +
    geom_histogram() + 
    scale_x_log10(label = comma)

ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) +
    geom_density() + 
    scale_x_log10(label = comma)
# plot the total number of trips on each day in the dataset
trips %>%
    mutate(date = as.Date(starttime)) %>%
    group_by(date) %>%
    summarize(frequency = n()) %>%
    ggplot(aes(x = date, y = frequency)) + 
    scale_x_date(date_breaks = "1 month") +
    geom_bar(stat = "identity")

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips %>%
    select(birth_year, gender) %>%
    mutate(age = 2014 - birth_year) %>%
    group_by(age, gender) %>%
    summarize(total_trips = n()) %>%
    ggplot(aes(x = age, y = total_trips, color = gender)) +
    ylim(0, 250000) +
    geom_point()

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips %>%
    select(birth_year, gender) %>%
    filter(gender != "Unknown" & birth_year != is.na(birth_year)) %>%
    mutate(age = 2014 - birth_year) %>%
    group_by(gender, age) %>%
    summarize(total_trips = n()) %>%
    pivot_wider(names_from = gender, values_from = total_trips) %>%
    mutate(ratio = Male / Female) %>%
    ggplot(aes(x = age, y = ratio, color = age, fill = age)) +
    ylim(0, 30) +
    xlim(0, 80) +
    geom_point() +
    labs(
        title = "Total trips by age represented as a ratio male-female", x = "Age",
        y = "Ratio male-to-female")

########################################
# plot weather data

########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
weather %>%
    ggplot(aes(x = ymd, y = tmin)) +
    scale_x_date(breaks = "1 month") +
    geom_line()

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

weather %>%
    pivot_longer(cols = c(tmin, tmax), names_to = "merged", values_to = "tmin_tmax_temps") %>%
    ggplot(aes(x = ymd, y = tmin_tmax_temps, color = merged)) +
    scale_x_date(breaks = "1 month") +
    geom_line()

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
    group_by(tmin, ymd) %>%
    summarize(total_trips = n()) %>%
    ggplot(aes(x = tmin, y = total_trips, color = ymd, fill = ymd)) +
    geom_point()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
    group_by(tmin, ymd, prcp) %>%
    summarize(total_trips = n()) %>%
    mutate(substantial_precipitation = if_else(prcp > 0.05, TRUE, FALSE)) %>%
    ggplot(aes(x = tmin, y = total_trips, color = ymd, fill = ymd)) +
    geom_point() +
    facet_wrap(~ substantial_precipitation, scale = "free_y") +
    scale_y_continuous(label = comma) +
    labs(
        title = "Substantial Precipitation Summary", x = "Minimum Temperature",
        y = "Total Trips")

# add a smoothed fit on top of the previous plot, using geom_smooth
trips_with_weather %>%
    group_by(tmin, ymd, prcp) %>%
    summarize(total_trips = n()) %>%
    mutate(substantial_precipitation = if_else(prcp > 0.05, TRUE, FALSE)) %>%
    ggplot(aes(x = tmin, y = total_trips, color = ymd, fill = ymd)) +
    geom_point() +
    facet_wrap(~ substantial_precipitation, scale = "free_y") +
    scale_y_continuous(label = comma) +
    labs(
        title = "Substantial Precipitation Summary", x = "Minimum Temperature",
        y = "Total Trips") +
    geom_smooth()

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
trips_with_hour <- trips_with_weather %>%
    mutate(hour = hour(starttime)) %>%
    group_by(hour, ymd) %>%
    summarize(total_trips = n()) %>%
    summarize(average_number_of_trips = mean(total_trips), st_dev = sd(total_trips))

# plot the above
trips_with_hour %>%
    ggplot(aes(x = hour, y = average_number_of_trips)) +
    geom_ribbon(aes(ymin = average_number_of_trips - st_dev, ymax = average_number_of_trips + st_dev), alpha = .5) +
    scale_x_continuous(breaks=0:23) +
    geom_line()

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
trips_with_weather %>%
    mutate(hour = hour(starttime), weekday = wday(ymd, label = TRUE)) %>%
    group_by(hour, weekday, ymd) %>%
    summarize(total_trips = n()) %>%
    group_by(weekday, hour) %>%
    summarize(average_number_of_trips = mean(total_trips), st_dev = sd(total_trips)) %>%
    ggplot(aes(x = hour, y = average_number_of_trips, fill = weekday)) +
    geom_ribbon(aes(ymin = average_number_of_trips - st_dev, ymax = average_number_of_trips + st_dev), alpha = .5) +
    geom_line() + 
    facet_wrap(~ weekday) +
    labs(
        title = "Average Number of Trips and Standard Deviation by Hour Each Day", x = "Hour of the Day", 
        y = " Average Number of Trips"
    ) +
    theme_minimal()