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

- (NSArray*) detectFaceRects {
  
  CIDetector *faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
  
  CIImage *ciImage = [CIImage imageWithCGImage:[self CGImage]];
  NSArray *features = [faceDetector featuresInImage:ciImage options:nil];
  NSMutableArray *returnBounds = [NSMutableArray array];
  
  for (CIFeature *feature in features) {
    [returnBounds addObject:[NSValue valueWithCGRect:[feature bounds]]];
  }
  
  return [NSArray arrayWithArray:returnBounds];
  
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
  
  NSArray *faceRects = [self detectFaceRects];
  if (faceRects.count) {

    NSValue *value = faceRects[(NSUInteger)(faceRects.count/2)];
    CGRect faceRect = [value CGRectValue];
    // Change coordinate system
    faceRect.origin.y = self.size.height - faceRect.origin.y - faceRect.size.height;
    
    CGFloat xOffset = MAX((faceRect.origin.x + faceRect.size.width/2 - (size.width/(xRatio*2))), 0);
    CGFloat yOffset = MAX((faceRect.origin.y + faceRect.size.height/2 - (size.height/(yRatio*2))), 0);
    
    if ((xOffset + size.width/xRatio) > self.size.width)
      xOffset = self.size.width - size.width/xRatio;
    if ((yOffset + size.height/yRatio) > self.size.height)
      yOffset = self.size.height - size.height/yRatio;

    rect.origin.x = (rect.origin.x - xOffset * xRatio);
    rect.origin.y = (rect.origin.y - yOffset * yRatio);
  }

  UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
  [self drawInRect:rect];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
  
}

@end
