#'
#' Element to Tibble
#'
#' This turns an list-element of JSON into a tibble
#'
#' This function takes an element of a JSON and turns it into a tibble. Not that useful
#' except as used in other functions
#'
#' @param element A list, an element of a JSON that could be turned into a tibble.
#'
#' @examples
#' \dontrun{
#' out_content_flat <- purrr::flatten(out_content)
#' all_elements_flat <- purrr::map(out_content_flat, rlist::list.flatten)
#' all_elements_tibble <- purrr::map(all_elements_flat, element.to.tibble)
#' }
#' @export
#' @importFrom magrittr %>%
#' @importFrom tibble as_tibble
#'
#' @author Matt Simmons mattsimmons@qantas.com.au

element_to_tibble <- function(element) {
  # each element contains some recursive columns that don't have unique names
  # this drops them by selecting only the unique elements, then converting to a tibble
  elements_names <- names(element)
  elements_counts <- table(elements_names) %>% .[. == 1] %>% names() -> element_unique
  elements_unique_only <- element[element_unique]
  elements_tibble <- as_tibble(elements_unique_only)
  return(elements_tibble)
}
