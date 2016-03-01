## covr: skip=all
.onLoad <- function(libname, pkgname) {
  if (.Platform$OS.type == "windows" && .Platform$r_arch != "x64") {
    warning(sprintf("Package %s is supported on this architecture: ", sQuote(pkgname)))
    return()
  }

  requireNamespace("rJava")
  rJava::.jpackage(pkgname, lib.loc=libname)
  initIGV()
}
