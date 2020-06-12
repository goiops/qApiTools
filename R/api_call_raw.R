#'
#' API Call (Raw)
#'
#' Calls the API endpoint and returns a list containing the output
#'
#' This function calls an arbitrary API endpoint and returns the output,
#' along with some informative error handling. Wouldn't usually be used directly.
#'
#' @param root A character, as the root path of the API endpoint - usually some kind of http://www.qqq.com/
#' @param path A character, as the specific path of the API - i.e. "api/myapi/v1/apione"
#' @param start_date a character, used in the query as the start of the query period
#' @param end_date a character, used in the query as the end of the query period
#' @param api_key a character, the bearer token provided to access the API. Provided by end user.
#' @param retries an optional numeric, indicating how many times the function should try to hit the API in case of an error
#'
#' @example
#' \dontrun{
#' simple_out <- api_call_raw("http://www.qqq.com/", "api/myapi/v1/apione", "2019-01-01", "2019-01-01", "aaaa-aaa-aaaa-aaa")
#' }
#' @export
#' @importFrom httr modify_url
#' @importFrom purrr safely
#' @importFrom httr add_headers
#' @importFrom httr http_error
#' @importFrom jsonlite toJSON
#' @importFrom jsonlite fromJSON
#' @importFrom httr content


api_call_raw <- function(root, path, start_date, end_date, api_key, retries = 10) {
  print(paste("Requesting data for", start_date,"to", end_date, sep = " "))
  url <- httr::modify_url(root, path = path)
  url <- httr::modify_url(url, query = paste("startDate=",start_date,"&endDate=",end_date, sep = ""))
  # add the required API gateway headers

  safe_GET <- purrr::safely(GET, otherwise = "Request Failed")
  # try 'retries' times to hit the API - if GET returns an error, try again, don't break the execution
  # I haven't actually seen this work in the wild - if it doesn't work as promised... sorry!
  for (k in 1:retries) {
    out <- safe_GET(url, add_headers(Accept = "application/json",
                                     Authorization = paste("Bearer ", api_key, sep = " ")))
    if (is.null(out$error) & !httr::http_error(out$result)) {
      out <- out$result
      break
    } else if (k == retries) {
      print(paste0("Failed after ",k," tries. Skipping this day."))
      out <- jsonlite::toJSON(data.frame(x = numeric()), dataframe = "rows")
      break
    }
    else {
      print(paste0("Request to API failed on ",k,"th try. Trying again..."))
    }
  }

  # get the content, rather than the raw JSON
  out_content <- jsonlite::fromJSON(content(out, "text"), simplifyVector  = FALSE)
  print(paste("Request successful with",sum(lengths(out_content)),"records",sep = " "))
  return(out_content)

}
