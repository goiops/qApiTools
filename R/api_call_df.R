#'
#' API Call (dataframe)
#'
#' Make sequential calls on an API, one day at a time, and return a concatenated tibble
#'
#' The only useful external function - this wraps up all the others to sequentially issue
#' requests against an API one day at a time, since they may overflow if you do more than
#' that.
#'
#' @param start_date_txt A character, indicating the start date for the data required
#' @param end_date_txtA character, indicating the end date for the data required
#' @param api_key a character, the bearer token provided to access the API. Provided by end user.
#' @param root A character, as the root path of the API endpoint - usually some kind of http://www.qqq.com/
#' @param path A character, as the specific path of the API - i.e. "api/myapi/v1/apione"
#'
#' @examples
#' \dontrun{
#' api_key <- "xxxxx-xxxx-xxxx-xxx-xxxx"
#' root_path <- "http://www.qqq.com/"
#' specific_path <- "api/myapi/v1/apione"
#'
#' start_date <- "2020-06-01"
#' end_date <- "2020-06-12"
#'
#' df <- api_call_df(start_date_txt = start_date,
#'                   end_date_txt = end_date,
#'                   api_key = api_key,
#'                   root = root_path,
#'                   path = specific_path)
#' }
#' @export
#'
#' @importFrom purrr map_dfr
#'
#' @author Matt Simmons mattsimmons@qantas.com.au

api_call_df <- function(start_date_txt, end_date_txt, api_key, root, path) {
  dates <- seq(as.Date(start_date_txt), as.Date(end_date_txt), by = "days") %>% as.character()
  df <- map_dfr(dates, ~ api_call_tibble(root = root, path = path, date_used = .x, api_key = api_key))
  return(df)
}
