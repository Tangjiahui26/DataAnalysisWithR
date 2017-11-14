library(downloader)
download.file(url = "https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/gapminder.tsv", destfile = "gap-every-five-years.tsv")
download.file(url = "https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/country-codes.tsv", destfile = "iso-codes.tsv")