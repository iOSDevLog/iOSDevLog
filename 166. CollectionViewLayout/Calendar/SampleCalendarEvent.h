//
//  SampleCalendarEvent.h
//  Calendar
//
//  Created by iosdevlog on 15/10/25.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarEvent.h"

@interface SampleCalendarEvent : NSObject <CalendarEvent>

+ (instancetype)randomEvent;
+ (instancetype)eventWithTitle:(NSString *)title day:(NSUInteger)day startHour:(NSUInteger)startHour durationInHours:(NSUInteger)durationInHours;
- (instancetype)initWithTitle:(NSString *)title day:(NSUInteger)day startHour:(NSUInteger)startHour durationInHours:(NSUInteger)durationInHours;

@end
