//
//  TableViewDetailViewController.m
//  objc-io-issue-15-ux-testing
//
//  Created by Klaas Pieter Annema on 14/08/14.
//  Copyright (c) 2014 Klaas Pieter Annema. All rights reserved.
//

#import "TableViewDetailViewController.h"

@interface TableViewDetailViewController ()

@end

@implementation TableViewDetailViewController

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];

    NSAssert(self.presentationKind, @"%@ cannot be presented without a presentation kind",
             NSStringFromClass(self.class));

    self.presentationKindLabel.text = self.presentationKind;
}

@end
