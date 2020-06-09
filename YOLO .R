#install.packages("devtools") If devtools is not available
devtools::install_github("bnosac/image", subdir = "image.darknet", build_vignettes = TRUE)
library(devtools)
library(usethis)
library(image.darknet)
yolo_tiny_voc <- image_darknet_model(type = 'detect', 
                                     model = "tiny-yolo-voc.cfg", 
                                     weights = system.file(package="image.darknet", "models", "tiny-yolo-voc.weights"), 
                                     labels = system.file(package="image.darknet", "include", "darknet", "data", "voc.names"))
x <- image_darknet_detect(file = "/Users/vikramraj/Desktop/IMG_0007.jpg", 
                          object = yolo_tiny_voc,
                          threshold = 0.05)


getwd()
