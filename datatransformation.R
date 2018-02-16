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

summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
by_day <- group_by(flights, year, month, day)

a <- summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))
# gives the mean delay time everyday row_number = 365

# Together group_by() and summarise() provide one of the tools 
# that you’ll use most commonly when working with dplyr: 
# grouped summaries. 

# Imagine that we want to explore the relationship between the 
# distance and average delay for each location. Using what you 
# know about dplyr, you might write code like this:

by_dest <- group_by(flights, dest)
delay <- summarise(by_dest, 
                   count = n(), 
                   dist = mean(distance, na.rm = TRUE), 
                   delay = mean(arr_delay, na.rm = TRUE))
delay
delay <- filter(delay, count > 20, dest != "HNL")

ggplot(data =  delay, mapping = aes(x = dist, y = delay)) + 
  geom_point(aes(size = count), alpha = 1/3) + 
  geom_smooth(se = FALSE)


delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(), 
    dist = mean(distance, na.rm = TRUE), 
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")


not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>%
  group_by(year, month, day) %>%
    summarise(mean = mean(dep_delay))

delays <- not_cancelled %>%
  group_by(tailnum) %>%
    summarise(
      delay = mean(arr_delay)
    )

ggplot(data = delays, mapping = aes(x = delay)) + 
  geom_freqpoly(binwidth = 10)


delays <- not_cancelled %>% 
  group_by(tailnum) %>%
    summarise(
      delay = mean(arr_delay, na.rm = TRUE), 
      n = n()
    )


ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

delays %>%
  filter(n > 20) %>%
    ggplot(mapping = aes(x = n, y = delay)) +
     geom_point(alpha = 1/10)

# 5.3 arrange()

arrange(flights, year, month, day) # <--change order of the dataframe by selected column

arrange(flights, desc(arr_delay)) ## <-- In descending order

df <- tibble(x=c(5,2,NA))
arrange(df, x) ## Missing values are sorted at the end

 # 5.4 select()

select(flights, year, month, day)

select(flights, starts_with("y"))
select(flights, ends_with("y"))
select(flights, contains("e"))
select(flights, matches("(.)\\1")) ## regular expression

rename(flights, tail_num = tailnum)  ## rename variable names without dropping vars

# Renaming -----------------------------------------
# * select() keeps only the variables you specify
select(iris, petal_length = Petal.Length)

# * rename() keeps all variables
rename(iris, petal_length = Petal.Length)

select(flights, time_hour, air_time, everything())

# 5.6 add new variables with mutate()

flights_sml <- select

# 12 Tidy data