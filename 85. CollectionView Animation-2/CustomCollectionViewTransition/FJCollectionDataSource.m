//
//  FJCollectionDataSource.m
//  CustomCollectionViewTransition
//
//  Created by Engin Kurutepe on 01/05/14.
//  Copyright (c) 2014 Fifteen Jugglers Software. All rights reserved.
//

#import "FJCollectionDataSource.h"

@implementation FJCollectionDataSource

- (instancetype)initWithColor:(UIColor*)color numberOfItems:(NSInteger)count
{
    self = [super init];
    
    if (self) {
        self.color = color;
        self.numberOfItems = count;
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _numberOfItems;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ColorCell" forIndexPath:indexPath];
    
    cell.backgroundColor = _color;
    
    UILabel *label = [cell viewWithTag:2];
    
    label.text = [NSString stringWithFormat:@"%d - %d", indexPath.section, indexPath.item];
    
    return cell;
}

@end
