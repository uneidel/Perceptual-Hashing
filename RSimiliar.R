# load Libraries
library(readbitmap)
library(foreach)
library(png)
## Set Working Folder
wfolder = "C:\\projects\\RSimilar\\"
setwd(wfolder);
img <- readPNG("3.png");
#Read files into array
#files <- list.files(pattern = "\\.jpg$")



#for(file in files){
#  print(file);
#  fullpath <- paste(wfolder, file, sep="");
#  print(fullpath);
  # read a sample file (R logo)#
#  file.info(fullpath)
#  img <- readJPEG(system.file("img",fullpath,package="jpeg"))
  #mg1=readJPEG(system.file("img", fullpath, package="jpeg"))
  # read it also in native format
  #img.n <- readJPEG(system.file("img", paste(wfolder, file, sep=""), package="jpeg"), TRUE)
#}