//
//  CalendarLayout.m
//  Calendar
//
//  Created by iosdevlog on 15/10/25.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

#import "CalendarLayout.h"
#import "CalendarEvent.h"
#import "CalendarDataSource.h"

static const NSUInteger DaysPerWeek = 7;
static const NSUInteger HoursPerDay = 24;
static const CGFloat HorizontalSpacing = 10;
static const CGFloat HeightPerHour = 50;
static const CGFloat DayHeaderHeight = 40;
static const CGFloat HourHeaderWidth = 100;

@implementation CalendarLayout

#pragma mark - UICollectionViewLayout

- (CGSize)collectionViewContentSize {
    // Don't scroll horizontally
    CGFloat contentWidth = self.collectionView.bounds.size.width;
    
    // Scroll vertically to dispaya full day
    CGFloat contentHeight = DayHeaderHeight + (HeightPerHour * HoursPerDay);
    
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    
    return contentSize;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    // Supplementry views
    NSArray *dayHeaderIndexPaths = [self indexPathsOfDayHeaderViewsInRect:rect];
    for (NSIndexPath *indexPath in dayHeaderIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:@"DayHeaderView" atIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    NSArray *hourHeaderIndexPaths = [self indexPathsOfHourHeaderViewsInRect:rect];
    for (NSIndexPath *indexPath in hourHeaderIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:@"HourHeaderView" atIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    // Cells
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarDataSource *dataSource = self.collectionView.dataSource;
    id<CalendarEvent> event = [dataSource eventAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = [self frameForEvent:event];
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    CGFloat totolWidth = [self collectionViewContentSize].width;
    
    if ([elementKind isEqualToString:@"DayHeaderView"]) {
        CGFloat alailableWidth = totolWidth - HourHeaderWidth;
        CGFloat widthPerDay = alailableWidth / DaysPerWeek;
        attributes.frame = CGRectMake(HourHeaderWidth + (widthPerDay * indexPath.item), 0, widthPerDay, DayHeaderHeight);
        attributes.zIndex = -10;
    } else if ([elementKind isEqualToString:@"HourHeaderView"]) {
        attributes.frame =  CGRectMake(0, DayHeaderHeight + (HeightPerHour * indexPath.item), totolWidth, HeightPerHour);
        attributes.zIndex = -10;
    }
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Helpers

- (NSArray *)indexPathsOfItemsInRect:(CGRect)rect {
    NSInteger minVisibleDay = [self dayIndexFromXCoordinate:CGRectGetMinX(rect)];
    NSInteger maxVisibleDay = [self dayIndexFromXCoordinate:CGRectGetMaxX(rect)];
    NSInteger minVisibleHour = [self hourIndexFromYCoordinate:CGRectGetMinY(rect)];
    NSInteger maxVisibleHour = [self hourIndexFromYCoordinate:CGRectGetMaxY(rect)];
    
    CalendarDataSource *dataSource = self.collectionView.dataSource;
    NSArray *indexPaths = [dataSource indexPathsOfEventsBetweenMinDayIndex:minVisibleDay maxDayIndex:maxVisibleDay minStartHour:minVisibleHour maxStartHour:maxVisibleHour];
    return indexPaths;
}

- (NSInteger)dayIndexFromXCoordinate:(CGFloat)xPosition {
    CGFloat contentWidth = [self collectionViewContentSize].width - HourHeaderWidth;
    CGFloat widthPerDay = contentWidth / DaysPerWeek;
    NSInteger dayIndex = MAX((NSInteger)0, (NSInteger)((xPosition - HourHeaderWidth) / widthPerDay));
    return dayIndex;
}

- (NSInteger)hourIndexFromYCoordinate:(CGFloat)yPosition {
    NSInteger hourIndex = MAX((NSInteger)0, (NSInteger)((yPosition - DayHeaderHeight) / HeightPerHour));
    return hourIndex;
}

- (NSArray *)indexPathsOfDayHeaderViewsInRect:(CGRect)rect {
    if (CGRectGetMinY(rect) > DayHeaderHeight) {
        return [NSArray array];
    }
    
    NSInteger minDayIndex = [self dayIndexFromXCoordinate:CGRectGetMinX(rect)];
    NSInteger maxDayIndex = [self dayIndexFromXCoordinate:CGRectGetMaxX(rect)];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger idx = minDayIndex; idx <= maxDayIndex; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

- (NSArray *)indexPathsOfHourHeaderViewsInRect:(CGRect)rect {
    if (CGRectGetMinX(rect) > HourHeaderWidth) {
        return [NSArray array];
    }
    
    NSInteger minHourIndex = [self hourIndexFromYCoordinate:CGRectGetMinY(rect)];
    NSInteger maxHourIndex = [self hourIndexFromYCoordinate:CGRectGetMaxY(rect)];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger idx = minHourIndex; idx <= maxHourIndex; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

- (CGRect)frameForEvent:(id<CalendarEvent>)event {
    CGFloat totalWidth = [self collectionViewContentSize].width - HourHeaderWidth;
    CGFloat widthPerDay = totalWidth / DaysPerWeek;
    
    CGRect frame = CGRectZero;
    frame.origin.x = HourHeaderWidth + widthPerDay * event.day;
    frame.origin.y = DayHeaderHeight + HeightPerHour * event.startHour;
    frame.size.width = widthPerDay;
    frame.size.height = event.durationInHours * HeightPerHour;
    
    frame = CGRectInset(frame, HorizontalSpacing/2.0, 0);
    return frame;
}

@end
