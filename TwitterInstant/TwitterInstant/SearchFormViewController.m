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
#import <Accounts/Accounts.h>
#import <Social/Social.h>

typedef NS_ENUM(NSInteger, RWTwitterInstantError) {
    RWTwitterInstantErrorAccessDenied,
    RWTwitterInstantErrorNoTwitterAccounts,
    RWTwitterInstantErrorInvalidResponse
};
static NSString * const RWTwitterInstantDomain = @"TwitterInstant";

@interface SearchFormViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchText;

@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) ACAccountType *twitterAccountType;
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
