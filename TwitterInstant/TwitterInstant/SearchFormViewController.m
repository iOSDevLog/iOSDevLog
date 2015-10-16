//
//  SearchFormViewController.m
//  TwitterInstant
//
//  Created by JiaXianhua on 15/10/16.
//  Copyright © 2015年 iOSDevLog. All rights reserved.
//

#import "SearchFormViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SearchFormViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@end

@implementation SearchFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Twitter Instant";
    
    [[self.searchText.rac_textSignal map:^id(NSString *text) {
        return [self isValidSearchText:text] ? [UIColor whiteColor] : [UIColor yellowColor];
    }] subscribeNext:^(UIColor *color) {
        self.searchText.backgroundColor = color;
    }];
}

- (BOOL)isValidSearchText:(NSString *)text {
    return text.length > 2;
}

@end
