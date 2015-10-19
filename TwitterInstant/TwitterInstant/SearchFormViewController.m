//
//  SearchFormViewController.m
//  TwitterInstant
//
//  Created by JiaXianhua on 15/10/16.
//  Copyright © 2015年 iOSDevLog. All rights reserved.
//

#import "SearchFormViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <RACEXTScope.h>

@interface SearchFormViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@end

@implementation SearchFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Twitter Instant";
    
    RAC(self.searchText, backgroundColor) = [self.searchText.rac_textSignal map:^id(NSString *text) {
        return [self isValidSearchText:text] ? [UIColor whiteColor] : [UIColor yellowColor];
    }];
}

- (BOOL)isValidSearchText:(NSString *)text {
    return text.length > 2;
}

@end
