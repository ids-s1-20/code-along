College tuition, diversity, and pay
================
2020-10-08

    library(tidyverse)
    library(skimr)
    library(knitr)    # for the kable() function

The data come from
[TidyTuesday](https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-09-29/readme.md).
TidyTuesday is a weekly social data project for the R community. Read
more about TidyTuesday
[here](https://github.com/rfordatascience/tidytuesday) and see people’s
contributions on Twitter under the [\#tidytuesday
hashtag](https://twitter.com/search?q=tidytuesday&src=typed_query).

    tuition_cost <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/tuition_cost.csv')
    tuition_income <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/tuition_income.csv') 
    salary_potential <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/salary_potential.csv')
    historical_tuition <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/historical_tuition.csv')
    diversity_school <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/diversity_school.csv')

Data overview
-------------

    skim(tuition_cost)

|                                                  |               |
|:-------------------------------------------------|:--------------|
| Name                                             | tuition\_cost |
| Number of rows                                   | 2973          |
| Number of columns                                | 10            |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |               |
| Column type frequency:                           |               |
| character                                        | 5             |
| numeric                                          | 5             |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |               |
| Group variables                                  | None          |

Data summary

**Variable type: character**

| skim\_variable | n\_missing | complete\_rate | min | max | empty | n\_unique | whitespace |
|:---------------|-----------:|---------------:|----:|----:|------:|----------:|-----------:|
| name           |          0 |           1.00 |   8 |  67 |     0 |      2938 |          0 |
| state          |         52 |           0.98 |   4 |  14 |     0 |        50 |          0 |
| state\_code    |          0 |           1.00 |   2 |   2 |     0 |        55 |          0 |
| type           |          0 |           1.00 |   5 |  10 |     0 |         4 |          0 |
| degree\_length |          0 |           1.00 |   5 |   6 |     0 |         3 |          0 |

**Variable type: numeric**

| skim\_variable          | n\_missing | complete\_rate |     mean |       sd |   p0 |   p25 |   p50 |     p75 |  p100 | hist  |
|:------------------------|-----------:|---------------:|---------:|---------:|-----:|------:|------:|--------:|------:|:------|
| room\_and\_board        |       1094 |           0.63 | 10095.28 |  3288.55 |   30 |  7935 | 10000 | 12424.5 | 21300 | ▁▅▇▃▁ |
| in\_state\_tuition      |          0 |           1.00 | 16491.29 | 14773.84 |  480 |  4890 | 10099 | 27124.0 | 59985 | ▇▂▂▁▁ |
| in\_state\_total        |          0 |           1.00 | 22871.73 | 18948.39 |  962 |  5802 | 17669 | 35960.0 | 75003 | ▇▅▂▂▁ |
| out\_of\_state\_tuition |          0 |           1.00 | 20532.73 | 13255.65 |  480 |  9552 | 17486 | 29208.0 | 59985 | ▇▆▅▂▁ |
| out\_of\_state\_total   |          0 |           1.00 | 26913.16 | 17719.73 | 1376 | 11196 | 23214 | 39054.0 | 75003 | ▇▅▅▂▁ |

Summaries
---------

    tuition_cost %>%
      summarise(
        mean_in_state_total = mean(in_state_total),
        mean_out_of_state_total = mean(out_of_state_total)
      )

    ## # A tibble: 1 x 2
    ##   mean_in_state_total mean_out_of_state_total
    ##                 <dbl>                   <dbl>
    ## 1              22872.                  26913.

    tuition_cost %>%
      arrange(desc(out_of_state_total)) %>%
      select(name, out_of_state_total, room_and_board)

    ## # A tibble: 2,973 x 3
    ##    name                                         out_of_state_tot… room_and_board
    ##    <chr>                                                    <dbl>          <dbl>
    ##  1 Harvey Mudd College                                      75003          18127
    ##  2 University of Chicago                                    74580          16350
    ##  3 Columbia University                                      74001          14016
    ##  4 Barnard College                                          72257          17225
    ##  5 Scripps College                                          71956          16932
    ##  6 Columbia University: School of General Stud…             71739          14190
    ##  7 Trinity College                                          71660          14750
    ##  8 University of Southern California                        71620          15395
    ##  9 Oberlin College                                          71392          16338
    ## 10 Southern Methodist University                            71338          16845
    ## # … with 2,963 more rows

    tuition_cost %>%
      group_by(state) %>%
      summarise(mean_out_of_state_total = mean(out_of_state_total)) %>%
      arrange(desc(mean_out_of_state_total))

    ## `summarise()` ungrouping output (override with `.groups` argument)

    ## # A tibble: 51 x 2
    ##    state         mean_out_of_state_total
    ##    <chr>                           <dbl>
    ##  1 Rhode Island                   49440.
    ##  2 Vermont                        45568.
    ##  3 Massachusetts                  44581.
    ##  4 Pennsylvania                   37210.
    ##  5 Connecticut                    34233.
    ##  6 New York                       34149 
    ##  7 New Hampshire                  34125.
    ##  8 Maine                          32024.
    ##  9 Indiana                        31001.
    ## 10 Oregon                         30976.
    ## # … with 41 more rows

    tuition_cost %>%
      filter(state == "Rhode Island") %>%
      select(name, type, out_of_state_total)

    ## # A tibble: 11 x 3
    ##    name                                   type    out_of_state_total
    ##    <chr>                                  <chr>                <dbl>
    ##  1 Brown University                       Private              70326
    ##  2 Bryant University                      Private              59675
    ##  3 Community College of Rhode Island      Public               12156
    ##  4 Johnson & Wales University: Providence Private              46428
    ##  5 New England Institute of Technology    Private              43005
    ##  6 Providence College                     Private              65090
    ##  7 Rhode Island College                   Public               33521
    ##  8 Rhode Island School of Design          Private              64360
    ##  9 Roger Williams University              Private              50412
    ## 10 Salve Regina University                Private              55050
    ## 11 University of Rhode Island             Public               43812

    state_freq_table <- tuition_cost %>%
      count(state, sort = TRUE)

    tuition_cost %>%
      filter(state == "Montana")

    ## # A tibble: 22 x 10
    ##    name  state state_code type  degree_length room_and_board in_state_tuition
    ##    <chr> <chr> <chr>      <chr> <chr>                  <dbl>            <dbl>
    ##  1 Aani… Mont… MT         Publ… 2 Year                    NA             2380
    ##  2 Blac… Mont… MT         Publ… 2 Year                  6787             3590
    ##  3 Carr… Mont… MT         Priv… 4 Year                  9880            35486
    ##  4 Chie… Mont… MT         Publ… 2 Year                    NA             2260
    ##  5 Daws… Mont… MT         Publ… 2 Year                  6075             3720
    ##  6 Flat… Mont… MT         Publ… 2 Year                    NA             4638
    ##  7 Fort… Mont… MT         Publ… 2 Year                  6075             2520
    ##  8 Grea… Mont… MT         Publ… 2 Year                    NA             3386
    ##  9 Hele… Mont… MT         Publ… 2 Year                    NA             3349
    ## 10 Litt… Mont… MT         Priv… 2 Year                    NA             3200
    ## # … with 12 more rows, and 3 more variables: in_state_total <dbl>,
    ## #   out_of_state_tuition <dbl>, out_of_state_total <dbl>

    tuition_cost %>%
      arrange(desc(name))

    ## # A tibble: 2,973 x 10
    ##    name  state state_code type  degree_length room_and_board in_state_tuition
    ##    <chr> <chr> <chr>      <chr> <chr>                  <dbl>            <dbl>
    ##  1 Zane… Ohio  OH         Publ… 2 Year                    NA             5070
    ##  2 Yuba… Cali… CA         Publ… 2 Year                    NA             1400
    ##  3 Youn… Ohio  OH         Publ… 4 Year                  9400             8950
    ##  4 Youn… Geor… GA         Priv… 4 Year                 12372            29117
    ##  5 York… Sout… SC         Publ… 2 Year                    NA             5740
    ##  6 York… Maine ME         Publ… 2 Year                    NA             3630
    ##  7 York… Penn… PA         Priv… 4 Year                 11200            20100
    ##  8 York… Nebr… NE         Priv… 4 Year                  7220            19310
    ##  9 Yesh… New … NY         Priv… 4 Year                  4050            10000
    ## 10 Yesh… Penn… PA         Priv… 4 Year                  3400             9000
    ## # … with 2,963 more rows, and 3 more variables: in_state_total <dbl>,
    ## #   out_of_state_tuition <dbl>, out_of_state_total <dbl>

    tuition_cost_fl <- tuition_cost %>%
      filter(state == "Florida")

    tuition_cost_fl %>%
      summarise(mean_out_of_state_total = mean(out_of_state_total))

    ## # A tibble: 1 x 1
    ##   mean_out_of_state_total
    ##                     <dbl>
    ## 1                  25636.

    tuition_cost %>%
      group_by(state) %>%
      summarise(freq = n())

    ## `summarise()` ungrouping output (override with `.groups` argument)

    ## # A tibble: 51 x 2
    ##    state        freq
    ##    <chr>       <int>
    ##  1 Alabama        54
    ##  2 Alaska          6
    ##  3 Arizona        34
    ##  4 Arkansas       46
    ##  5 California    254
    ##  6 Colorado       38
    ##  7 Connecticut    36
    ##  8 Delaware        9
    ##  9 Florida        88
    ## 10 Georgia        79
    ## # … with 41 more rows

`group_by`
----------

    tuition_cost %>%
      filter(type != "Other") %>%
      group_by(type) %>%
      summarise(
        mean_room_and_board = mean(room_and_board, na.rm = TRUE),
        sd_room_and_board = sd(room_and_board, na.rm = TRUE),
        n = n()
        ) %>%
      kable()

    ## `summarise()` ungrouping output (override with `.groups` argument)

| type       | mean\_room\_and\_board | sd\_room\_and\_board |    n |
|:-----------|-----------------------:|---------------------:|-----:|
| For Profit |              10596.952 |             4201.128 |  107 |
| Private    |              10700.536 |             3334.216 | 1281 |
| Public     |               9189.084 |             2974.064 | 1584 |

    tuition_cost %>%
      filter(type != "Other") %>%
      group_by(type, state) %>%
      summarise(
        mean_room_and_board = mean(room_and_board, na.rm = TRUE),
        sd_room_and_board = sd(room_and_board, na.rm = TRUE),
        n = n()
        )

    ## `summarise()` regrouping output by 'type' (override with `.groups` argument)

    ## # A tibble: 132 x 5
    ## # Groups:   type [3]
    ##    type       state       mean_room_and_board sd_room_and_board     n
    ##    <chr>      <chr>                     <dbl>             <dbl> <int>
    ##  1 For Profit Alabama                     NaN               NA      1
    ##  2 For Profit Arizona                   10514              585.     4
    ##  3 For Profit Arkansas                    NaN               NA      1
    ##  4 For Profit California                13824             3994.    15
    ##  5 For Profit Colorado                    NaN               NA      3
    ##  6 For Profit Connecticut               11600               NA      2
    ##  7 For Profit Florida                     NaN               NA      6
    ##  8 For Profit Georgia                     NaN               NA      2
    ##  9 For Profit Illinois                  12402               NA      3
    ## 10 For Profit Indiana                     NaN               NA      1
    ## # … with 122 more rows
