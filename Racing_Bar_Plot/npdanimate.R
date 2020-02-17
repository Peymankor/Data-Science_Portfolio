
################################Installing Packages###########################################

##############################################################################################
#install.packages(c('gganimate','tidyverse','gifski','png'))
library(tidyverse)
library(gganimate)
library(gifski)
library(png)


################################ Importing Dataset ############################################

##############################################################################################

DATA_NPD <- read.csv('NPD.csv')


################################Transforming DATAset to "rank_by_year"########################

##############################################################################################

DATA_NPD %>% 
  select(Field,Year,oil_pro_num_n) %>% 
  group_by(Year) %>% 
  arrange(Year,-oil_pro_num_n) %>% 
  mutate(rank=1:n()) %>% 
  filter(rank<=10) ->
rank_by_year


################################ Building the Theme ##########################################

##############################################################################################


my_theme <- theme_classic(base_family = "Times") +
  theme(axis.text.y = element_blank()) +
  theme(axis.ticks.y = element_blank()) +
  theme(axis.line.y = element_blank()) +
  theme(legend.background = element_rect(fill = "linen")) +
  theme(plot.background = element_rect(fill = "linen")) +
  theme(panel.background = element_rect(fill = "linen")) +
  theme(plot.title = element_text(size = rel(3))) +
  theme(axis.text = element_text(size = rel(2))) +
  theme(legend.text = element_text(size = rel(4)))



################################gganimate Part################################################

##############################################################################################

ggplot(data = rank_by_year) +
  aes(group=Field,fill=Field) +
  aes(xmin = 0 , 
      xmax = oil_pro_num_n/1) +
  aes(ymin = rank - .45, 
      ymax = rank + .45) +
  scale_y_reverse() +
  scale_x_continuous(
    limits = c(-15, 40),
    breaks = c(0,10, 20, 30, 40),
    labels = c(0,10, 20, 30, 40)) +
  labs(fill = "") +
  geom_rect(alpha = .7,show.legend = F) +
  labs(x = 'Yearly Oil Production, (Sm3,mill)') +
  aes(label = Field, y = rank) +
  geom_text(col = "grey18", 
            hjust = "right", 
            x = -3,size = 5 ) +
  labs(y = "") +
  geom_text(x = 30 , y = -8,
            family = "Times",
            aes(label = as.character(Year)),
            size = 20, col = "grey18") +
  labs(caption = "(Based on data from NPD FactPages: npdfactpages.npd.no)") +
  labs(title=" Top 10 Oil Field Producers in NCS, 1971-2018") +
  my_theme->   
g


################################Setting + Saving Animationt###################################

##############################################################################################


options(gganimate.nframes = 500)
animate <- g + gganimate::transition_time(Year)  
animate(
  animate + enter_fade(), duration = 40, 
  renderer = av_renderer()
)

anim_save('NPDdata_test.mp4') 

