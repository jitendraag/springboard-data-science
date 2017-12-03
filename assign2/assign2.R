titanic <- read.csv('~/springboard-data-science/assign2/titanic3.csv')
titanic <- tbl_df(titanic)

titanic <- titanic %>% mutate(embarked = gsub('^$', 'S', x=embarked))
titanic <- titanic %>% mutate(age = funs(replace(age, is.na(age), mean_age)))
titanic <- titanic %>% mutate(boat = replace(boat, boat == '', NA))
titanic <- titanic %>% mutate(has_cabin_number = ifelse(as.character(cabin) == '', yes = 0, no = 1))
write.csv('titanic_clean.csv', x = titanic, row.names = FALSE)