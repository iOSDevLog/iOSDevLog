//
//  FJFlowLayoutWithPopAnimations.h
//  CollectionViewAnimations
//
//  Created by Engin Kurutepe on 26/04/14.
//  Copyright (c) 2014 Fifteen Jugglers Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJFlowLayoutWithAnimations : UICollectionViewFlowLayout

- (void)resizeItemAtIndexPath:(NSIndexPath*)indexPath withPinchDistance:(CGFloat)distance;
- (void)resetPinchedItem;

@end
