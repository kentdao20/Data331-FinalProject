### DATA 332 Final Project

### Authors: Kent Dao, Sally Boutaleb

## Overview:

The data was taken from the biology deapartment of Augustana College. We want to clean and analyze the information base on the technical skill in class and understanding to draw conclusion from the Cabbage Butterfly and Ladybug. The data on Lady Bug was collected by Augustana Biology deapartment for keeping track of the number. This include what species the LadyBug belong to, what are the families, who is the collecor, the coordinate, and the date. The Cabbage Butterfly data was collected from 1865 to 2015. We took both sets of data and make visualization to easier understand and with different test to see if the data correlate with each other using R.

### LadyBug Data

## Process:

**1. Cleaning data**

The data was cleaned by figuring out different unique name and variable, then I change all of them into the same one. The name of the collector was mostly the same, but was write down in different format and way, which make the count wrong, as it make the count become an extra person. Most of the data regarding the species of ladybug encounter the same problem too, which make me do the same thing, which is to chnge back the variable name into one uniform format. Other than that, we dop the n/a value and most of the data is good for using afterward.


**2. Visualization**
### Count by collector

The idea of counting the collector is to know who have the most and least sample after many days of collecting, and to recognize the person with the most data collected. We can see that O. Ruffatto have the most collect sample, and all 4 of them were collecting roughly the same amount. 

![Collector count](https://user-images.githubusercontent.com/118495124/206943340-50a4ec36-3085-40f6-b752-ae7d559778b8.png)

### Collector and Species relationship

In this graph that is a deeper understanding on which type of species was collected by which collector and to see if they all have the same amount of frequency for each species. In the graph, we can see a big margin of Harmonia Axyridis was collected by them, we can see that this type of ladybug appear a lot more frequent around this area. All of the collector collected roughly the same amount for all species, which we can tell that the amount of ladybug in this area is being distribute pretty evenly

![Collector and Species rela](https://user-images.githubusercontent.com/118495124/206943480-5de6b673-d99c-49e7-84a8-9535d113139b.png)

### Species count 

In the visualization for species count, we can see that Harmonua Axyridis has the most collect, which is something we saw on the visualization above already. 

![Species Count](https://user-images.githubusercontent.com/118495124/206943484-4aa4307d-4476-45bd-bbe8-f503846caeca.png)

### Date of collect

In this visualization, we see that which data the sample was collected, which indicate a significant increase from June to August. This can be because of the LadyBug population has increase significantly, ladybug migrate from another area are coming or the skill of the collector has improve significantly.

![Date collect](https://user-images.githubusercontent.com/118495124/206943486-7b7b4f08-26fa-4f6e-b395-ab70ac5b03b7.png)


**3. Test**

As the test for this dataset is only the amount of species total, we decided to have the visualization on the date collect to see the minimum amount of sample collectedd was on June 17th, 2021 while the most collected was on August 3th, 2021. The median of this data is on August 4th, 2021 and we put all the data in a dataframe in R. The t-test was not working so I decided to do a Chi-square test instead to find if the correlation in the data is not 0. We looked at Coordinate vs Species and Collector vs Species. The p-value is 0.0004988, which is smaller than our alpha (0.05), as this is a 2 tail test. WE have evidence that there is correlation betweeen Coordinate and Species.


### Cabbage Butterfly Data

### 1. Cleaning data

butterfly

### 2. Visualization

*VISUAL #1

We utilized a line graph to monitor changes in average wing width over time. We can compare the right and left wings on the same plane, and it's fascinating to see how this particular anatomical trait of the cabbage butterfly evolved from 1865 to 2015. It also makes us wonder what is causing the data's fluctuation. This information might potentially be used to forecast the butterfly's wing width in the future.

![double line graph 1](https://user-images.githubusercontent.com/118495124/207156161-d17e20c9-44a7-4200-8e2d-dca3a37e8c31.png)

*VISUAL #2

This visualization demonstrates how the cabbage butterfly's wing length differs depending on the country. It illustrates how the average lengths of the right and left wings have changed over time in each of the four countries where data was gathered. It also demonstrates the fact that certain countries only have data from particular years. We easily compare the countries in a single picture by utilizing the facet wrap function.

![graph over the years updated (2)](https://user-images.githubusercontent.com/118495124/207156202-7856f9e4-fc3a-4fa4-b00b-0b77c761c527.png)

![Graph over the years updated](https://user-images.githubusercontent.com/118495124/207156213-9534dcd7-cc6a-4933-bc91-fd282623cad0.png)

*VISUAL #3

The purpose of this visual is to analyze the location of the apex differs among male and female cabbage butterflies. It is seen here that the male apex is much larger than that of a female. When you look at both wings you will find similar distribution. This makes sense given that butterfly wings are symmetrical.

![Wing Apex Average By Sex](https://user-images.githubusercontent.com/118495124/207156277-2ebf32a7-f126-4fc1-b87e-38657aa7e049.png)

*VISUAL #4

The purpose of this visual is to compare the Anterior spot area in male and female cabbage butterfly. The male's anterior spot is for both wings is significantly greater than the female's. However, we want to generate a t-test to see if the sex affects the Anterior spot average. 

![Anterior spot average by sex](https://user-images.githubusercontent.com/118495124/207156309-53a0f6df-8d59-443c-b07a-4d3f11403eda.png)

### 3. T-test

We performed a paired t-test for the anterior spot average and sex. the confidence interval includes 0, thereofre, we can say that there is no significant difference between the means of the two populations, at a given level of confidence. 

### 4.Mean, Median, Max, Min

In this section, you will see a variety of visualizations that show the descriptive statistics of the Cabbage Butterfly data. We preformed calculations and visualized this data by splitting the data into two groups, the left and right data. 

*VISUAL 1

The first visualization you will see is a stacked line graph showing the median apex, length, and width of the left and right data by decade. You can see that both the left and right wing data are very similar when it comes to the peaks and valleys represented on the graph. 

![Median_by_decade](https://user-images.githubusercontent.com/118495124/207156039-ced38300-ea11-4433-9d56-9c134299c728.png)

*VISUAL 2

The next graph is a scatter plot showing the correlation between the right and left data. This correlation is positive and very strong because as you can tell from, the visualization it is very linear. This makes a lot of sense because the two variables being looked at are the left and right side of the cabbage butterfly and a butterfly is symmetrical.

![graph 7](https://user-images.githubusercontent.com/118495124/207156339-4f503c05-3a86-46f6-b136-b3d4cb692fc5.png)

*VISUAL 3

Lastly, the boxplot visual shows the descriptive statistics for the data in a different manner. Here we can draw a similar conclusion regarding the symmetry of butterfly.

![graph 9 final](https://user-images.githubusercontent.com/118495124/207156367-c0d58cdc-2a57-4524-82b9-0d18a8513ca7.png)


