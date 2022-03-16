# Lab #8
# March 16, 2022 
# Rachel Swanwick 

# Question #1: Think about an ongoing study in your lab (or a paper you have read in a different class), and decide on a pattern that you might expect in your experiment if a specific hypothesis were true.

# In my lab, we are running a series of experiments at Corinth experimental forest in Vermont. They are running different treatment types-- control, resistance, resilience and transition.  We would expect that above ground biomass would be less for treatments that were thinned so it would greatest for transition treatment. 

# Question #2: To start simply, assume that the data in each of your treatment groups follow a normal distribution. Specify the sample sizes, means, and variances for each group that would be reasonable if your hypothesis were true. You may need to consult some previous literature and/or an expert in the field to come up with these numbers.

# Treatments and control (CT) have 10 plots and 35 blocks (140 total) 
# Resistence (RT): uniform thinning and few trees removed 
# Resilience (RC): variable thinning and more trees removed 
# Transition (TR): Most trees removed, gap cuts and thinnings 
# Control (CT): this is the control group that is uncut 

# Question 3: Using the methods we have covered in class, write code to create a random data set that has these attributes. Organize these data into a data frame with the appropriate structure.
# all treatments have 35 plots
# control treatment has plot mean of 125 Mg/ha, minimal variability
CT <- rnorm(35, mean = 125, sd = 20)
CT <- data.frame(CT, "CT")
colnames(CT) <- c("agb_Mg", "treatment")
# resistance treatment has lower mean, still low variability
RT <- rnorm(35, mean = 125, sd = 20)
RT <- data.frame(RT, "RT")
colnames(RT) <- c("agb_Mg", "treatment")
# resilience treatment has lower mean, and higher variability
RL <- rnorm(35, mean = 125, sd = 35)
RL <- data.frame(RL, "RL")
colnames(RL) <- c("agb_Mg", "treatment")
# transition has lowest biomass, and most variability
TR <- rnorm(35, mean = 135, sd = 50)
TR <- data.frame(TR, "TR")
colnames(TR) <- c("agb_Mg", "treatment")
id <- c(1:140)
my_data <- rbind(CT, RT, RL, TR)
my_data <- cbind(id, my_data)
head(my_data)
tail(my_data)

# Question #4: Now write code to analyze the data (probably as an ANOVA or regression analysis, but possibly as a logistic regression or contingency table analysis. Write code to generate a useful graph of the data.

a1 <- aov(agb_Mg ~ treatment, data = my_data)
summary(a1)

library(ggplot2)
a2 <- ggplot(data = my_data, aes(x=treatment, y=agb_Mg, fill=treatment)) + geom_boxplot()+theme_classic()
a2

# Question #5 Try running your analysis multiple times to get a feeling for how variable the results are with the same parameters, but different sets of random numbers.

# Question #6 Now begin adjusting the means of the different groups. Given the sample sizes you have chosen, how small can the differences between the groups be (the “effect size”) for you to still detect a significant pattern (p < 0.05)?

# I get more significant results with the mean being 10 inbetween each of them--when I lowered the means to 5 inbetween each 1 then it was not as significant 

CT <- rnorm(35, mean = 100, sd = 20)
CT <- data.frame(CT, "CT")
colnames(CT) <- c("agb_Mg", "treatment")
# resistance treatment has lower mean, still low variability
RT <- rnorm(35, mean = 95, sd = 20)
RT <- data.frame(RT, "RT")
colnames(RT) <- c("agb_Mg", "treatment")
# resilience treatment has lower mean, and higher variability
RL <- rnorm(35, mean = 90, sd = 35)
RL <- data.frame(RL, "RL")
colnames(RL) <- c("agb_Mg", "treatment")
# transition has lowest biomass, and most variability
TR <- rnorm(35, mean = 85, sd = 50)
TR <- data.frame(TR, "TR")
colnames(TR) <- c("agb_Mg", "treatment")
id <- c(1:140)
my_data <- rbind(CT, RT, RL, TR)
my_data <- cbind(id, my_data)
a1 <- aov(agb_Mg ~ treatment, data = my_data)
summary(a1)


# Question #7 Alternatively, for the effect sizes you originally hypothesized, what is the minimum sample size you would need in order to detect a statistically significant effect? Again, run the model a few times with the same parameter set to get a feeling for the effect of random variation in the data.

# I can drop the sample size down to 15 and still have significant results 4/5 times 

CT <- rnorm(15, mean = 100, sd = 20)
CT <- data.frame(CT, "CT")
colnames(CT) <- c("agb_Mg", "treatment")
# resistance treatment has lower mean, still low variability
RT <- rnorm(15, mean = 90, sd = 20)
RT <- data.frame(RT, "RT")
colnames(RT) <- c("agb_Mg", "treatment")
# resilience treatment has lower mean, and higher variability
RL <- rnorm(15, mean = 80, sd = 35)
RL <- data.frame(RL, "RL")
colnames(RL) <- c("agb_Mg", "treatment")
# transition has lowest biomass, and most variability
TR <- rnorm(15, mean = 70, sd = 50)
TR <- data.frame(TR, "TR")
colnames(TR) <- c("agb_Mg", "treatment")
id <- c(1:140)
my_data <- rbind(CT, RT, RL, TR)
my_data <- cbind(id, my_data)
a1 <- aov(agb_Mg ~ treatment, data = my_data)
summary(a1)