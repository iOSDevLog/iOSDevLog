//
//  CalendarCollectionViewController.m
//  Calendar
//
//  Created by iosdevlog on 15/10/25.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

#import "CalendarCollectionViewController.h"
#import "HeaderView.h"
#import "CalendarDataSource.h"

@interface CalendarCollectionViewController ()

@end

static NSString * const reuseHeaderIdentifier = @"HeaderView";

@implementation CalendarCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register NIB for supplementary views
    UINib *headerViewNib = [UINib nibWithNibName:@"HeaderView" bundle:nil];
    [self.collectionView registerNib:headerViewNib forSupplementaryViewOfKind:@"DayHeaderView" withReuseIdentifier:reuseHeaderIdentifier];
    [self.collectionView registerNib:headerViewNib forSupplementaryViewOfKind:@"HourHeaderView" withReuseIdentifier:reuseHeaderIdentifier];
    
    CalendarDataSource *dataSource = (CalendarDataSource *)self.collectionView.dataSource;
    dataSource.configureHeaderViewBlock = ^(HeaderView *headerView, NSString *kind, NSIndexPath *indexPath) {
        if ([kind isEqualToString:@"DayHeaderView"]) {
            headerView.titleLabel.text = [NSString stringWithFormat:@"Day %ld", (long)indexPath.item];
            headerView.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.1];
        } else if ([kind isEqualToString:@"HourHeaderView"]) {
            headerView.titleLabel.text = [NSString stringWithFormat:@"Hour %ld", (long)indexPath.item];
            headerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
        }
    };
}

@end
