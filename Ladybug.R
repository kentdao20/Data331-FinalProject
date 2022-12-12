library(tidyverse)
library(dplyr)
library(lubridate)
library(readxl)
rm(list=ls())

setwd("D:/DATA 331/Final Project")

df_scan_ladybug <- read.csv("Scan Ladybug Data.csv")
df_ladybug <- read_excel("Ladybug Data.xlsx", sheet = 1) 

#cleaned data
df_ladybug$collector <- str_replace(df_ladybug$collector, "m gorsegner", "M. Gorsegner")
df_ladybug$collector <- str_replace(df_ladybug$collector, "m. gorsegner", "M. Gorsegner")
df_ladybug$collector <- str_replace(df_ladybug$collector, "M.Gorsegner", "M. Gorsegner")
df_ladybug$collector <- str_replace(df_ladybug$collector, "Marissa Gorsegner", "M. Gorsegner")
df_ladybug$collector <- str_replace(df_ladybug$collector, "M. gorsegner", "M. Gorsegner")
df_ladybug$collector <- str_replace(df_ladybug$collector, "v. cervantes", "V. cervantes")
df_ladybug$collector <- str_replace(df_ladybug$collector, "Veronica Cervatnes", "V. cervantes")
df_ladybug$collector <- str_replace(df_ladybug$collector, "Veronica Cervantes", "V. cervantes")
df_ladybug$collector <- str_replace(df_ladybug$collector, "V. Cervantes", "V. cervantes")
df_ladybug$collector <- str_replace(df_ladybug$collector, "V. cervantes", "V. cervantes")
df_ladybug$collector <- str_replace(df_ladybug$collector, "V.Cervantes", "V. cervantes")
df_ladybug$collector <- str_replace(df_ladybug$collector, "v cervantes", "V. cervantes")
df_ladybug$collector <- str_replace(df_ladybug$collector, "J Hughes", "J. Hughes")
df_ladybug$collector <- str_replace(df_ladybug$collector, "Jack Hughes", "J. Hughes")
df_ladybug$collector <- str_replace(df_ladybug$collector, "j. Hughes", "J. Hughes")
df_ladybug$collector <- str_replace(df_ladybug$collector, "J. hughes", "J. Hughes")
df_ladybug$collector <- str_replace(df_ladybug$collector, "jack hughes", "J. Hughes")
df_ladybug$collector <- str_replace(df_ladybug$collector, "J. Hughees", "J. Hughes")
df_ladybug$collector <- str_replace(df_ladybug$collector, "j. hughes", "J. Hughes")
df_ladybug$collector <- str_replace(df_ladybug$collector, "Olivia Ruffatto", "O. Ruffatto")
df_ladybug$collector <- str_replace(df_ladybug$collector, "O. ruffatto", "O. Ruffatto")
df_ladybug$collector <- str_replace(df_ladybug$collector, "o. Ruffatto", "O. Ruffatto")
df_ladybug$collector <- str_replace(df_ladybug$collector, "Olivia ruffatto", "O. Ruffatto")
df_ladybug$collector <- str_replace(df_ladybug$collector, "o. ruffattto", "O. Ruffatto")
df_ladybug$collector <- str_replace(df_ladybug$collector, "o. ruffatto", "O. Ruffatto")
df_ladybug$collector <- str_replace(df_ladybug$collector, "OliviaRuffatto", "O. Ruffatto")

df_ladybug$Species <- str_replace(df_ladybug$Species, "Harminia axyridis", "Harmonia axyridis")
df_ladybug$Species <- str_replace(df_ladybug$Species, "Colemegilla maculata", "Coleomegilla maculata")
df_ladybug$Species <- str_replace(df_ladybug$Species, "coleomegilla maculata", "Coleomegilla maculata")
df_ladybug$Species <- str_replace(df_ladybug$Species, "Cycloneda munda", "Cycloneda Munda")
df_ladybug$Species <- str_replace(df_ladybug$Species, "cycloneda munda", "Cycloneda Munda")
df_ladybug$Species <- str_replace(df_ladybug$Species, "coccinella septempunctata", "Coccinella Septempunctata")
df_ladybug$Species <- str_replace(df_ladybug$Species, "Propylea quatuordecimpuncata", "Propylea quatuordecimpunctata")
df_ladybug$Species <- str_replace(df_ladybug$Species, "Harmonia axyrisis", "Harmonia axyridis")
df_ladybug$Species <- str_replace(df_ladybug$Species, "harmonia axyridis", "Harmonia axyridis")
df_ladybug$Species <- str_replace(df_ladybug$Species, "harmonia axyrids", "Harmonia axyridis")
df_ladybug$Species <- str_replace(df_ladybug$Species, "Coccinella septempunctata", "Coccinella Septempunctata")
df_ladybug$Species <- str_replace(df_ladybug$Species, "hippodamia parenthesis", "Hippodamia parenthesis")
df_ladybug$Species <- str_replace(df_ladybug$Species, "Hippodamia covergence", "Hippodamia convergens")
df_ladybug$Species <- str_replace(df_ladybug$Species, "hippodamia convergens", "Hippodamia convergens")
df_ladybug$Species <- str_replace(df_ladybug$Species, "Coccinella septempunctata", "Coccinella Septempunctata")
df_ladybug$Species <- str_replace(df_ladybug$Species, "Coccinella semtempuncata", "Coccinella Septempunctata")

#collector count
df_collector_amount <- df_ladybug %>%
  select(collector) %>%
  count(collector) %>%
  rename(Amount = n)%>%
  rename(Collector = collector)%>%
  drop_na() 

#collector plot for each
ggplot(data = df_collector_amount, aes(x = Amount, y= Collector, fill= Collector)) +
  geom_bar(stat="Identity")+
  xlab("Count") +
  ggtitle("                                        Count by Collector")

#species count
df_species_count <- df_ladybug %>%
  select(Species) %>%
  count(Species) %>%
  rename(Amount = n)

#Plot count for each species
ggplot(data = df_species_count, aes(x = Species, y= Amount, fill=Species)) +
  geom_bar(stat="identity")+
  xlab("Species")+
  ylab("Count")+
  ggtitle("                                                             Count by Species")+
  theme(axis.text.x = element_text(angle = 90))+
  theme(legend.position="none")

#collector for each species
df_collector_species <- df_ladybug %>%
  dplyr:: select(collector, Species) %>%
  group_by(collector)%>%
  drop_na()

#graph for collector each species
ggplot(data = df_collector_species, aes(x = collector, y= Species, fill= Species)) +
  geom_bar(position = "stack", stat="identity") +
  xlab("Collector") +
  ggtitle("         Collector and Species relationship") +
  theme(axis.text.x = element_text(angle = 90)) 


Date = df_ladybug$date
ggplot(df_ladybug, aes(Date)) +
  geom_bar(color = "purple", fill = "white")


date_table = table(Date)
View(date_table)

#Min, Median, Max amount caught within a day
least = names(date_table[date_table==min(date_table)]) #day with least caught
most = names(date_table[date_table==max(date_table)]) #day with most caught
middle = names(date_table[date_table==median(date_table)]) #day with middle amount caught


least
View(data.frame(least, middle, most))


#First day, middle day, and last day that a bug was caught
first_date = min(Date)
last_date = max(Date)
median_date = median(Date)

View(data.frame(first_date, median_date, last_date))


