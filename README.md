
# qApiTools

<!-- badges: start -->
<!-- badges: end -->

The goal of qApiTools is to interface with APIs the GOI team use and get out tibbles for use in downstream analysis. At the moment, it only works for one API, although it may be extended in future.

## Installation

qApiTools isn't available in CRAN, and will never be. You can install it using the following:

``` r
install_github("goiops/qApiTools")

```

## Example

qApiTools has one (1) function:

``` r
library(qApiTools)
## Get a tibble
df <- qApiTools::api_call_df(start_date_txt = "1900-01-01", 
  end_date_txt = "1900-01-01", 
  api_key = "some-api-key-here", 
  root = "https://www.somewebsite.com", 
  path = "/path/path1/v1")

```

