all: figures.rds

clean:
	rm -f gap-every-five-years.tsv
	rm -f iso-codes.tsv
	rm -f data_frame.rds
	rm -f figures.rds

#gap-every-five-years.tsv:
#	curl -L https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/gapminder.tsv >gap-every-five-years.tsv
#	curl -L https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/country-codes.tsv >iso-codes.tsv

gap-every-five-years.tsv:
	Rscript 00_download-data.R
	
data_frame.rds: 01_dataframe.R gap-every-five-years.tsv 
	Rscript $<
	
figures.rds: 02_figures.R data_frame.rds
	Rscript $<
	rm -f Rplots.pdf