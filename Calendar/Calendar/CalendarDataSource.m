//
//  CalendarDataSource.m
//  Calendar
//
//  Created by iosdevlog on 15/10/25.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

#import "CalendarDataSource.h"
#import "HeaderView.h"

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseHeaderIdentifier = @"HeaderView";

@implementation CalendarDataSource

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    HeaderView *headerView = (HeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:@"DayHeaderView" withReuseIdentifier:reuseHeaderIdentifier forIndexPath:indexPath];
    return headerView;
}

@end
