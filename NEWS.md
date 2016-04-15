funr 0.3.0
----------------------------------------------
- **NEW**: A new function, to detect the path, where R script resides.
  This is similar to `$0` in bash scripting. 
  This functionality is missing in R
- better error messages in case of failures

funr 0.2.0
----------------------------------------------
- **NEW**: added beta support to unix pipes
- some bug fixes in render_funr

funr 0.1.0
----------------------------------------------
- funr() outputs a class of `funr`, which is essentially a list.
- This ensures that when print is called, it prints it pretty
- Appreciate if function returns as invisble, do not display the results.
