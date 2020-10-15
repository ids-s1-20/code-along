A sample R Markdown document
================

## Show / hide code, messages, warnings

``` r
library(tidyverse)
```

``` r
ggplot(mpg, aes(x = hwy)) +
  geom_histogram(binwidth = 3)
```

![](sample_files/figure-gfm/hwy-hist-1.png)<!-- -->

## Sizing plots

You can also embed plots, for example:

``` r
ggplot(mpg, aes(x = hwy)) +
  geom_histogram(binwidth = 3) +
  facet_wrap(~manufacturer, ncol = 1)
```

![](sample_files/figure-gfm/hwy-hist-facet-1.png)<!-- -->

## Asking good questions

``` r
kjashkjahzxmnb

mpg %>%
  filter(cyl > 4) %>%
  ggplot(mpg, aes(x = hwy)) +
  geom_histogram(binwidth = 2.5)
```
