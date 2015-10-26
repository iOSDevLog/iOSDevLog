//
//  ControlsViewController.h
//  objc-io-issue-15-ux-testing
//
//  Created by Klaas Pieter Annema on 14/08/14.
//  Copyright (c) 2014 Klaas Pieter Annema. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlsViewController : UIViewController

@property (nonatomic, readwrite, weak) IBOutlet UIButton *button;
@property (nonatomic, readwrite, weak) IBOutlet UILabel *buttonStateLabel;

@property (nonatomic, readwrite, weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, readwrite, weak) IBOutlet UILabel *segmentLabel;

@end
