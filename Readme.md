With FaceFirst UIImage category, you can crop and resize an image to a specific size and it will try not to crop out any face showing in the image. For a group shot, it will pick only one of faces as base. For any other image without any human face, it will not take any effect, just resize and crop to the size you sepecify. 

You can combine this category with UIImageView together to show any image with faces properly.

## How To Use 

* Drag and drop UIImage+FaceFirst.h and UIImage+FaceFirst.m into your XCode project.
* Include CoreImage.framework in the libraries your project is linking to. 
* Use the following sample in your code:

    self.imageView.image = [[UIImage imageNamed:@"yourimage"]
                           faceFirstImageScaledToFillSize:self.imageView.frame.size];


## Basic Requirements 

* iOS5: since it is using CIDetector feature in iOS5, it requires at least iOS5
* ARC 


## Samples

<img src="http://f.cl.ly/items/0n0R0t2E0y1z0W2T0o3Q/Screen%20Shot%202013-01-11%20at%204.39.56%20PM.png"/>

<img src="http://f.cl.ly/items/2L2K010b3E2n0o0R1m3P/Screen%20Shot%202013-01-11%20at%204.40.15%20PM.png"/>

<img src="http://f.cl.ly/items/1x3o2s3H0y0g3x043L00/Screen%20Shot%202013-01-11%20at%204.39.40%20PM.png"/>

