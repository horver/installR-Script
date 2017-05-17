library('yaml')

InstallLibs <- function(libs, load = TRUE) {
  sapply(libs, 
         function(lib) {
           if (!(lib %in% installed.packages()[, 1]))
             install.packages(lib)
           if (load)
             library(lib, character.only = TRUE)
         }
  )
}

InstallLibsScript <- function(files, load = TRUE) {
  contents <- sapply(files, function(file) readLines(file, file.size(file)))
  libs <- c(gsub("library\\((.*)\\)", "\\1", contents)[grep("library", contents), ],
            gsub("require\\((.*)\\)", "\\1", contents)[grep("require", contents), ])
  libs <- gsub("[^[:alnum:]]", "", libs)
  InstallLibs(libs, load)
}


InstallLibsYAML <- function(file = 'deps.yaml') {
  libs <- yaml.load_file(file)
  InstallLibs(libs$deps, libs$load)
}

