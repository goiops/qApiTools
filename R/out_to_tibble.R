#'
#' Out To Tibble
#'
#' This uses element_to_tibble to turn all the elements of a JSON into a tibble and concatenate.
#'
#' This function turns the entirety of a JSON list structure into a tibble. Not that useful
#' except as used by other functions.
#'
#' @param out_content A list, a JSON element returned by api_call_raw
#'
#' @examples
#' \dontrun{
#' out_content <- api_call_raw(root, path, date_used, date_used, api_key)
#' out_tibble <- out_to_tibble(out_content)
#' }
#' @importFrom purrr flatten
#' @importFrom purrr flatten
#' @importFrom rlist list.flatten
#' @importFrom data.table rbindlist
#'
#' @author Matt Simmons mattsimmons@qantas.com.au


out_to_tibble <- function(out_content) {
  #first we flatten the content to get rid of the first layer, which seems arbitrary
  out_content_flat <- purrr::flatten(out_content)
  # then we use rlist's flatten, which has the nice property of concatenating the names
  all_elements_flat <- purrr::map(out_content_flat, rlist::list.flatten)
  # then we iterate element.to.tibble across it to make nice tibbles
  all_elements_tibble <- purrr::map(all_elements_flat, element_to_tibble)
  # then we bind them all together (could be map_dfr, really)
  all_elements_tibble <- data.table::rbindlist(all_elements_tibble, fill = TRUE)
  print(paste("Tibble created with",nrow(all_elements_tibble),"rows", sep = " "))
  return(all_elements_tibble)
}
