//
//  SampleCalendarEvent.m
//  Calendar
//
//  Created by iosdevlog on 15/10/25.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

#import "SampleCalendarEvent.h"


@implementation SampleCalendarEvent

@synthesize title = _title;
@synthesize day = _day;
@synthesize startHour = _startHour;
@synthesize durationInHours = _durationInHours;

+ (instancetype)randomEvent {
    uint32_t randomID = arc4random_uniform(10000);
    NSString *title = [NSString stringWithFormat:@"Event #%u", randomID];
    
    uint32_t randomDay = arc4random_uniform(7);
    uint32_t randomStartHour = arc4random_uniform(20);
    uint32_t randomDuration = arc4random_uniform(5) + 1;
    
    return [self eventWithTitle:title day:randomDay startHour:randomStartHour durationInHours:randomDuration];
}

+ (instancetype)eventWithTitle:(NSString *)title day:(NSUInteger)day startHour:(NSUInteger)startHour durationInHours:(NSUInteger)durationInHours {
    return [[self alloc] initWithTitle:title day:day startHour:startHour durationInHours:durationInHours];
}

- (instancetype)initWithTitle:(NSString *)title day:(NSUInteger)day startHour:(NSUInteger)startHour durationInHours:(NSUInteger)durationInHours {
    self = [super init];
    if (self != nil) {
        _title = [title copy];
        _day = day;
        _startHour = startHour;
        _durationInHours = durationInHours;
    }
    return self;
}
@end
