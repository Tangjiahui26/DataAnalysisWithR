
# STAT545-hw05-Jiahui-Tang

Hi, Everyone! Welcome to this repo for Homework05.:smirk:

## Homework05 Materials

### [Homework 05: Factor and figure management; Repo hygiene](http://stat545.com/hw05_factor-figure-boss-repo-hygiene.html)

***Factor management***

Step goals:
+ Define factor variables;
+ Drop factor / levels;
+ Reorder levels based on knowledge from data.

***File I/O***

Experiment with one or more of `write_csv()/read_csv()` (and/or TSV friends), `saveRDS()/readRDS()`, `dput()/dget()`. Create something new, probably by filtering or grouped-summarization of Singer or Gapminder. I highly recommend you fiddle with the factor levels, i.e. make them non-alphabetical (see previous section). Explore whether this survives the round trip of writing to file then reading back in.

***Visualization design***

Remake at least one figure or create a new one, in light of something you learned in the recent class meetings about visualization design and color. Maybe juxtapose your first attempt and what you obtained after some time spent working on it. Reflect on the differences. If using Gapminder, you can use the country or continent color scheme that ships with Gapminder.

***Writing figures to file***

Use `ggsave()` to explicitly save a plot to file. Then use `![Alt text](/path/to/img.png)` to load and embed it in your report. You can play around with various options, such as:

+ Arguments of `ggsave()`, such as width, height, resolution or text scaling.
+ Various graphics devices, e.g. a vector vs. raster format.
+ Explicit provision of the plot object p via `ggsave(..., plot = p)`. Show a situation in which this actually matters.

***Clean up your repo!***

+ A nice Table of Contents in top-level README that links to individual pieces of work.
  - Good for future: `hw03 dplyr verbs`
  - Bummer in the future: `hw03`
  - Include a slug with content info!
+ Remove all downstream stuff, e.g. figures, html, etc. and re-render everything. It will be nice to not have weird, vestigial files lying around to puzzle you in future.
+ Anything that’s `Rmd` but that could be `md`? Convert it.

***But I want to do more!***

Make a deeper exploration of the forcats packages, i.e. try more of the factor level reordering functions.

## Report My Process


## Links

[as_factor](https://www.rdocumentation.org/packages/haven/versions/1.1.0/topics/as_factor)

[How to convert integer to factor in R?](https://stackoverflow.com/questions/31165015/how-to-convert-integer-to-factor-in-r)
[Be the boss of your factors](http://stat545.com/block029_factors.html)
[All the graph things](http://stat545.com/graph00_index.html)