//
//  NLTag.h
//  Noteland
//
//  Created by Brent Simmons on 6/23/14.
//  Copyright (c) 2014 Q Branch LLC. All rights reserved.
//

@import Cocoa;


@class NLNote;


@interface NLTag : NSObject

@property (nonatomic) NSString *uniqueID;
@property (nonatomic) NSString *name;
@property (nonatomic, weak) NLNote *note;

@end
