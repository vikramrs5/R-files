install.packages("magick")
install.packages("image.libfacedetection",repos = "https://bnosac.github.io/drat")
library(magick)
library(image.libfacedetection)
my_image=image_read("http://bnosac.be/images/bnosac/blog/wikipedia-25930827182-kerry-michel.jpg")
faces=image_detect_faces(my_image)
faces
plot(faces,my_image,border="red",lwd=7,col="white")
allfaces=Map(
  x=faces$detections$x,
  y=faces$detections$y,
  width=faces$detections$width,
  height=faces$detections$height,
  f=function(x,y,width,height){image_crop(my_image,geometry_area(x=427,y=161,width = 60,height = 60))})
allfaces=do.call(c,allfaces)
allfaces
