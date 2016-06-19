setwd('/Users/dberko/Documents/springboard/springboard/exercise1')
library('tidyr')
library('dplyr')
data = read.csv('refine_original.csv', header = TRUE)
# 1. standardize company name
data$company <- data$company  %>% tolower()

for (i in 1:length(data$company)) {
  if (startsWith(data$company[i], 'a')) {
    data$company[i] = 'akzo'
  } else if (startsWith(data$company[i], 'u')) {
    data$company[i] = 'unilever'
  } else if (startsWith(data$company[i], 'p') |
             startsWith(data$company[i], 'f')) {
    data$company[i] = 'philips'
  }
}

# 2: Separate product code and number
data <-
  tidyr::separate(data,
                  'Product.code...number',
                  c('product_code', 'product_number'),
                  sep = '-')

# 3: Add product categories
product_df <-
  data.frame(
    product_name = c("Smartphone", "TV", "Laptop", "Tablet"),
    product_code = c("p", "v", "x", "q")
  )
data <- left_join(data, product_df, by ='product_code')
