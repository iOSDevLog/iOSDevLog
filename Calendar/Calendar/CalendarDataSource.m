//
//  CalendarDataSource.m
//  Calendar
//
//  Created by iosdevlog on 15/10/25.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

#import "CalendarDataSource.h"
#import "HeaderView.h"
#import "SampleCalendarEvent.h"

static NSString * const reuseIdentifier = @"CalendarEventCell";
static NSString * const reuseHeaderIdentifier = @"HeaderView";

@interface CalendarDataSource ()

@property (strong, nonatomic) NSMutableArray *event;

@end

@implementation CalendarDataSource

#pragma mark - 

- (void)awakeFromNib {
    self.event = [[NSMutableArray alloc] init];
    
    [self generateOneData];
}

- (void)generateOneData {
    SampleCalendarEvent *event = [SampleCalendarEvent randomEvent];
    [self.event addObject:event];
}

- (id<CalendarEvent>)eventAtIndexPath:(NSIndexPath *)indexPath {
    return self.event[indexPath.item];
}

- (NSArray *)indexPathsOfEventsBetweenMinDayIndex:(NSInteger)minDayIndex maxDayIndex:(NSInteger)maxDayIndex minStartHour:(NSInteger)minStartHour maxStartHour:(NSInteger)maxStartHour {
    NSMutableArray *indexPaths = [NSMutableArray array];
    [self.event enumerateObjectsUsingBlock:^(id  _Nonnull event, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([event day] >= minDayIndex
            && [event day] <= maxDayIndex
            && [event startHour] >= minStartHour
            && [event startHour] <= maxStartHour    ) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
            [indexPaths addObject:indexPath];
        }
    }];
    
    return indexPaths;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.event.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<CalendarEvent> event = self.event[indexPath.item];
    CalendarEventCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, indexPath, event);
    }
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    HeaderView *headerView = (HeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseHeaderIdentifier forIndexPath:indexPath];
    
    if (self.configureHeaderViewBlock) {
        self.configureHeaderViewBlock(headerView, kind, indexPath);
    }
    
    return headerView;
}

@end
