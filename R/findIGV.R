#' Initiate the Java IGV library
#'
#' @return The pathname to the igvtools.jar or igv.jar file used.
#'
#' @aliases findIGV
#' @export
#' @importFrom utils file_test
initIGV <- function() {
  pathname <- findIGV()
  if (!file_test("-f", pathname)) {
    stop("Failed to located igvtools.jar or igv.jar. See help('initIGV').")
  }
  rJava::.jaddClassPath(pathname)

  invisible(pathname)
}

#' @export
#' @importFrom utils file_test
findIGV <- function() {
  ## Locate igvtools.jar
  pathname <- Sys.which("igvtools.jar")
  if (file_test("-f", pathname)) return(pathname)

  path <- Sys.getenv("IGVTOOLS_HOME", NA_character_)
  if (file_test("-d", path)) {
    pathname <- file.path(path, "igvtools.jar")
    if (file_test("-f", pathname)) return(pathname)
  }

  ## Locate igv.jar
  pathname <- Sys.which("igv.jar")
  if (file_test("-f", pathname)) return(pathname)

  path <- Sys.getenv("IGV_HOME", NA_character_)
  if (file_test("-d", path)) {
    pathname <- file.path(path, "igv.jar")
    if (file_test("-f", pathname)) return(pathname)
  }

  if (.Platform$OS.type == "windows") {
    path <- file.path(Sys.getenv("PROGRAMFILES"), "BroadInstitute")
    if (!file_test("-d", path)) {
      path <- file.path(Sys.getenv("PROGRAMFILES(x86)"), "BroadInstitute")
    }
    if (file_test("-d", path)) {
      dirs <- list.files(path=path, pattern="^IGV_")
      paths <- file.path(path, dirs)
      paths <- paths[file_test("-d", paths)]
      paths <- sort(paths, decreasing=TRUE)
      path <- paths[1L]
      pathname <- file.path(path, "igv.jar")
      if (file_test("-f", pathname)) return(pathname)
    }
  }

  NA_character_
}
