
**Idea is to integrate funr into litter**:

```
r -f system.file package=knitr fl=examples/knitr-minimal.Rmd | r -f \ 
 knitr::knit input=/dev/stdin
```


**inputs**

- funr() recognizes two options -h (help) and -v (verbose)
- ignores all other options starting with `-`
- First argument is assumed to be function name
- if function name contains `::` the word before is assumed to a pkg, and is loaded
- All other params follow `var=value`, and are parsed accordingly

*Complex inputs*:

- if value has a comma (paths=path1,path2), funr would split them and supply c('path1', 'path2') to the function.
- inputs like data.frame, list etc are not supported.


**outputs**

Print the output (using render_funr):

Essentially I use print to show the output (STDOUT)

- skips output, if function returns using invisible.
- If its a table, shows the first 100 rows (may need to turn this off ?)

