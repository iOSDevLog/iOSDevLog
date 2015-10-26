//
//  TableViewDetailViewController.h
//  objc-io-issue-15-ux-testing
//
//  Created by Klaas Pieter Annema on 14/08/14.
//  Copyright (c) 2014 Klaas Pieter Annema. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewDetailViewController : UIViewController

@property (nonatomic, readwrite, copy) NSString *presentationKind;
@property (nonatomic, readwrite, assign) IBOutlet UILabel *presentationKindLabel;

@end
