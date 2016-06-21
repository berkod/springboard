setwd('/Users/dberko/Documents/springboard/springboard/data-wrangling_exercise2')
library('tidyr')
library('dplyr')
titanic_df = read.csv('titanic_original.csv', header = TRUE)

# 1: Port of embarkation
titanic_df <-
  titanic_df  %>% mutate(embarked = ifelse(embarked == '', 'S', as.character.factor(embarked)))

# convert back to factor:
titanic_df <- titanic_df %>% mutate(embarked = factor(embarked))

# 2: Age
# You could do median, which in this case would be younger than the mean by almost two years
# You could also process the mean/media age by group: Identify families by last name/place of irigin

# TODO: IT's rounding the data
mean_age <- mean(titanic_df$age, na.rm=TRUE)
titanic_df <- titanic_df  %>% mutate(age = ifelse(is.na(age), mean_age, age))

# output cleaned file

write.csv(titanic_df, file = "refine_clean.csv")
