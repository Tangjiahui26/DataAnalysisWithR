all: hw07-Tang-Jiahui.html

clean:
	rm -f gap-every-five-years.tsv
	rm -f iso-codes.tsv
	rm -f data_frame.rds
	rm -f figures.rds
	rm -f ./figures/*.png
	rm -f ./files/*.rds

#gap-every-five-years.tsv:
#	curl -L https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/gapminder.tsv >gap-every-five-years.tsv
#	curl -L https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/country-codes.tsv >iso-codes.tsv

gap-every-five-years.tsv iso-codes.tsv:
	Rscript 00_download-data.R
	
data_frame.rds: 01_dataframe.R gap-every-five-years.tsv iso-codes.tsv
	Rscript $<
	
figures.rds: 02_figures.R data_frame.rds
	Rscript $<
	rm -f Rplots.pdf
	
reordered.rds: 03_reordered.R figures.rds
	Rscript $<
	rm -f Rplots.pdf
	
linear-regression.rds: 04_linear-regression.R reordered.rds
	Rscript $<
	rm -f Rplots.pdf
	
hw07-Tang-Jiahui.html: hw07-Tang-Jiahui.Rmd linear-regression.rds gap-every-five-years.tsv
	Rscript -e 'rmarkdown::render("$<")'