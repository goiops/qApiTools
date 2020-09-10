#'
#' API Call (Tibble)
#'
#' Makes and API call and turns the result into a tibble
#'
#' A high level wrapper for api_call_raw and out_to_tibble that makes an API call
#' And then turns the result into a tibble. More useful, but better to use
#' api_call_df instead.
#'
#' @param root A character, as the root path of the API endpoint - usually some kind of http://www.qqq.com/
#' @param path A character, as the specific path of the API - i.e. "api/myapi/v1/apione"
#' @param date_used A date to pull data for.
#' @param api_key a character, the bearer token provided to access the API. Provided by end user.
#'
#' @examples
#' \dontrun{
#' dates <- seq(as.Date(start_date_txt), as.Date(end_date_txt), by = "days") %>% as.character()
#' df <- map_dfr(dates, ~ api.call.tibble(root = root, path = path, date_used = .x, api_key = api_key))
#' df
#' }
#'
#' @author Matt Simmons mattsimmons@qantas.com.au

api_call_tibble <- function(root, path, date_used, api_key) {
  out_content <- api_call_raw(root, path, date_used, date_used, api_key)
  out_tibble <- out_to_tibble(out_content)
  return(out_tibble)
}
