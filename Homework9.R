# Lab 9
# March 23, 2022
# RHS 

###################################

# -------------------------------
# FUNCTION Treatments 
# description: create a function that creates a data frame from all of the treatments 
# inputs: control, resistance, resilience and transition treatment data 
# outputs: summary of stats for all of the treatments within one single data frame
##################################
library(tidyverse)
Treatments <- function(CT = rnorm(35, mean = 125, sd = 20), RT = rnorm(35, mean = 125, sd = 20), RL = rnorm(35, mean = 125, sd = 35), TR = rnorm(35, mean = 135, sd = 50)) {

t_data_frame <- as.data.frame(cbind(CT,RT,RL,TR))
  
Longer_df <- t_data_frame %>%
  pivot_longer(cols=1:4, 
               names_to = "treatment", 
               values_to = "agb_Mg")

} 

final_output <- Treatments()
# end of function)
#---------------------------------

# -------------------------------
# FUNCTION Resilience_Treatment
# description: variable thinning and more trees removed 
# inputs: lower mean, and higher variability
# outputs: summary of stats for resilience treatments 
##################################
Resilience_Treatment <- function(rnorm) {

RL <- rnorm(35, mean = 125, sd = 35)
RL <- data.frame(RL, "RL")
colnames(RL) <- c("agb_Mg", "treatment")

return("Checking...Resilience_Treatment")

} 
# end of Resilience_Treatment)
#---------------------------------

# -------------------------------
# FUNCTION Transition_Treatment
# description: Most trees removed, gap cuts and thinnings 
# inputs: lowest biomass, and most variability
# outputs: summary of stats for transition treatments 
##################################
Transition_Treatment <- function(rnorm) {

TR <- rnorm(35, mean = 135, sd = 50)
TR <- data.frame(TR, "TR")
colnames(TR) <- c("agb_Mg", "treatment")

return("Checking...Transition_Treatment")

} 
# end of Transition_Treatment)
#---------------------------------

# -------------------------------
# FUNCTION my_data
# description: this is going to combine all of the treatments into one data frame 
# inputs: CT, RT, RL, TR
# outputs: vector of all treatments combined 
##################################
my_data <- function(x=5) {

id <- c(1:140)
my_data <- rbind(CT, RT, RL, TR)
my_data <- cbind(id, my_data)
head(my_data)
tail(my_data)

return("Checking...my_data")

} 
# end of my_data)
#---------------------------------

# -------------------------------
# FUNCTION graph_results_box
# description: description
# inputs: my_data and the treatments 
# outputs: creates a box plot
##################################
graph_results_box <- function(x=5) {

a1 <- aov(agb_Mg ~ treatment, data = my_data)
summary(a1)
  
library(ggplot2)
a2 <- ggplot(data = my_data, aes(x=treatment, y=agb_Mg, fill=treatment)) + geom_boxplot()+theme_classic()
a2
plot(a2)
return("Checking...graph_results_box")

} # end of graph_results)
#---------------------------------

# -------------------------------
# FUNCTION graph_results_scatter
# description: Making a scatter plot of the different treatments 
# inputs: my_data and the treatments 
# outputs: scatter plot
##################################
graph_results_scatter <- function(x=5) {

a3 <- ggplot(data = my_data, aes(x=treatment, y=agb_Mg, fill=treatment)) + geom_point()+theme_classic()
a3
plot(a3)

return("Checking...graph_results_scatter")

} 
# end of graph_results_scatter)
#---------------------------------
library(ggplot2)
Control_Treatment()
Resistance_Treatment()
Resilience_Treatment()
Transition_Treatment()
graph_results_box()
graph_results_scatter()