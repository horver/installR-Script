library('yaml')


libs <- yaml.load_file('deps.yaml')
sapply(libs$deps, 
       function(lib) {
         if (!(lib %in% installed.packages()[, 1]))
           install.packages(lib)
       }
)