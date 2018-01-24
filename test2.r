
args <- commandArgs(TRUE)
x <- as.numeric(args[1])
y <- as.numeric(args[2])


f<-function(x,y){
z=c(1:5)^x+y
print(z)
#save("z",file=paste("test2",x,y,".RData",sep=""))
#save("z",file=paste("/home/dy78/test_eric/test2",x,y,".RData",sep=""))
save("z",file=paste("/data/test2",x,y,".RData",sep=""))
}
f(x,y)


