# Part 2. Writing your own functions.


## conversion function practice

# list all arguments inside function(), i.e. inputs. then in body {} design function
# input value of temp in one unit and get return converted to another unit

# conversion function F to K
f_to_k <- function(temp){
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
  celcius <- k_to_c(f_to_k(tempF))
  return(celcius)
}
# the following also works
# f_to_c <- function(temp){
#  kel <- f_to_k(temp)
#  cel <- k_to_c(kel)
#  return(cel)
# }

f_to_c(212)

## defensive programming: including flags to account for errors
# tweak above function. May be a good time to commit







