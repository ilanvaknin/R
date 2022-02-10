library(dslabs)
data("research_funding_rates")
research_funding_rates

totals<-research_funding_rates %>%
  select(-discipline) %>%
  summarize_all(list(sum)) %>%
  summarize(yes_men=awards_men,
            no_men=applications_men - awards_men,
            yes_women=awards_women,
            no_women=applications_women - awards_women)

totals %>% summarize(percent_men=yes_men/(yes_men+no_men),
                     percent_women=yes_women/(yes_women+no_women))


tab<-matrix(c(3,1,1,3),2,2)
rownames(tab)<-c("Poured before","Poured after")
colnames(tab)<-c("Guessed before","Guessed after")
tab

# use hypergeometric distrubution
fisher.test(tab, alternative = "greater")

#chi-squared
funding_rate<-totals %>%
  summarize(percent_total=(yes_men+yes_women)/
              (yes_men+no_men+yes_women+no_women))%>%
  .$percent_total
funding_rate

two_by_two <- tibble(awarded=c("no","yes"),
                     men=c(totals$no_men, totals$yes_men),
                     women=c(totals$no_women, totals$yes_women))
two_by_two

tibble(awarded=c("no","yes"),
       men=(totals$no_men+totals$yes_men)*c(1-funding_rate, funding_rate),
       women=(totals$no_women+totals$yes_women)*c(1-funding_rate, funding_rate)) 

two_by_two %>%
    select(-awarded)%>%
    chisq.test()

#summary statistics
odds_men<-(two_by_two$men[2]/sum(two_by_two$men))/
            (two_by_two$men[1]/sum(two_by_two$men))

odds_women<-(two_by_two$women[2]/sum(two_by_two$women))/
  (two_by_two$women[1]/sum(two_by_two$women))

odds_men/odds_women

# Notice caution on p_value
two_by_two %>%
  select(-awarded)%>%
  mutate(men=men*10, women=women*10) %>%
  chisq.test()

#exercise
# The 'errors' data have already been loaded. Examine them using the `head` function.
head(errors)

# Generate an object called 'totals' that contains the numbers of good and bad predictions for polls rated A- and C-
totals <- errors %>% filter(grade %in% c("A-","C-")) %>%
  group_by(grade)%>%
  summarize(hit=sum(hit), missed=n()-sum(hit))

# Print the proportion of hits for grade A- polls to the console
grade_A <- totals %>% filter(grade=="A-")
grade_A$hit/(grade_A$hit+grade_A$missed)

# Print the proportion of hits for grade C- polls to the console
grade_C <- totals %>% filter(grade=="C-")
grade_C$hit/(grade_C$hit+grade_C$missed)

# The 'totals' data have already been loaded. Examine them using the `head` function.
head(totals)

# Perform a chi-squared test on the hit data. Save the results as an object called 'chisq_test'.
chisq_test <- totals %>% select(-hit) %>%
  chisq.test()

# Print the p-value of the chi-squared test to the console
chisq_test$p.value

# The 'totals' data have already been loaded. Examine them using the `head` function.
head(totals)

# Generate a variable called `odds_C` that contains the odds of getting the prediction right for grade C- polls
odds_C <- (totals$"C-"[2]/sum(totals$"C-"))/
  (totals$"C-"[1]/sum(totals$"C-"))

# Generate a variable called `odds_A` that contains the odds of getting the prediction right for grade A- polls
odds_A <- (totals$"A-"[2]/sum(totals$"A-"))/
  (totals$"A-"[1]/sum(totals$"A-"))

# Calculate the odds ratio to determine how many times larger the odds ratio is for grade A- polls than grade C- polls
odds_A/odds_C
