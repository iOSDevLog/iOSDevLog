//
//  FJCollectionDataSource.h
//  CustomCollectionViewTransition
//
//  Created by Engin Kurutepe on 01/05/14.
//  Copyright (c) 2014 Fifteen Jugglers Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJCollectionDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic) NSInteger numberOfItems;
@property (nonatomic, strong) UIColor *color;

- (instancetype)initWithColor:(UIColor*)color numberOfItems:(NSInteger)count;

@end
