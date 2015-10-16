//
//  ControlsViewController.m
//  objc-io-issue-15-ux-testing
//
//  Created by Klaas Pieter Annema on 14/08/14.
//  Copyright (c) 2014 Klaas Pieter Annema. All rights reserved.
//

#import "ControlsViewController.h"

@interface ControlsViewController ()
- (IBAction)updateStateLabel:(id)sender;
- (IBAction)changeSegment:(id)sender;
@end

@implementation ControlsViewController

- (IBAction)updateStateLabel:(id)sender;
{
    self.buttonStateLabel.text = @"Pressed";
}

- (IBAction)changeSegment:(id)sender
{
    self.segmentLabel.text = [NSString stringWithFormat:@"Segment %i", self.segmentedControl.selectedSegmentIndex];
}

@end