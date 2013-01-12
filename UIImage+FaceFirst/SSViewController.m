//
//  SSViewController.m
//  UIImage+FaceFirst
//
//  Created by Shen Steven on 1/9/13.
//  Copyright (c) 2013 syshen. All rights reserved.
//

#import "SSViewController.h"
#import "UIImage+FaceFirst.h"

@interface SSViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) NSArray *items;
@end

@implementation SSViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.items = @[@"", @"beatles.jpg", @"beatles2.jpg", @"ma.jpg", @"ma2.jpg", @"obama.jpg", @"obama2.jpg", @"obama3.jpg", @"obama4.jpg", @"JeremyLin.jpg", @"JeremyLin2.jpg", @"nature.jpg", @"nature2.jpg", @"nature3.jpg"];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return self.items.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  
  return self.items[row];
  
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  if (row == 0)
    return;
  
  __weak SSViewController *wSelf = self;
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImage *image = [[UIImage imageNamed:wSelf.items[row]] faceFirstImageScaledToFillSize:wSelf.imageView1.frame.size];
    dispatch_async(dispatch_get_main_queue(), ^{
      wSelf.imageView1.image = image;
    });
  });
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImage *image = [[UIImage imageNamed:wSelf.items[row]] faceFirstImageScaledToFillSize:wSelf.imageView2.frame.size];
    dispatch_async(dispatch_get_main_queue(), ^{
      wSelf.imageView2.image = image;
    });

  });
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImage *image = [[UIImage imageNamed:wSelf.items[row]] faceFirstImageScaledToFillSize:wSelf.imageView3.frame.size];
    dispatch_async(dispatch_get_main_queue(), ^{
      wSelf.imageView3.image = image;
    });

  });

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
