//
//  ViewController.m
//  58. KPAColorFormatterExample
//
//  Created by jiaxianhua on 15/9/6.
//  Copyright © 2015年 jiaxianhua. All rights reserved.
//

#import "ViewController.h"
#import "KPAColorFormatter.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate> {
    NSArray *colorValues;
    NSArray *colorKeys;
}
@property (strong, nonatomic) KPAColorFormatter *colorFormatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _colorFormatter = [[KPAColorFormatter alloc] init];
    colorValues = [self.colorFormatter.colors allValues];
    colorKeys = [self.colorFormatter.colors allKeys];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.colorFormatter.colors.count;
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.view.backgroundColor = colorKeys[row];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return colorValues[row];
}

@end
