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
  
  self.imageView1.image = [[UIImage imageNamed:self.items[row]]
                           faceFirstImageScaledToFillSize:self.imageView1.frame.size];

  self.imageView2.image = [[UIImage imageNamed:self.items[row]]
                           faceFirstImageScaledToFillSize:self.imageView2.frame.size];

  self.imageView3.image = [[UIImage imageNamed:self.items[row]]
                           faceFirstImageScaledToFillSize:self.imageView3.frame.size];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
