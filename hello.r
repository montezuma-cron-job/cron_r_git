sayHello <- function(){
   # write(paste("hello, it is ",Sys.time()), "r_results/test.txt", append=TRUE)
  write(paste("hello, it is ",Sys.time()), paste("r_results/",Sys.time(),".txt"), append=TRUE)
}

sayHello()
