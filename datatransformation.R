library(nycflights13)
library(tidyverse)

flights
?flights


# int integers
# dbl doubles or real numbers
# chr character vectors or strings 

# dttm date-times date + time 
# lgl logical 
# fctr factor
# date means just date

# filter() pick observations by their values

# arrange() reorder
# select() pick variables by names
# mutate() create new variables with functions of existing variables
# summarise() collapse many values down to a single summary

# group_by()

# filter rows with filter()

filter(flights, month == 1, day == 1)

sqrt(2)^2 == 2
1/49*49 == 1

# computer use finite precision arithmetic (they obviously can't store an infinite number of 
# digits) so use near()

near(sqrt(2)^2, 2)
near(1/49*49, 1)


filter(flights, month == 11 | month == 12)
nov_dec <- filter(flights, month %in% c(11, 12))


NA == NA

arrange(flights, year, month, day)

select(flights, year, month, day)


rename(flights, tail_num = tailnum)

select(flights, time_hour, air_time, everything())


flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time)


mutate(flights_sml, 
       gain = arr_delay - dep_delay, 
       speed = distance / air_time * 60
       )

mutate(flights_sml, 
       gain = arr_delay - dep_delay, 
       hours = air_time / 60, 
       gain_per_hour = gain / hours)


transmute(flights, 
       gain = arr_delay - dep_delay, 
       hours = air_time / 60, 
       gain_per_hour = gain / hours)

transmute(flights, 
          dep_time, 
          hour = dep_time %/% 100, 
          minute = dep_time %% 100)
x <-  1:10
cumsum(x)
cummean(x)
