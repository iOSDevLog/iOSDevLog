//
//  SearchFormViewController.m
//  TwitterInstant
//
//  Created by JiaXianhua on 15/10/16.
//  Copyright © 2015年 iOSDevLog. All rights reserved.
//

#import "SearchFormViewController.h"

@interface SearchFormViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@end

@implementation SearchFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Twitter Instant";
}

@end
