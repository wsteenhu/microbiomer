#' Function to reformat OTU names for plotting.
#'
#' Italicize the taxonomical annotations and place the numerical identifier in brackets. By default,
#' returns names formatted to work in conjunction with \code{\link[ggtext]{element_markdown}}. For example
#' 'Dolosigranulum_pigrum_3' will be formatted into '\emph{Dolosigranulum pigrum} (3)' in the figure.
#'
#' @param OTU_names vector of OTU-names in the form of <genus>_<species>_<numerical_id>, e.g.
#' 'Dolosigranulum_pigrum_3'
#' @param short whether or not the short name (dropping the species-name if available) should be
#' returned (logical). Default: FALSE
#' @param parse option to use in conjunction with \code{\link[ggrepel]{geom_text_repel}} enabling
#' italicized/formatted OTU names in for example ordination plots (logical). Default: FALSE
#'
#' @return returns a vector of properly formatted OTU names.
#' @export
#'
#' @examples
#' phyloseq::taxa_names(ps_NP)[1:10] %>% format_OTU()
#'
#' @importFrom rlang .data
format_OTU <- function(OTU_names, short = F, parse = F) {

  OTU_names_tb <- tibble::tibble(OTU_names)

  OTU_names_num <- OTU_names_tb %>%
    dplyr::mutate(num = purrr::map_chr(OTU_names, ~stringr::str_extract(., "(?<=_)[0-9]+$")))

  OTU_names_tb_format <- OTU_names_num %>%
    dplyr::filter(!is.na(.data$num) & !duplicated(OTU_names)) %>%
    dplyr::mutate(
      name1 = unlist(purrr::map(stringr::str_split(OTU_names, "__|_"), ~ head(.x, -1) %>% glue::glue_collapse(., " "))), #everything except last
      name2 = unlist(purrr::map(stringr::str_split(OTU_names, "__|_"), ~ head(.x, 1))), #last
      long_name = as.character(glue::glue("*{name1}* ({num})")),
      short_name = as.character(glue::glue("*{name2}* ({num})")),
      parse_name = as.character(glue::glue("italic('{name2}')~({num})")))

  OTU_names_nonum <- OTU_names_num %>%
    dplyr::filter(is.na(.data$num) & !duplicated(OTU_names))

  OTU_names_final <- dplyr::left_join(
    OTU_names_tb,
    dplyr::bind_rows(OTU_names_tb_format, OTU_names_nonum) %>%
      dplyr::mutate(dplyr::across(dplyr::ends_with("_name"), ~dplyr::if_else(is.na(.data$num), stringr::str_to_title(OTU_names), .x)))
    , by = "OTU_names")

  if(!short & !parse) {
    return(OTU_names_final %>% dplyr::pull(.data$long_name))
  } else if(parse) {
    return(OTU_names_final %>% dplyr::pull(.data$parse_name))
  } else {
    return(OTU_names_final %>% dplyr::pull(.data$short_name)) }
}
