//
//  CalendarEvent.h
//  Calendar
//
//  Created by iosdevlog on 15/10/25.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CalendarEvent <NSObject>
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger day;
@property (assign, nonatomic) NSInteger startHour;
@property (assign, nonatomic) NSInteger durationInHours;
@end
