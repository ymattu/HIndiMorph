library(HindiMorph)

context("Check hindi_morph()")

test_that("Moprph", {
  #libpath <- .libPaths()
  #wdpath <- paste0(libpath, "/HindiMorph/tests/testthat")
  setwd(".")
  dat <- HindiMorph:::tw_text2
  res <- hindi_morph(dat, text)
  expected <- "\\u0924\\u0941\\u092e"
  expect_equal(stringi:: stri_escape_unicode(as.character(res[5, 1])),
               expected)
})
