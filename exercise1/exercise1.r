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
data <- left_join(data, product_df, by = 'product_code')

# 4: Add full address for geocoding
data <-
  unite(data,
        'full_address',
        address:country,
        sep = ',',
        remove = FALSE) %>% mutate()

# 5: Create dummy variables for company and product category
data <-
  data %>% mutate(
    company_philips = ifelse(company == 'philips', 1, 0),
    company_akzo = ifelse(company == 'akzo', 1, 0),
    company_van_houten = ifelse(company == 'van houten', 1, 0),
    company_unilever = ifelse(company == 'unilever', 1, 0)
  )

data <-
  data %>% mutate(
    product_smartphone = ifelse(product_name == 'Smartphone', 1, 0),
    product_tv = ifelse(product_name == 'TV', 1, 0),
    product_laptop = ifelse(product_name == 'Laptop', 1, 0),
    product_tablet = ifelse(product_name == 'Tablet', 1, 0)
  )

# output cleaned file

write.csv(final_data, file = "refine_clean.csv")
