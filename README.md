
<!-- README.md is generated from README.Rmd. Please edit that file -->
HindiMorph
==========

Morphological analysis of Hindi. This package gives the class of a word of Hindi, using `RDRPOSTagger` (<http://rdrpostagger.sourceforge.net/>)

**Sorry, This package works on UNIX OS (Linux or MacOS) only.**

Installation
------------

### Requirements

You need to install pyenv and python2.7.13 to use HindiMorph.

    git clone git://github.com/yyuu/pyenv.git ~/.pyenv
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile # or .bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(pyenv init -)"' >> ~/.bash_profile

    pyenv install 2.7.13

### HindiMorph

You can install HindiMorph from github with:

``` r
# install.packages("devtools")
devtools::install_github("ymattu/HindiMorph")
```

Example
-------

This package contains only one function `hindi_morph`. This function accepts only dataframe and you just specify the column name of the text. Then a dataframe contains word, class, and documentid is returned.

``` r
library(HindiMorph)

# sample data
df <- data.frame(txt = c("कि जब तक ये सब बातें न हो लेंगी","तब तक यह पीढ़ी जाती न रहेगी।[31]आकाश और पृथ्वी टल जाएंगे","परन्तु मेरी बातें कभी न टलेंगी।"))

res <- hindi_morph(df, txt)
res
#> # A tibble: 26 x 3
#>    document_id  word morph
#>  *       <int> <chr> <chr>
#>  1           1    कि    CC
#>  2           1    जब   PRP
#>  3           1    तक   PSP
#>  4           1     ये   DEM
#>  5           1    सब   NNC
#>  6           1   बातें    NN
#>  7           1     न   NEG
#>  8           1    हो    VM
#>  9           1   लेंगी  VAUX
#> 10           2    तब   PRP
#> # ... with 16 more rows
```
