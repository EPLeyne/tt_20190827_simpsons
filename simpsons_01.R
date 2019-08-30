# Import the data

simpsons <- readr::read_delim("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-08-27/simpsons-guests.csv", delim = "|", quote = "")

# From Stephen P....
# Using this data, try any or all of the following:
#   1) Who has had the most guest appearances (and what character did they play)?
#   2) How many people have played themselves on the show (and who has done so the most)?
#   3) Make a plot showing the number of guest appearances per season.
#   4) Who has had the largest gap between guest appearances?

library(tidyverse)

# Tidy the data
#Separate the roles where an actor may have played more than 1 character
simpsons1 <-  simpsons %>% separate (role, sep = ';', remove = TRUE,
                       convert = FALSE, c('role1','role2','role3','role4')) %>% 
  gather ('role1','role2','role3','role4', key = 'role_no', value = 'role', na.rm = TRUE) %>% 
  unite ('ep_guest', 'production_code', 'guest_star', remove = FALSE) #Create a unique code for guest stars playing multiple roles in the same episode 

# Most guest appearances, ie. most number of episodes

simpsons2 <- simpsons1 %>% distinct(ep_guest, .keep_all = TRUE) %>% 
  count(guest_star, role, sort = TRUE)

