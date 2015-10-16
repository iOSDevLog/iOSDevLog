//
//  ViewController.m
//  ReactivePlayground
//
//  Created by JiaXianhua on 15/10/16.
//  Copyright © 2015年 jiaxianhua. All rights reserved.
//

#import "ViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInFailureText;

@property (nonatomic) BOOL passwordIsValid;
@property (nonatomic) BOOL usernameIsValid;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACSignal *usernameSourceSignal = self.usernameTextField.rac_textSignal;
    
    RACSignal *filteredUsername = [usernameSourceSignal filter:^BOOL(id value) {
        NSString *text = value;
        return text.length > 3;
    }];
    
    [filteredUsername subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

@end
