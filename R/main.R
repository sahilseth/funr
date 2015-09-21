




#' Title
#'
#' @param args Should always be: \code{commandArgs(trailingOnly = TRUE)}
#' @param help_text A simple text to be displayed describing options and usage of this interface
#' @param script_name Name of the script. This is used in the the help text. [funr]
#'
#' @export
funr <- function(args, 
								 help_text, 
								 script_name = "funr"){
	
	##        show help if there are no arguments
	#if(missing(help_text))
	
	if(missing(args) | length(args) == 0){
		message(generic_help(help_text = help_text, script_name = script_name))
		return()
	}
	
	##           Arguments which start with - are for this script
	rm = grep("^-", args)
	script_args = args[rm]
	
	verbose = FALSE
	if("-v" %in% script_args)
		verbose = TRUE

	if(verbose){
		message("args:"); message(args)
		message("script_args:"); message(script_args)
	}
	
	## remove these from subsequent processing
	if(length(rm) > 0)
		args = args[-rm]
	
	if(length(args) == 0){
		message(generic_help(help_text = help_text))
		return()
	}

	##             Get name of the function
	func = args[1]
	## all arguments to that function
	args = args[-1]
	
	if(verbose){
		message("\nusing func:");message(func)
		message("with final args:");message(args)
	}
	
	
	##           Load the required package
	if(grepl("::", func)){
		pkg <- gsub("(.?)::.*", "\\1", func)
		cat("loading pkg:", pkg, "\n");
		library(pkg, character.only = TRUE)
		func = as.character(gsub(".*::(.*)", "\\1", func))
	}
	
	if( is.na(func) ){
		generic_help()
		invisible()
	}
	
	fn = try(get(func))
	if(class(try(fn)) == "try-error")
		stop("\n\nwe would not find a function by this name, please check: ", func)
	
	if(is.function(fn) & "-h" %in% script_args){
		return(help(func))
		
	}else{
		
		params <- parse_params(func = func, paramPairs = args, verbose = verbose)
		if(verbose){
			cat("\nStarting", func, "with params\n",
					paste(names(params), unlist(params),sep=": ",
								collapse="\n"),"\n")
			#message(args)
			if(verbose) message(str(params))
		}
		
		if(length(args) == 0)
			message("\ntry:      ", script_name, " -h ", func, "     to get more details on this function.")
		
		return(try(withVisible(do.call(func, args = params))))
		## should be the LAST LINE
		#return(out)
	}
	
}



