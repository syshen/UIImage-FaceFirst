//
//  UIImage+FaceFirst.m
//  UIImage+FaceFirst
//
//  Created by Shen Steven on 1/9/13.
//  Copyright (c) 2013 syshen. All rights reserved.
//

#import "UIImage+FaceFirst.h"
#import <CoreImage/CoreImage.h>
#import <objc/runtime.h>

@implementation UIImage (FaceFirst)

- (NSArray*) detectFaceRectsInCIImage:(CIImage*)ciImage withContext:(CIContext*)context {
  
  CIDetector *faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
  
  // CIImage *ciImage = [CIImage imageWithCGImage:[self CGImage]];
  NSArray *features = [faceDetector featuresInImage:ciImage options:nil];
  NSMutableArray *returnBounds = [NSMutableArray array];
  
  for (CIFeature *feature in features) {
    [returnBounds addObject:[NSValue valueWithCGRect:[feature bounds]]];
  }
  
  return [NSArray arrayWithArray:returnBounds];
  
}

+ (CIContext *)processingContext {
  
  static CIContext *ctx = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    ctx = [CIContext contextWithOptions:nil];
  });
  
  return ctx;
  
}

- (UIImage *)faceFirstImageScaledToFillSize:(CGSize)size {
  
  CGRect rect;
  
  if (CGSizeEqualToSize(self.size, size))
    return self;
  
  CGFloat aspect = self.size.width / self.size.height;
  if (size.width / aspect >= size.height)
    rect.size = CGSizeMake(size.width, size.width/aspect);
  else
    rect.size = CGSizeMake(size.height * aspect, size.height);

  rect.origin = CGPointMake(0.0f, 0.0f);
  CGFloat xRatio = rect.size.width / self.size.width;
  CGFloat yRatio = rect.size.height / self.size.height;
  
  CIContext *context = [[self class] processingContext];
  
  CIImage *ciImage = [CIImage imageWithCGImage:[self CGImage]];
  NSArray *faceRects = [self detectFaceRectsInCIImage:ciImage withContext:context];
  if (faceRects.count) {

    NSValue *value = faceRects[(NSUInteger)(faceRects.count/2)];
    CGRect faceRect = [value CGRectValue];
    
    CGFloat xOffset = MAX((faceRect.origin.x + faceRect.size.width/2 - (size.width/(xRatio*2))), 0);
    CGFloat yOffset = MAX((faceRect.origin.y + faceRect.size.height/2 - (size.height/(yRatio*2))), 0);
    
    if ((xOffset + size.width/xRatio) > self.size.width)
      xOffset = self.size.width - size.width/xRatio;
    if ((yOffset + size.height/yRatio) > self.size.height)
      yOffset = self.size.height - size.height/yRatio;

    rect.origin.x = (rect.origin.x + xOffset * xRatio);
    rect.origin.y = (rect.origin.y + yOffset * yRatio);
    rect.size = size;
  } else {
    rect.origin.x = 0.0f;
    rect.origin.y = 0.0f;
    rect.size = size;
  }

  CIFilter *resizeFilter = [CIFilter filterWithName:@"CILanczosScaleTransform"];
  [resizeFilter setValue:ciImage forKey:@"inputImage"];
  [resizeFilter setValue:[NSNumber numberWithFloat:1.0f] forKey:@"inputAspectRatio"];
  [resizeFilter setValue:[NSNumber numberWithFloat:xRatio] forKey:@"inputScale"];
 
  CIFilter *cropFilter = [CIFilter filterWithName:@"CICrop"];
  CIVector *cropRect = [CIVector vectorWithX:rect.origin.x Y:rect.origin.y Z:rect.size.width W:rect.size.height];
  [cropFilter setValue:resizeFilter.outputImage forKey:@"inputImage"];
  [cropFilter setValue:cropRect forKey:@"inputRectangle"];
  CIImage *croppedImage = cropFilter.outputImage;

  CGImageRef cgImg = [context createCGImage:croppedImage fromRect:[croppedImage extent]];

  UIImage *returnedImage = [UIImage imageWithCGImage:cgImg scale:1.0f orientation:UIImageOrientationUp];
  CGImageRelease(cgImg);
  
  return returnedImage;
  
}

@end
