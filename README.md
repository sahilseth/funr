funr
----------------------

> r fun(ction): 
> attempt to make a **fun** cli for R

A small utility which wraps Rscript and provides access to **all** R functions from the terminal.

```
>funr

This aims to provide an easy command-line interface to all R functions.

Usage: funr [-h -v] <name of a function> <arguments to the function [<options>=<value>]>

funr -h            Show this help
funr -h <function> Show help for a specific function
funr -v            Show extra verbose prints, for debugging this package
funr <func>        Find and run <function>
funr <func> [args] Run <func> with supplied <arguments>
funr <pkg::func>   Load the package (pkg), and then run <func>
```



## Examples:

**Using a base package**

```
## load help for rnorm
funr -h rnorm
## sample from rnorm
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
/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin 
## Assuming /usr/local/bin is already in the path variable (check using $PATH)
Rscript -e 'system.file("scripts/funr", package="funr")' ## get the path from this command:
ln -s /Library/Frameworks/R.framework/Versions/3.2/Resources/library/funr/scripts/funr /usr/local/bin/
```
