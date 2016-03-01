#' TDFUtils class
#'
#' @return TDFUtils Java class
#'
#' @export
TDFUtils <- local({
  clazz <- NULL
  function() {
    if (is.null(clazz)) clazz <- rJava::.jnew("org/broad/igv/tdf/TDFUtils")
    clazz
  }
})
