With FaceFirst UIImage category, you can crop and resize an image to a specific size and if there are faces in the image, the cropped image will still include one of image. You can combine this category with UIImageView together to show any image with faces properly.

== How To Use ==

* Drag and drop UIImage+FaceFirst.h and UIImage+FaceFirst.m into your XCode project.
* Include CoreImage.framework in the libraries your project is linking to. 
* Use the following sample in your code:

    self.imageView.image = [[UIImage imageNamed:@"yourimage"]
                           faceFirstImageScaledToFillSize:self.imageView.frame.size];


== Basic Requirements ==

* iOS5: since it is using CIDetector feature in iOS5, it requires at least iOS5
* ARC 

