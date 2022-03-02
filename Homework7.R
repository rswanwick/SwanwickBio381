# Lab #7 
# March 2, 2022
# RHS 

library(tidyverse)
data(iris)
class(iris)

glimpse(iris)
head(iris)

#Question 1: There are 150 rows or observations and 5 columns or variables 

# Question 2: Create a new data frame iris1 that contains only the species virginica and versicolor with sepal lengths longer than 6 cm and sepal widths longer than 2.5 cm. How many observations and variables are in the dataset?

iris1 <- filter(iris, Species %in% c("virginica", "versicolor"), Sepal.Length > 6, Sepal.Width > 2.5)
glimpse(iris1)

# There are 56 observations and 5 variables 

# Question #3: Now, create a iris2 data frame from iris1 that contains only the columns for Species, Sepal.Length, and Sepal.Width. How many observations and variables are in the dataset?

iris2 <- select(iris1, Species, Sepal.Length, Sepal.Width)
glimpse(iris2)
# there are 56 observations and 3 variables 

# Question #4 Create an iris3 data frame from iris2 that orders the observations from largest to smallest sepal length. Show the first 6 rows of this dataset.

iris3 <- arrange(iris2, by=desc(Sepal.Length))
head(iris3)

# Question #5 Create an iris4 data frame from iris3 that creates a column with a sepal area (length * width) value for each observation. How many observations and variables are in the dataset?

iris4 <- mutate(iris3, sepal_area=Sepal.Length*Sepal.Width)
glimpse(iris4)

# there are 56 observations and 4 variables 

# Question #6 Create iris5 that calculates the average sepal length, the average sepal width, and the sample size of the entire iris4 data frame and print iris5.

iris5 <- summarize(iris4, meanSepalLength = mean(Sepal.Length), meanSepalWidth = mean(Sepal.Width), N = n())
print(iris5)

# Question #7: Finally, create iris6 that calculates the average sepal length, the average sepal width, and the sample size for each species of in the iris4 data frame and print iris6.

iris6 <- iris4 %>% 
        group_by(Species) %>%
summarize(meanSepalLength = mean(Sepal.Length), meanSepalWidth = mean(Sepal.Width), N = n())
print(iris6)

# Question #8 In these exercises, you have successively modified different versions of the data frame iris1 iris1 iris3 iris4 iris5 iris6. At each stage, the output data frame from one operation serves as the input fro the next. A more efficient way to do this is to use the pipe operator %>% from the tidyr package. See if you can rework all of your previous statements into an extended piping operation that uses iris as the input and generates iris6 as the output.

iris6 <- filter(iris, Species %in% c("virginica", "versicolor"), Sepal.Length > 6, Sepal.Width > 2.5) %>%
  select(Species, Sepal.Length, Sepal.Width) %>%
  arrange(by=desc(Sepal.Length)) %>%
  mutate(sepal_area=Sepal.Length*Sepal.Width) %>%
  group_by(Species) %>%
  summarize(meanSepalLength = mean(Sepal.Length), meanSepalWidth = mean(Sepal.Width), N = n())
  
print(iris6)

# Question #9 Create a ‘longer’ data frame with three columns named: Species, Measure, Value.
head(iris)
Longer_df <- iris %>%
  pivot_longer(cols=1:4, 
               names_to = "Measure", 
               values_to = "Value")
print(Longer_df)
