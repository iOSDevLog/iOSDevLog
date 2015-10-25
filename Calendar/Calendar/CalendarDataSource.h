//
//  CalendarDataSource.h
//  Calendar
//
//  Created by iosdevlog on 15/10/25.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "HeaderView.h"

typedef void(^ConfigureHeaderViewBlock)(HeaderView *headerView, NSString *kind, NSIndexPath *indexPath);

@interface CalendarDataSource : NSObject <UICollectionViewDataSource>

@property (copy, nonatomic) ConfigureHeaderViewBlock configureHeaderViewBlock;

@end
