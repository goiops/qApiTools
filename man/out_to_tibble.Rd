% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/out_to_tibble.R
\name{out_to_tibble}
\alias{out_to_tibble}
\title{Out To Tibble}
\usage{
out_to_tibble(out_content)
}
\arguments{
\item{out_content}{A list, a JSON element returned by api_call_raw}
}
\description{
This uses element_to_tibble to turn all the elements of a JSON into a tibble and concatenate.
}
\details{
This function turns the entirety of a JSON list structure into a tibble. Not that useful
except as used by other functions.
}
\examples{
\dontrun{
out_content <- api_call_raw(root, path, date_used, date_used, api_key)
out_tibble <- out_to_tibble(out_content)
}
}
\author{
Matt Simmons mattsimmons@qantas.com.au
}
