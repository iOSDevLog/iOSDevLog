//
//  NLNote.h
//  Noteland
//
//  Created by Brent Simmons on 6/23/14.
//  Copyright (c) 2014 Q Branch LLC. All rights reserved.
//

@import Cocoa;


@interface NLNote : NSObject


@property (nonatomic) NSString *uniqueID;
@property (nonatomic) NSString *text;
@property (nonatomic) NSDate *creationDate;
@property (nonatomic) BOOL archived;
@property (nonatomic) NSArray *tags;

@property (nonatomic, readonly) NSString *title;

@end
