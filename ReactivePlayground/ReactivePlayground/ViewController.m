//
//  ViewController.m
//  ReactivePlayground
//
//  Created by JiaXianhua on 15/10/16.
//  Copyright © 2015年 jiaxianhua. All rights reserved.
//

#import "ViewController.h"

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
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
