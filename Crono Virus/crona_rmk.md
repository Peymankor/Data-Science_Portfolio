gglot theme - Design Here, I design my style for ggplots and and could
use this one for stylying the plots in the rest.

    mytheme <- theme_dark() +
        theme(plot.title = element_text(color="black", size=14, face="bold.italic")) +
        theme(
          strip.text.x = element_text(
            size = 14, color = "orange", face = "bold.italic"
            ),
          strip.text.y = element_text(
            size = 14, color = "orange", face = "bold.italic"
            )
          ) +
        theme(panel.grid.major = element_line(colour = "black")) +                   
        theme(axis.text.x = element_text(face = "bold", color = "#993333",            
                                         size = 14, angle = 45, hjust = 1)) + 
        theme(axis.text.y = element_text(face = "bold", color = "#993333",            
                                         size = 14, hjust = 1)) +
        theme(legend.title=element_text(size=14)) +                                   
        theme(legend.text=element_text(size=14)) +                                       
        theme(axis.title.y.left = element_text(size=14)) +                            
        theme(axis.title.x.bottom = element_text(size=14))

Import Data
-----------

    data <- read.csv("2019_nCoV_20200121_20200131.csv")
    head(data)

    ##   Province.State Country.Region     Last.Update Confirmed Suspected Recovered
    ## 1          Hubei Mainland China 1/31/2020 19:00      7153        NA       169
    ## 2       Zhejiang Mainland China 1/31/2020 19:00       537        NA        14
    ## 3      Guangdong Mainland China 1/31/2020 19:00       436        NA        10
    ## 4          Henan Mainland China 1/31/2020 19:00       352        NA         3
    ## 5          Hunan Mainland China 1/31/2020 19:00       332        NA         3
    ## 6        Jiangxi Mainland China 1/31/2020 19:00       240        NA         7
    ##   Death
    ## 1   249
    ## 2    NA
    ## 3    NA
    ## 4     2
    ## 5    NA
    ## 6    NA

Looking on the data, two immdeiate poinst are:

-   The date column must be converted to the appropriate date type
-   NA values must be converted to zero, since we will make operations
    on the columns… (subject to arguement!)
-   Now, knowing the time scale, we use the myd\_hm from lubridate to
    convert the date column

<!-- -->

    data$time <-  mdy_hm(as.character(data$Last.Update))

    ## Warning: 27 failed to parse.

    tail(data)

    ##      Province.State Country.Region Last.Update Confirmed Suspected Recovered
    ## 1120      Hong Kong      Hong Kong   1/21/2020        NA       117        NA
    ## 1121   Heilongjiang Mainland China   1/21/2020        NA         1        NA
    ## 1122                         Japan   1/21/2020         1        NA        NA
    ## 1123                      Thailand   1/21/2020         2        NA        NA
    ## 1124                   South Korea   1/21/2020         1        NA        NA
    ## 1125     Washington  United States   1/21/2020         1        NA        NA
    ##      Death time
    ## 1120    NA <NA>
    ## 1121    NA <NA>
    ## 1122    NA <NA>
    ## 1123    NA <NA>
    ## 1124    NA <NA>
    ## 1125    NA <NA>

As we can see the 27 rows can failed in the parsing, the reason is the
type of the date column in the last 27 rows. We do the change and use
the mdy() for the last 27 rows.

    data$time[1099:1125] <- mdy(as.character(data$Last.Update[1099:1125]))
    tail(data)

    ##      Province.State Country.Region Last.Update Confirmed Suspected Recovered
    ## 1120      Hong Kong      Hong Kong   1/21/2020        NA       117        NA
    ## 1121   Heilongjiang Mainland China   1/21/2020        NA         1        NA
    ## 1122                         Japan   1/21/2020         1        NA        NA
    ## 1123                      Thailand   1/21/2020         2        NA        NA
    ## 1124                   South Korea   1/21/2020         1        NA        NA
    ## 1125     Washington  United States   1/21/2020         1        NA        NA
    ##      Death       time
    ## 1120    NA 2020-01-21
    ## 1121    NA 2020-01-21
    ## 1122    NA 2020-01-21
    ## 1123    NA 2020-01-21
    ## 1124    NA 2020-01-21
    ## 1125    NA 2020-01-21

    data_nao <- data %>% 
        replace_na(list(Confirmed = 0, Recovered = 0, Death=0))
    head(data_nao)

    ##   Province.State Country.Region     Last.Update Confirmed Suspected Recovered
    ## 1          Hubei Mainland China 1/31/2020 19:00      7153        NA       169
    ## 2       Zhejiang Mainland China 1/31/2020 19:00       537        NA        14
    ## 3      Guangdong Mainland China 1/31/2020 19:00       436        NA        10
    ## 4          Henan Mainland China 1/31/2020 19:00       352        NA         3
    ## 5          Hunan Mainland China 1/31/2020 19:00       332        NA         3
    ## 6        Jiangxi Mainland China 1/31/2020 19:00       240        NA         7
    ##   Death                time
    ## 1   249 2020-01-31 19:00:00
    ## 2     0 2020-01-31 19:00:00
    ## 3     0 2020-01-31 19:00:00
    ## 4     2 2020-01-31 19:00:00
    ## 5     0 2020-01-31 19:00:00
    ## 6     0 2020-01-31 19:00:00

Analysis the Data in Mainland of China:
---------------------------------------

Here, the goal is to find the what are the Death Rate and Recovery Rate
grouped by the Province in the Mainland of China. I used the pipeline
with the dplyr package, yet i provided the comment for explaining each
pipe:

    pd <- data_nao %>%
        filter(Country.Region == "Mainland China" | Country.Region == "China") %>%                        
        group_by(Province.State) %>%                                                                      
        filter(day(time) == 31 & hour(time) == 19) %>% 
        mutate(Recovery_Rate = Recovered*100/Confirmed, Death_Rate= Death*100/Confirmed ) %>% 
        filter(Recovery_Rate>0 & Death_Rate>0) %>% 
        select(Province.State,Recovery_Rate,Death_Rate) %>% 
        pivot_longer(.,-Province.State,                                      
                     names_to = "Situation", values_to = "Number") %>%        
        group_by(Situation) %>%                                                                           
        top_n(10, abs(Number)) %>%                                                                        
        ungroup() %>%                                                                                                                                                    
        arrange(Situation, Number) %>%                                                                 
        mutate(order = row_number())   

    ggplot(pd,aes(order, Number,fill = Situation)) +                                                        
        geom_bar(stat = "identity", show.legend = FALSE) +                                             
        facet_wrap(~ Situation, scales = "free") +                                                     
        xlab("China Province(State)") +
        ylab("Percentage (%)") + 
        ggtitle("Death Rate, Recovery Rate Mainland of ChinaData from 22 Jan til 31 Jan\nLeft: Death Rate 
    Right: Recovery Rate both in Percentage") +
        theme_bw() +
        scale_x_continuous(
            breaks = pd$order,
            labels = pd$Province.State,
            expand = c(0,0)
        ) +
        coord_flip() + mytheme +                                                                       
        scale_y_continuous(breaks = seq(from = 0, to = 5, by = 1))

![](crona_rmk_files/figure-markdown_strict/unnamed-chunk-7-1.png)

Now, in this part the goal is to see in which state, the number of
confirmed people are fastest growing:

    data_nao %>% 
        filter(Country.Region == "Mainland China" | Country.Region == "China") %>% 
        filter(Province.State != "Hubei") %>% 
        group_by(time,Province.State)  %>% 
        arrange(desc(Confirmed)) %>%
        filter(Confirmed>150) %>% 
        #head(100) %>%  
        ggplot(aes(x=as.POSIXct(time), y=Confirmed, color=Province.State)) +
        geom_line(size=3) +
        ggtitle("Growth in the Number of People Confirmed to CronaVirus") +
        mytheme + 
        scale_x_datetime('Date',
                         date_breaks = '8 hours',
                         date_labels = '%B:%d h:%H')

![](crona_rmk_files/figure-markdown_strict/unnamed-chunk-8-1.png)

Plot the Growth Rate Versus Days:¶
----------------------------------

    test <- data_nao %>% 
        filter(Country.Region == "Mainland China" | Country.Region == "China") %>% 
        filter(Province.State != "Hubei") %>%
        mutate(day= day(as.Date(time)), hr= hour(as.Date(time))) %>% 
        group_by(Province.State, day) %>%
        filter(Confirmed == max(Confirmed)) %>% 
        distinct(Confirmed) %>% 
        #group_by(day,Province.State)  %>% 
        arrange(desc(Confirmed)) %>%
        filter(Confirmed>100) 


    test %>%  
        ggplot(aes(x=day, y=Confirmed, color=Province.State)) +
        geom_line(size=2) +
        ggtitle("Growth in the Number of People Confirmed to CronaVirus") +
        mytheme  +
        scale_x_continuous(breaks = 21:31) +
        xlab("Days at January")

![](crona_rmk_files/figure-markdown_strict/unnamed-chunk-9-1.png)

Spatial Visualization
---------------------

Here, the goal is to plot the China map and have the number of confirmed
people as the points related to the state spatial location: Note: you
need to register your google platform code using the register\_google()

    register_google(key = "AIzaSyATZfUpRb4dxdQAMkBTEDSBjwOAybvkU50")
    map_china=get_map("China", zoom = 4,  maptype = "hybrid")

    ## Source : https://maps.googleapis.com/maps/api/staticmap?center=China&zoom=4&size=640x640&scale=2&maptype=hybrid&language=en-EN&key=xxx

    ## Source : https://maps.googleapis.com/maps/api/geocode/json?address=China&key=xxx

    options(repr.plot.width = 30, repr.plot.height = 14)
    ggmap(map_china, extent = "device")

![](crona_rmk_files/figure-markdown_strict/unnamed-chunk-10-1.png)

Here, number of the confirmed patients at the first day, 21 are reported
per state:

    head(cities_lan_lag)

    ## # A tibble: 6 x 2
    ##     lon   lat
    ##   <dbl> <dbl>
    ## 1  121.  31.2
    ## 2  101.  24.5
    ## 3  116.  39.9
    ## 4  121.  23.7
    ## 5  127.  43.8
    ## 6  103.  30.3

    data_nao_first_loc <- cbind(data_nao_first,cities_lan_lag)
    head(data_nao_first_loc)

    ##   Province.State Country.Region Last.Update Confirmed Suspected Recovered Death
    ## 1       Shanghai Mainland China   1/21/2020         9        10         0     0
    ## 2         Yunnan Mainland China   1/21/2020         1        NA         0     0
    ## 3        Beijing Mainland China   1/21/2020        10        NA         0     0
    ## 4         Taiwan         Taiwan   1/21/2020         1        NA         0     0
    ## 5          Jilin Mainland China   1/21/2020         0         1         0     0
    ## 6        Sichuan Mainland China   1/21/2020         2         1         0     0
    ##         time      lon      lat
    ## 1 2020-01-21 121.4737 31.23042
    ## 2 2020-01-21 101.3431 24.47528
    ## 3 2020-01-21 116.4074 39.90420
    ## 4 2020-01-21 120.9605 23.69781
    ## 5 2020-01-21 126.5496 43.83788
    ## 6 2020-01-21 102.8055 30.26380

    p1 <- ggmap(map_china, extent = "device") +
        geom_point(data = data_nao_first_loc, aes(x =lon, y= lat,size = Confirmed), alpha=1, color='red') +
    ggtitle("Number of patients Confirmed as having the Diseas on 21 January")
    p1

![](crona_rmk_files/figure-markdown_strict/unnamed-chunk-14-1.png)

    data_nao_last <-  data_nao %>% 
        filter(Country.Region=="Mainland China" | Country.Region=="China" | Country.Region=="Taiwan")  %>% 
        filter(day(time) == 31 & hour(time) == 19) %>% 
        group_by(Province.State) 
    #cities_lan_lag_last <- geocode(as.character(data_nao_last$Province.State))
    head(data_nao_last)

    ## # A tibble: 6 x 8
    ## # Groups:   Province.State [6]
    ##   Province.State Country.Region Last.Update Confirmed Suspected Recovered Death
    ##   <fct>          <fct>          <fct>           <dbl>     <int>     <dbl> <dbl>
    ## 1 Hubei          Mainland China 1/31/2020 …      7153        NA       169   249
    ## 2 Zhejiang       Mainland China 1/31/2020 …       537        NA        14     0
    ## 3 Guangdong      Mainland China 1/31/2020 …       436        NA        10     0
    ## 4 Henan          Mainland China 1/31/2020 …       352        NA         3     2
    ## 5 Hunan          Mainland China 1/31/2020 …       332        NA         3     0
    ## 6 Jiangxi        Mainland China 1/31/2020 …       240        NA         7     0
    ## # … with 1 more variable: time <dttm>

    head(data_nao_last)

    ## # A tibble: 6 x 10
    ## # Groups:   Province.State [6]
    ##   Province.State Country.Region Last.Update Confirmed Suspected Recovered Death
    ##   <fct>          <fct>          <fct>           <dbl>     <int>     <dbl> <dbl>
    ## 1 Hubei          Mainland China 1/31/2020 …      7153        NA       169   249
    ## 2 Zhejiang       Mainland China 1/31/2020 …       537        NA        14     0
    ## 3 Guangdong      Mainland China 1/31/2020 …       436        NA        10     0
    ## 4 Henan          Mainland China 1/31/2020 …       352        NA         3     2
    ## 5 Hunan          Mainland China 1/31/2020 …       332        NA         3     0
    ## 6 Jiangxi        Mainland China 1/31/2020 …       240        NA         7     0
    ## # … with 3 more variables: time <dttm>, lon <dbl>, lat <dbl>

    p2 <- ggmap(map_china, extent = "device") +
        geom_point(data = data_nao_last, aes(x =lon, y= lat,size = Confirmed), alpha=2, color='blue') +
        ggtitle("Number of patients Confirmed as having the Diseas on 31 January")

    p2

![](crona_rmk_files/figure-markdown_strict/unnamed-chunk-18-1.png)

    p1 | p2

![](crona_rmk_files/figure-markdown_strict/unnamed-chunk-19-1.png)

Numbers of New Countries Receiving the Virus over the Days:
===========================================================

    uniqu_con <- data_nao %>% 
        mutate(day = format(time, "%d")) %>% 
        group_by(day) %>% 
        distinct(Country.Region) %>% 
        group_by(day,Country.Region) %>% 
        tally

    dim(uniqu_con)

    ## [1] 178   3

    head(uniqu_con)

    ## # A tibble: 6 x 3
    ## # Groups:   day [1]
    ##   day   Country.Region     n
    ##   <chr> <fct>          <int>
    ## 1 21    Hong Kong          1
    ## 2 21    Japan              1
    ## 3 21    Mainland China     1
    ## 4 21    South Korea        1
    ## 5 21    Taiwan             1
    ## 6 21    Thailand           1

    countries <- c("")
    unique_con_df <- as.data.frame(uniqu_con)
    non_uniqu_con <- rep(0, 178)
    for (i in 1:178) {
        if (!(unique_con_df[i,2] %in% countries)) {
            non_uniqu_con[i] <- 1
            countries <- c(countries,as.character(unique_con_df[i,2]))
        } 
        
    }
    uniqu_con$new <- non_uniqu_con
    head(uniqu_con)

    ## # A tibble: 6 x 4
    ## # Groups:   day [1]
    ##   day   Country.Region     n   new
    ##   <chr> <fct>          <int> <dbl>
    ## 1 21    Hong Kong          1     1
    ## 2 21    Japan              1     1
    ## 3 21    Mainland China     1     1
    ## 4 21    South Korea        1     1
    ## 5 21    Taiwan             1     1
    ## 6 21    Thailand           1     1

    uniqu_con %>% 
        group_by(day) %>% 
        summarize(total=sum(new))  %>% 
        ggplot(aes(day,total)) +
        geom_bar(stat = "identity", fill='blue') +
        ylab("New Countries having Confirmed the Crona") +
        xlab("Days of January") +
        ggtitle("Number of New Countries added to having the Crona Virus") +
        mytheme

![](crona_rmk_files/figure-markdown_strict/unnamed-chunk-23-1.png)

    map_world=get_map("World", zoom = 1)

    ## Source : https://maps.googleapis.com/maps/api/staticmap?center=World&zoom=1&size=640x640&scale=2&maptype=terrain&language=en-EN&key=xxx

    ## Source : https://maps.googleapis.com/maps/api/geocode/json?address=World&key=xxx

    ggmap(map_world, extent = "device")

![](crona_rmk_files/figure-markdown_strict/unnamed-chunk-24-1.png)

    ggmap(map_world, extent = "device") +
        geom_point(data = countries_world_loc, aes(x =lon, y= lat,size = Confirmed), alpha=2, color='red')

![](crona_rmk_files/figure-markdown_strict/unnamed-chunk-26-1.png)
