funr
----------------------

[![Build Status](https://travis-ci.org/sahilseth/funr.svg?branch=master)](https://travis-ci.org/sahilseth/funr)
[![cran](http://www.r-pkg.org/badges/version/funr)](http://cran.rstudio.com/web/packages/funr/index.html)


> r fun(ction): 
> attempt to make a **fun** cli for R

A small utility which wraps Rscript and provides easy access to **all** R functions from the terminal.

```
>funr

This aims to provide an easy command-line interface to all R functions.

Usage: funr [-h -v] <name of a function> <arguments to the function [<options>=<value>]>

funr -h            Show this help
funr -h <function> Show help for a specific function
funr -v            Show extra verbose messages for debugging this package
funr <func>        Find and run <function>
funr <func> [args] Run <func> with supplied <arguments>
funr <pkg::func>   Load the package (pkg), and then run <func>
```



## Examples:

**Using a base package**

```
## load help for rnorm
funr -h rnorm
    Normal                  package:stats                  R Documentation
    The Normal Distribution
    Description:
       Density, distribution function, quantile function and random

## sample 10 numbers from a normal distribution
funr rnorm n=10
    -1.244571 1.378112 0.02189023 -0.3723951 0.282709 -0.22854 -0.8476185 0.3222024 0.08937781 -0.4985827
```


**Using a non-base package**
*Loading a package automatically by `::`*

```
## load help file for knitr
funr -h knitr::knit
    knit                   package:knitr                   R Documentation
    Knit a document
    Description:
       This function takes an input file, extracts the R code in it
       according to a list of patterns, evaluates the code and writes the
       output in another file. It can also tangle R source code from the
```

**Knit a HTML file using a example R markdown input from knitr package:**

```
## get path to an example Rmd file. Assuming we have knitr installed.
## Save the filename in a BASH variable rmd
rmd=$(funr system.file package=knitr fl=examples/knitr-minimal.Rmd)
echo $rmd
    /Library/Frameworks/R.framework/Versions/3.2/Resources/library/knitr
## knit this awesome example !
funr knitr::knit2html input=$rmd
    loading pkg: knitr
    processing file: ... knitr/examples/knitr-minimal.Rmd
    output file: knitr-minimal.md
    knitr-minimal.html
```

**Using devtools from terminal**

```
## installing a repo from github
funr devtools::install_github repo="sahilseth/flowr"

## cd into a pacakge you want to check and run
funr devtools::check

## cd into a pacakge you want to build and run
funr devtools::build
```

## Highlights:
- Fetch all named parameters of the function and supply shell arguments after converting to the correct type
- load help files, providing easy access to R man pages.
- Automatically load any packages and use any exported functions


## Installation:

> automatically placed in your bin, and updated when packages gets updated

```
## a stable version
install.packages("funr")


## OR a latest developmental version
install.packages('devtools')
devtools::install_github("sahilseth/funr")

## setup
library(funr)
setup()
    A small script funr has been copied to ~/bin.
    Consider adding ~/bin to your PATH variable, by running this:
    echo 'export PATH=$PATH:~/bin' >> ~/.bashrc
    After opening a new shell session, running funr from the shell should work
```

To be able to run this utility without the need to use the full path, you need to add the folder containing the
`funr` script to your PATH variable. The `setup` function copies a shortcut to this script to the `~/bin` folder.
Then you would need to add `~/bin` to your PATH variable. You may do this using this command:

```
echo 'export PATH=$PATH:~/bin' >> ~/.bashrc
```

Alternatively you may copy a shortcut to the `funr` script to any of the following folders on a linux/mac machine.

```
## Usually Unix based systems already contain these folders in the PATH variable:
/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin 

## Assuming /usr/local/bin is already in the path variable (check using echo $PATH),
## this might be a good place to install funr. 
## This would make it accesible to ALL users of the machine/server

## get path to the funr script
Rscript -e 'system.file("scripts/funr", package="funr")' ## get the path from this command:

## create a shortcut to the scruot
ln -s /Library/Frameworks/R.framework/Versions/3.2/Resources/library/funr/scripts/funr /usr/local/bin/
```
