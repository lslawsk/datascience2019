# Part 2. Writing your own functions.

## conversion function practice

# list all arguments inside function(), i.e. inputs. then in body {} design function
# input value of temp in one unit and get return converted to another unit

# conversion function F to K
f_to_k <- function(temp){
  if(!is.numeric(temp)) {
    stop("temp must be numeric")
  }
  kelvin <- ((temp - 32) * (5/9)) + 273.15
  return(kelvin)
}
# test function
f_to_k(32)

# conversion function K to C
k_to_c <- function(temp){
  celcius <- temp - 273.15
  return(celcius)
}
# test function
k_to_c(273.15)

## nesting a function within a function

# F to C reusing above functions
f_to_c <- function(tempF){
  if(!is.numeric(tempF)) {
    stop("temp must be numeric")
  }
  celcius <- k_to_c(f_to_k(tempF))
  return(celcius)
}
# the following also works as nested functions
# f_to_c <- function(temp){
#  kel <- f_to_k(temp)
#  cel <- k_to_c(kel)
#  return(cel)
# }

f_to_c(212)
f_to_c("t")

## defensive programming: including flags to account for errors
# !! tweak above functions. performed a commit before making the changes.
# working within functions above, adding error messages

# alternative to what's used above in f_to_k that will also work:
f_to_k_2 <- function(temp){
  stopifnot(is.numeric(temp))
  kelvin <- ((temp - 32) * (5/9)) + 273.15
  return(kelvin)
}
f_to_k_2("t")

## write a function once that can be reused for different projects
# save to a repository so can call for that function in another file/script
# just call from folder it's in then use function
source("code/intro-functions.R")
f_to_c(32)

## Roxygen package avail. to help buildin documentation in a more formal way as you write functions
