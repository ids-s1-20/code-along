Lending Club Loans
================

## Prepare and peek at the data

``` r
loans <- loans_full_schema %>%
  mutate(
    credit_util = total_credit_utilized / total_credit_limit,
    bankruptcy  = as.factor(if_else(public_record_bankrupt == 0, 0, 1)),
    verified_income = droplevels(verified_income)
    ) %>%
  rename(credit_checks = inquiries_last_12m) %>%
  select(interest_rate, verified_income, debt_to_income, credit_util, 
         bankruptcy, term, credit_checks, issue_month) 
```

``` r
glimpse(loans)
```

    ## Rows: 10,000
    ## Columns: 8
    ## $ interest_rate   <dbl> 14.07, 12.61, 17.09, 6.72, 14.07, 6.72, 13.59, 11.99,…
    ## $ verified_income <fct> Verified, Not Verified, Source Verified, Not Verified…
    ## $ debt_to_income  <dbl> 18.01, 5.04, 21.15, 10.16, 57.96, 6.46, 23.66, 16.19,…
    ## $ credit_util     <dbl> 0.54759517, 0.15003472, 0.66134832, 0.19673228, 0.754…
    ## $ bankruptcy      <fct> 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0,…
    ## $ term            <dbl> 60, 36, 36, 36, 36, 36, 60, 60, 36, 36, 60, 60, 36, 6…
    ## $ credit_checks   <int> 6, 1, 4, 0, 7, 6, 1, 1, 3, 0, 4, 4, 8, 6, 0, 0, 4, 6,…
    ## $ issue_month     <fct> Mar-2018, Feb-2018, Feb-2018, Jan-2018, Mar-2018, Jan…

## Explore

## Interest rate vs. bankruptcy

``` r
linear_reg() %>%                                # specify: what model will we fit?
  set_engine("lm") %>%                          # set engine : how will we fit the model?
  fit(interest_rate ~ bankruptcy, data = loans) # fit: actually fit model based on formula
```

    ## parsnip model object
    ## 
    ## Fit time:  9ms 
    ## 
    ## Call:
    ## stats::lm(formula = interest_rate ~ bankruptcy, data = data)
    ## 
    ## Coefficients:
    ## (Intercept)  bankruptcy1  
    ##     12.3380       0.7368

``` r
rate_bank_fit <- linear_reg() %>%
  set_engine("lm") %>%
  fit(interest_rate ~ bankruptcy, data = loans)
```

``` r
rate_bank_fit
```

    ## parsnip model object
    ## 
    ## Fit time:  3ms 
    ## 
    ## Call:
    ## stats::lm(formula = interest_rate ~ bankruptcy, data = data)
    ## 
    ## Coefficients:
    ## (Intercept)  bankruptcy1  
    ##     12.3380       0.7368

``` r
names(rate_bank_fit)
```

    ## [1] "lvl"     "spec"    "fit"     "preproc" "elapsed"

``` r
rate_bank_fit$fit
```

    ## 
    ## Call:
    ## stats::lm(formula = interest_rate ~ bankruptcy, data = data)
    ## 
    ## Coefficients:
    ## (Intercept)  bankruptcy1  
    ##     12.3380       0.7368

``` r
rate_bank_fit$elapsed
```

    ##    user  system elapsed 
    ##   0.003   0.001   0.003

``` r
tidy(rate_bank_fit)
```

    ## # A tibble: 2 x 5
    ##   term        estimate std.error statistic    p.value
    ##   <chr>          <dbl>     <dbl>     <dbl>      <dbl>
    ## 1 (Intercept)   12.3      0.0533    231.   0         
    ## 2 bankruptcy1    0.737    0.153       4.82 0.00000147

``` r
glance(rate_bank_fit)
```

    ## # A tibble: 1 x 12
    ##   r.squared adj.r.squared sigma statistic p.value    df  logLik    AIC    BIC
    ##       <dbl>         <dbl> <dbl>     <dbl>   <dbl> <dbl>   <dbl>  <dbl>  <dbl>
    ## 1   0.00232       0.00222  5.00      23.2 1.47e-6     1 -30274. 60554. 60575.
    ## # … with 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>

``` r
augment(rate_bank_fit$fit)
```

    ## # A tibble: 10,000 x 8
    ##    interest_rate bankruptcy .fitted .resid .std.resid     .hat .sigma    .cooksd
    ##            <dbl> <fct>        <dbl>  <dbl>      <dbl>    <dbl>  <dbl>      <dbl>
    ##  1         14.1  0             12.3  1.73      0.347  0.000114   5.00    6.84e-6
    ##  2         12.6  1             13.1 -0.465    -0.0931 0.000823   5.00    3.57e-6
    ##  3         17.1  0             12.3  4.75      0.951  0.000114   5.00    5.15e-5
    ##  4          6.72 0             12.3 -5.62     -1.12   0.000114   5.00    7.20e-5
    ##  5         14.1  0             12.3  1.73      0.347  0.000114   5.00    6.84e-6
    ##  6          6.72 0             12.3 -5.62     -1.12   0.000114   5.00    7.20e-5
    ##  7         13.6  0             12.3  1.25      0.251  0.000114   5.00    3.58e-6
    ##  8         12.0  0             12.3 -0.348    -0.0697 0.000114   5.00    2.76e-7
    ##  9         13.6  0             12.3  1.25      0.251  0.000114   5.00    3.58e-6
    ## 10          6.71 0             12.3 -5.63     -1.13   0.000114   5.00    7.23e-5
    ## # … with 9,990 more rows

## Interest rate vs. debt to income ratio

``` r
rate_dti_fit <- linear_reg() %>%
  set_engine("lm") %>%
  fit(interest_rate ~ debt_to_income, data = loans)
```

## Interest rate vs. everything
