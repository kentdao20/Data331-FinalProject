library(tidyverse)
library(dplyr)
library(lubridate)
library(readxl)
library(data.table)
library(readr)
library (usmap)

rm(list=ls())
#setting the working directory
setwd("D:/DATA 331/R file")
#import the data from excel and cleaning it
df_butterfly_cleaned <- read_excel("butterfly Data.xlsx", sheet = 1, .name_repair="universal")
df_raw_data <- read_excel("CompletePierisData.xlsx", sheet = 1,.name_repair="universal") %>%
  dplyr::rename("continent" = "dwc.continent","country" = "dwc.country", "stateprovince" = "dwc.stateProvince", 
                "Latitude" = "DecimalLatitudeUpdated", "Longitude" = "DecimalLongitudeUpdated", "core.ID" = "coreid", 
                "RAnteriorSpot"= "RAnteriorSpotM3", "LAnteriorSpot"= "LAnteriorSpotM3") %>%
  dplyr::mutate(country = str_replace(country, pattern = "USA", replacement = "United States"))

# Create a data frame with selected column   
df_cleaned <- df_raw_data %>%
  dplyr::select("core.ID", "YearUpdated", "continent", "country", "Latitude", "Longitude", "LAnteriorSpot", "RAnteriorSpot") 

# Used the function left join to add the above selected columns to the cleaned butterfly data set to have all the column needed for analysis
df_final <- df_butterfly_cleaned %>%
  left_join(df_cleaned, by = c ("core.ID")) %>%
# removes NAs from the data set to make it ready for the project's analysis
  drop_na()

#generating the average of variables from our final data frame to for  analysis

df_final$AnteriorSpot <- as.numeric(df_final$LAnteriorSpot)+as.numeric(df_final$RAnteriorSpot) 
df_final$Anterior_spot_average <- df_final$AnteriorSpot/2
df_final$apex <- as.numeric(df_final$LW.apex.A)+as.numeric(df_final$RW.apex.A) 
df_final$apex_average <- df_final$apex/2
df_final$Length <- as.numeric(df_final$LW.length )+as.numeric(df_final$RW.length) 
df_final$length_average <- df_final$Length/2
df_final$Width <- as.numeric(df_final$LW.width )+as.numeric(df_final$RW.width) 
df_final$width_average <- df_final$Length/2


# visual #1 
# Creating a data frame where we chose specific columns, grouped by countries, and calculated the mean width of each wing for each country
df_wing_width <- df_final %>%
  select(YearUpdated, LW.width, RW.width) %>%
  group_by(YearUpdated) %>%
  summarise(lw_width_average = mean(LW.width),
            rw_width_average = mean(RW.width))

# using the package ggplot we created the double line graph 
ggplot(df_wing_width, aes(x=YearUpdated, group(sex))) + 
  geom_line(aes(y = lw_width_average), color = "red") + 
  geom_point(aes(y = lw_width_average), color = "red") +
  geom_line(aes(y = rw_width_average), color= "blue") +
  geom_point(aes(y = rw_width_average), color = "blue") +
  xlab("Year")  +
  ylab("Wing Width") +
  ggtitle("Wing Width Over Time") 

#We utilized a line graph to monitor changes in average wing width over time. 
#We can compare the right and left wings on the same plane. 
#it's fascinating to see how this particular anatomical trait of the cabbage butterfly evolved from 1865 to 2015.
#It also makes us wonder what is causing the data's fluctuation. 
#This information might potentially be used to forecast the butterfly's wing width in the future.


# Visual 2: Line graph showing Average Length for each Wing by Country over the years
# creating a data frame with the necessary characteristics for the visual
df_wing_length_country <- df_final %>%
  select(country, LW.length, RW.length, YearUpdated) %>%
  group_by(country, YearUpdated) %>%
  summarise(lw_length_average = mean(LW.length),
            rw_length_average = mean(RW.length))

# Right Wing length by Country over the years
ggplot(data = df_wing_length_country, aes(YearUpdated, rw_length_average)) +
  geom_line(color = "red", size = 1) +
  geom_point(color="red") + 
  labs(title = "Average Right Wing Length over the years by Country",
       y = "Right Wing Average Length", x = "year") + 
  facet_wrap(~ country)


# Left Wing length by Country over the years
ggplot(data = df_wing_length_country, aes(YearUpdated, lw_length_average)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color="blue") + 
  labs(title = "Average Left Wing Length over the years by Country",
       y = "Left Wing Average Length", x = "") + 
  facet_wrap(~ country)

# Purpose of this visual: 
#This visualization demonstrates how the cabbage butterfly's wing length differs depending on the country. 
#It illustrates how the average lengths of the right and left wings have changed over time in each of the four countries where data was gathered. 
#It also demonstrates the fact that certain nations only have data from particular years. 
#We easily compare the countries in a single picture by utilizing the facet wrap function.

# Visual 3: Bar graph that shows wing apex by sex
# Creating a data frame with the specifications needed for the visual 
# Calculated the average of each wings apex
df_apex <- df_final %>%
  select(sex, apex_average) %>%
  group_by(sex) 

# Created chart using package ggplot for the Average Wing by sex
ggplot(data = df_final, aes(x =sex, y=apex_average, fill=sex)) +
  geom_bar(stat="identity")+
  xlab("Sex") +
  ylab("Wing Apex Average") + 
  ggtitle("Wing Apex Average by Sex")

# Purpose of this visual:
# The purpose of this visual is to analyze the location of the apex differs among male and female cabbage butterflies. 
# It is seen here that the male apex is much larger than that of a female. 
# When you look at the apex average of both wings you will find similar distribution.
# This makes sense because butterfly wings are symmetrical. 

#visual #4 
df_anterior <- df_final %>%
  select(sex, Anterior_spot_average) %>%
  group_by(sex)

ggplot(data = df_anterior, aes(x =sex, y=Anterior_spot_average, fill=sex)) +
  geom_bar(stat="identity")+
  xlab("Sex") +
  ylab("Anterior Spot Average") + 
  ggtitle("Anterior spot average by Sex")

#the purpose of this visual is to compare the Anterior spot area in male and female cabbage butterfly. 
#the male's anterior spot is for both wings is significantly greater than the female's. 

# T-TEST 

t_test = t.test(df_final$Anterior_spot_average ~ df_final$sex, data = df_final, var.equal = TRUE)
#We performed a t-test for the anterior spot average and sex.
#the confidence interval includes 0.
#we can say that there is no significant difference between the means of the two populations, at a given level of confidence.

# VISUAL FOR MEAN, MEDIAN, MAX, MIN
# Creating two separate data frames that encompassed the left and right wing data separately 

left_data = c(df_final$LW.length, df_final$LW.width, df_final$LW.apex.A)
right_data = c(df_final$RW.length, df_final$RW.width, df_final$RW.apex.A)

right_table = data.frame(df_final$`RW.length`, df_final$`RW.width`, df_final$`RW.apex.A`, df_final$RAnteriorSpot)
left_table = data.frame(df_final$`LW.length`, df_final$`LW.width`, df_final$`LW.apex.A`, df_final$LAnteriorSpot)


Llength_median = df_final$LW.length
Lwidth_median = df_final$LW.width
Lapex_median = df_final$LW.apex.A
LAnterior_median = df_final$LAnteriorSpot

Rlength_median = df_final$RW.length
Rwidth_median = df_final$RW.width
Rapex_median = df_final$RW.apex.A
RAnterior_median = df_final$RAnteriorSpot

median_df = data.frame(Llength_median, Lwidth_median, Lapex_median, Rlength_median, Rwidth_median, Rapex_median)
median_df


plot.ts(median_df)

plot(left_data, right_data)
lines(left_data, right_data, type = "o", col = 4)

t.test(left_data, right_data, paired = TRUE)

model1 = lm(left_data ~ right_data)
#summary(model1)
#plot(model1)

max(left_data)
min(left_data)

max(right_data)
min(right_data)

#The left plot is for the left data. The top line is the max value (28.75).
#The bottom line is the min value (0.18).

#The right plot is for the right data. The top line is the max value (28.57).
#The bottom line is the min value (0).
boxplot(left_data, right_data)
