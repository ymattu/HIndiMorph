##' Morphological Analysis Hindi Using RDRPOST
##'
##' @param data dataframe contains a column to analyze
##' @param text_col column name of the text toanalyze
##' @author Yuya Matsumura
##'
##' @importFrom rlang enquo !!
##' @importFrom dplyr as_data_frame select mutate rename filter row_number slice n %>%
##' @importFrom readr write_csv read_lines
##' @importFrom tidyr separate separate_rows
##' @importFrom stringr str_detect
##' @export
hindi_morph <- function(data, text_col) {

  # Select the column to analyze
  quolabel <- enquo(text_col)

  csvoutput <- data %>%
    select(!! quolabel)

  # Output to csv
  wd <- getwd()
  origin_file <- paste0(wd, "/morphtext.csv")
  write_csv(csvoutput, origin_file)

  # Make Command for Commandline
  srcfile <- "RDRPOSTagger.py"
  libpath <- find.package("HindiMorph")
  cdpath <- paste0(libpath, "py/RDRPOSTagger/pSCRDRtagger")
  pyenv_command <- "pyenv local 2.7.13 && pyenv rehash"
  rdr <- system.file("py/RDRPOSTagger/Models/POS/Hindi.RDR", package = "HindiMorph")
  dict <- system.file("py/RDRPOSTagger/Models/POS/Hindi.DICT", package = "HindiMorph")

  cmd <- paste("cd",
               cdpath,
               "&&",
               "python",
               srcfile,
               "tag",
               rdr,
               dict,
               origin_file)

  # Execute Command, then .TAGGED file will be made by Python Script
  system(cmd)

  # Read .TAGGED file
  taggedfile <- paste0(wd, "/morphtext.csv.TAGGED")

  # Data Wrangling
  res <- NULL
  value <- NULL
  morph <- read_lines(taggedfile) %>%
    as_data_frame() %>%
    slice(2:n()) %>%
    rename(res = value) %>%
    mutate(document_id = row_number()) %>%
    separate_rows(res, sep = " ") %>%
    filter(str_detect(res, "https|http|t.co") == FALSE) %>% # Delete urls
    filter(str_detect(res, "/[^A-Z]") == FALSE) %>% # Delete inappropriate rows
    separate(col = res, into = c("word","morph"), sep = "/")

  # Remove temporary files
  file.remove(origin_file)
  file.remove(taggedfile)

  # Output Tidy DataFrame
  return(morph)
}
