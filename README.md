funr
----------------------

[![Build Status](https://travis-ci.org/sahilseth/funr.svg?branch=master)](https://travis-ci.org/sahilseth/funr)
[![cran](http://www.r-pkg.org/badges/version/funr)](http://cran.rstudio.com/web/packages/funr/index.html)
![license](https://img.shields.io/badge/license-MIT-blue.svg)
![downloads](http://cranlogs.r-pkg.org/badges/grand-total/funr)


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
funr <func> [args] Run <func> with supplied [arguments]
funr <pkg::func>   Load the package <pkg>, and then run <func>
```



## Examples:

**Using a base package**

```
## load help for rnorm
funr -h rnorm
```

```
    Normal                  package:stats                  R Documentation
    The Normal Distribution
    Description:
       Density, distribution function, quantile function and random

## sample 10 numbers from a normal distribution
funr rnorm n=10
    -1.244571 1.378112 0.02189023 -0.3723951 0.282709 -0.22854 -0.8476185 0.3222024 0.08937781 -0.4985827
```


**Using a non-base package**
*Load a package automatically by `::`*

```
## load help file for knitr
funr -h knitr::knit
```

```
    knit                   package:knitr                   R Documentation
    Knit a document
    Description:
       This function takes an input file, extracts the R code in it
       according to a list of patterns, evaluates the code and writes the
       output in another file. It can also tangle R source code from the
```

**Knit a HTML file using a example R markdown input from knitr package:**

```
## get path to an example Rmd file (assuming you have knitr installed).
## pipe the file path, to a subsequent funr command (for version >0.1.2)
funr system.file package=knitr fl=examples/knitr-minimal.Rmd | funr knitr::knit2html input=-
```

```
    loading pkg: knitr
    processing file: ... knitr/examples/knitr-minimal.Rmd
    output file: knitr-minimal.md
    knitr-minimal.html
```

**Adding funr to your scripts**

For example, create a file (`norm.r`), similat to the following.

```
#!/usr/bin/env Rscript

# define your functions
norm_hist <- function(n){
  x = rnorm(n)
  
  hist(x)
}

library(funr)
out = funr(commandArgs(trailingOnly = TRUE))
```

Basic components include 1) shebang line (`#!/usr/bin/env Rscript`), so that shell knows that this is a Rscript, 2) 
definition of the function you would like to call 3) passing cmd arguments to `funr`.

Following this, add execution privilige to the script using:

```
chmod ugo+rx norm.r
```

Now, one may call the function:

```
norm.r norm_hist n=100

# OR (is you prefer)
Rscript norm.r norm_hist n=100
```

<!---
rmd=$(funr system.file package=knitr fl=examples/knitr-minimal.Rmd)
echo $rmd
    /Library/Frameworks/R.framework/Versions/3.2/Resources/library/knitr
## knit this awesome example !
funr knitr::knit2html input=$rmd
--->


**Using devtools from terminal**

Building up on the example above, we can wrap an entire R package, and use help text to show a few examples.

Here is an example, for wrapping devtools:
https://github.com/sahilseth/funr/blob/master/inst/scripts/devtools

```
## download custom funr script
wget https://github.com/sahilseth/funr/raw/master/inst/scripts/devtools -O ~/bin/devtools

## installing a repo from github
devtools install_github repo="sahilseth/flowr"

## cd into a pacakge you want to check and run
devtools check .

## cd into a pacakge you want to build and run
devtools build .
```

Along the same lines here is another example for package `flowr`:
https://github.com/sahilseth/flowr/blob/master/inst/scripts/flowr



## Highlights:
- Fetch all named parameters of the function and supply shell arguments after converting to the correct type.
    - detects argument type from the function call
        - convert to 1. logical, 2. integer or 3. numeric etc.
- load help files, providing easy access to R man pages (using `-h`).
- Automatically load any package and use any of its exported functions (via `funr pkg::func`)

## Updates
This package is under active-development, 
you may watch for changes using
the [watch link above](https://help.github.com/articles/watching-repositories/).


## Installation:

> automatically placed in your bin, and updated when the package gets updated

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

Alternatively, you may copy a shortcut to the `funr` script to any of the following folders on a linux/mac machine.

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
