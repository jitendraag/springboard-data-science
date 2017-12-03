# Loading libraries
library(dplyr)

# Reading CSV
input_df <- read.csv('./refine_original.csv')

# Finding out company misspellings
#input_df %>%
#  group_by(company) %>%
#  tally()

# Company name lower case and spelling mistake fixes
input_df <- input_df %>%
  mutate(company = tolower(company)) %>%
  mutate( company = gsub('phillips|phillips|fillips|phlips|phillps|phllips', 'philips', company)) %>% 
  mutate( company = gsub('akz0|ak zo', 'akzo', company)) %>% 
  mutate( company = gsub('unilver', 'unilever', company))

# Adding product code and number
input_df <- input_df %>%
  rename(product_code_number = Product.code...number) %>%
  separate(product_code_number, c("product_code", "product_number"), sep = "-")

# Adding full address and binary flags for company / product
input_df <- input_df %>%
  mutate(full_address = paste(address, city, country, sep=', ')) %>% 
  mutate (company_philips=ifelse(company=='philips', 1, 0)) %>%
  mutate (company_akzo=ifelse(company=='akzo', 1, 0)) %>% 
  mutate (company_van_houten=ifelse(company=='van houten', 1, 0)) %>% 
  mutate (company_unilever=ifelse(company=='unilever', 1, 0)) %>% 
  mutate (product_smartphone=ifelse(product_code=='p', 1, 0)) %>% 
  mutate (product_tv=ifelse(product_code=='v', 1, 0)) %>% 
  mutate (product_laptop=ifelse(product_code=='x', 1, 0)) %>% 
  mutate (product_tablet=ifelse(product_code=='q', 1, 0))

# Writing CSV
write.csv(input_df, "refine_clean.csv", row.names = FALSE)
