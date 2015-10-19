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
    
    self.accountStore = [[ACAccountStore alloc] init];
    self.twitterAccountType = [self.accountStore
                               accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];

    RAC(self.searchText, backgroundColor) = [self.searchText.rac_textSignal map:^id(NSString *text) {
        return [self isValidSearchText:text] ? [UIColor whiteColor] : [UIColor yellowColor];
    }];
    
    @weakify(self)
    
    
    [[[[self requestAccessToTwitterSignal]
       then:^RACSignal *{
           @strongify(self)
           return self.searchText.rac_textSignal;
       }]
      filter:^BOOL(NSString *text) {
          @strongify(self)
          return [self isValidSearchText:text];
      }]
     subscribeNext:^(id x) {
         NSLog(@"%@", x);
     } error:^(NSError *error) { 
         NSLog(@"An error occurred: %@", error); 
     }];
}

- (BOOL)isValidSearchText:(NSString *)text {
    return text.length > 2;
}

- (RACSignal *)requestAccessToTwitterSignal {
    // 1 - define an error
    NSError *accessError = [NSError errorWithDomain:RWTwitterInstantDomain
                                               code:RWTwitterInstantErrorAccessDenied
                                           userInfo:nil];
    // 2 - create the signal
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id subscriber) {
        // 3 - request access to twitter
        @strongify(self)
        [self.accountStore requestAccessToAccountsWithType:self.twitterAccountType
                                                   options:nil
                                                completion:^(BOOL granted, NSError *error) {
                                                    // 4 - handle the response
                                                    if (!granted) {
                                                        [subscriber sendError:accessError]; 
                                                    }
                                                    else {
                                                        [subscriber sendNext:nil]; 
                                                        [subscriber sendCompleted]; 
                                                    } 
                                                }]; 
        return nil; 
    }]; 
}

@end
