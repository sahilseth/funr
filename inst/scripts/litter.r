#!./r

library(funr)

## args as a character string.
## litter does not seem to like this function.
args = commandArgs(trailingOnly = TRUE) 
out = funr(args, script_name = "litter")


## Use: print(out$value), if you want the exact output
## OR use render_funr(out), to render them in a pretty manner
render_funr(out)
