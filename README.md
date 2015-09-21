rfun
----------------------

> r fun(ction): 
> attempt to make a **fun** cli for R



A small utility which wraps Rscript and provides access to **all** R functions from CLI.


## install:

### install method 2
```
## automatically placed in your bin, and updated when packages gets updated
install.packages('devtools')
devtools::install_github("sahilseth/funr")
setup()
```


## Using a base package

```
## ------- load help for rnorm
funr rnorm
## ------- sample from rnorm
funr rnorm n=100
```



## Using a non-base package
### Loading a package automatically by `::`
```
## load help file for knitr
funr knitr::knit
## OR use
funr knitr::knit -h
```

### Lets process a Rmd file
```
## get path to an example Rmd file. Assuming we have knitr installed.
## ------- save the filename in a BASH variable rmd
rmd=$(funr system.file package=knitr ...=examples/knitr-minimal.Rmd)
echo $rmd
## knit this awesome example !
funr knitr::knit input=$rmd
```
### Features:
- load help file to fetch arguments
- Automatically load package before running using `::`
- Fetch all named parameters of the function and supply shell arguments after converting to the correct type




