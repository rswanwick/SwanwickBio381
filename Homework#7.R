# Lab #7 
# March 2, 2022

library(tidyverse)
data(starwars)
class(starwars)

# tbl = tibble
# modern take on data frame which keeps great aspects od data frames and drops frustrating ones
glimpse(starwars)
head(starwars)

# complete cases to clean up data
starwarsClean <- starwars[complete.cases(starwars[,1:10]),]
glimpse(starwarsClean)

#is.na(starwarsClean)
anyNA(starwarsClean)
#this is saying that there are no NAs in the data 

head(starwarsClean)

###############
# filter(): subset by rows 
# use >, >=, <, <=, !=, == for conditional statements 
# uses logical operators & | !

# filter automatically excludes NAs - have to ask if want to include in dataset 

filter(starwarsClean, gender == "masculine", height <180, height > 100) # commas can be used instead of & they are interchangeable 

filter(starwarsClean, eye_color %in% c("blue","brown")) 

# faster than: 
filter(starwarsClean, eye_color == "blue" | eye_color == "brown")

#######
# arrange(): reordering rows 

arrange(starwarsClean, by=desc(height))
arrange(starwarsClean, by=height, desc(mass)) # following variables serve as 'tie breaker' for the heights that are the same it will then order by mass bc you have listed height first 
tail(arrange(starwars, by=height))

#######
# select() chooses variables by their names (columns)
# these all do the same: 
starwarsClean[,1:10]
select(starwarsClean, 1:10)
select(starwarsClean, name : homeworld)
select(starwarsClean, -(films:starships)) # - sign or ! 

########
# rearrange columns with select 
select(starwarsClean, name, gender, species, everything())## everything() helper function where everything else goes after 
select(starwarsClean, contains("color")) # other helper function: ends_with(), starts_with(), matches(), num_range()

### rename columns 
select(starwarsClean, haircolor=hair_color, everything()) # new column names goes first 

###########
# mutate(): creates new variables with functions of existing variables 
mutate(starwarsClean, ratio=height/mass)
starwars_lbs <- mutate(starwarsClean, mass_lbs = mass*2.2) # convert kg to lbs in new column

select(starwars_lbs, 1:3, mass_lbs, everything())

# transmute 
transmute(starwarsClean, mass_lbs = mass * 2.2)
# if you want a separate variable to work with 

##############
# summarize and group_by(): collapse values and provides summary 
summarize(starwarsClean, meanHeight = mean(height))

summarize(starwars, meanHeight = mean(height, na.rm=TRUE))
#this when we have to exclude NAs

summarize(starwars, meanHeight = mean(height, na.rm=TRUE),
TotalN = n())
# now have the mean height and the total N that is came from the number of individuals that it derived the mean from 

# group_by()
starwarsGenders <- group_by(starwars, gender)
head(starwarsGenders)
summarize(starwarsGenders, meanHeight = mean(height, na.rm=TRUE), N = n())

##########
## PIPING %>% 
# used to emphasize a sequence of actions 
# let's you pass an intermediate result onto the next function - it takes the output of one function and uses it as the input of the next statement
# avoid when manipulating more than 1 object or if you have meaningful intermediate objects 
# formatting: always have a space before pipe %>% and it is usually cleaner code if it is followed by a new line (with auto. indent) 

starwarsClean %>% 
  group_by(gender) %>%
  summarize(meanHeight=mean(height), number = n())

# case_when() useful for multiple ifelse statements 
starwarsClean$SexID <- ifelse(starwarsClean$gender=="feminine","F", "M")

starwarsClean %>%
  mutate(sp = case_when(species == "Human" ~ "Humanoid", TRUE ~ "Non-Human"))  %>% select(name, sp, everything())

# convert long to wide format and vice-versa 
glimpse(starwarsClean)

wideSW <- starwarsClean %>% 
  select(name, sex, height) %>%
  pivot_wider(names_from=sex, values_from=height,
values_fill = NA)

## long format 
wideSW %>%
  pivot_longer(cols=male:female, 
               names_to = "sex", 
               values_to = "height", values_drop_na = TRUE)

### one more example 
starwars %>% 
  select(name,homeworld) %>% 
  group_by(homeworld) %>%
  mutate(rn= row_number()) %>%
  ungroup() %>%
  pivot_wider(names_from = homeworld, values_from = name) %>%
select(-rn)
