//
//  CalendarCollectionViewController.m
//  Calendar
//
//  Created by iosdevlog on 15/10/25.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

#import "CalendarCollectionViewController.h"
#import "HeaderView.h"

@interface CalendarCollectionViewController ()

@end

static NSString * const reuseHeaderIdentifier = @"HeaderView";

@implementation CalendarCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register NIB for supplementary views
    UINib *headerViewNib = [UINib nibWithNibName:@"HeaderView" bundle:nil];
    [self.collectionView registerNib:headerViewNib forSupplementaryViewOfKind:@"DayHeaderView" withReuseIdentifier:reuseHeaderIdentifier];
}

@end
