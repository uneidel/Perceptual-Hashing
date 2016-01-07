# load Libraries
showImages = false;
library(readbitmap)
library(dtt)
library(EBImage)
library(BMS)
library(e1071)



## Set Working Folder
wfolder = "C:\\projects\\RSimilar\\"
setwd(wfolder);

GetPHash <- function(name){
  x = readImage(name)
  #display(x,"Original")
  
  # 2. Reduce Color.
  grayimage<-channel(x,"gray")
  #display(grayimage,"GrayScale")
  
  # 1. Reduce size.
  grayimage =resize(grayimage, 32, 32, filter = "bilinear");
  #display(x, "Resized");
  
  #3. Compute the DCT.
  dct= dct(grayimage, variant = 2, inverted = FALSE)
  display(dct, "DCT")

  #// 4. Reduce the DCT.
  # This is the magic step. While the DCT is 32x32, just keep the
  # top-left 8x8. Those represent the lowest frequencies in the
  # picture.
  reducedMatrix = dct[1:8,1:8];

  #5 a) Compute the average value.
  #Compute the average value. Like the Average Hash, compute the mean DCT value (using only the 8x8 DCT low-frequency values and excluding the first term since the DC coefficient can be significantly different from the other values and will throw off the average)
  sum <- sum(rowSums(reducedMatrix))
  total <- sum - reducedMatrix[1,1];
  avg <- (total / ((32*32)-1))
  #5. b) Compute the average value.

  #5c) Invert for display
  idct= dct(reducedMatrix, variant = 2, inverted = TRUE)
  display(idct, "Inverted")
  #6 Compare 
  # Create empty hash array
  hash <-""
  lhash <- logical(64)
  for (y in 1:nrow(reducedMatrix))
  {
    for (x in 1:ncol(reducedMatrix))
    {
      if (reducedMatrix[x,y]< avg)
      {
        hash = paste(hash,"0",sep="")
        lhash[x+y] = 0;
      }
      else
      {
        hash = paste(hash,"1",sep="")
        lhash[x+y] = 1;
      }
    }
  }
  return (lhash);
}

GetAHash <- function(name){
  x = readImage(name)
  #display(x,"Original")
  
  # 2. Reduce size.
  grayimage =resize(grayimage, 32, 32, filter = "bilinear");
  #display(grayimage,"GrayScale")
  
  # 2. Reduce Color.
  grayimage<-channel(x,"gray")
  #display(grayimage,"GrayScale")
  
  
  # 3.Average the colors.
  meanvalue <- mean(grayimage);
  lhash <- logical(64)
  for (y in 1:nrow(grayimage))
  {
    for (x in 1:ncol(grayimage))
    {
      if (grayimage[x,y]< meanvalue)
      { 
        lhash[x+y] = 0;
      }
      else
      {
        lhash[x+y] = 1;
      }
    }
  }
  return (lhash);
}
print("PHash")
hash1 <- GetPHash("3JPG.jpg")
hash2 <- GetPHash("MarioJPG.jpg")

print("Hamming Distance")
hamming.distance(hash1, hash2)