//
//  FJDetailViewController.h
//  CollectionViewAnimations
//
//  Created by Engin Kurutepe on 27/04/14.
//  Copyright (c) 2014 Fifteen Jugglers Software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FJSectionColor) {
    FJSectionColorRed,
    FJSectionColorGreen,
    FJSectionColorBlue
};

@interface FJDetailViewController : UICollectionViewController

@property (nonatomic) FJSectionColor color;
@property (nonatomic) NSInteger itemCount;


@end
