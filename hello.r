sayHello <- function(){
   write(paste("hello, it is ",Sys.time()), "r_results/test.txt", append=TRUE)
}

sayHello()
