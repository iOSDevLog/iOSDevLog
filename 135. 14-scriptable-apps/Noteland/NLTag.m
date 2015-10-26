//
//  NLTag.m
//  Noteland
//
//  Created by Brent Simmons on 6/23/14.
//  Copyright (c) 2014 Q Branch LLC. All rights reserved.
//

#import "NLTag.h"
#import "NLNote.h"


@implementation NLTag


#pragma mark - Init

- (instancetype)init {

	self = [super init];
	if (!self) {
		return nil;
	}

	_uniqueID = [[NSUUID UUID] UUIDString];

	return self;
}


- (NSUniqueIDSpecifier *)objectSpecifier {

	NSScriptClassDescription *noteClassDescription = (NSScriptClassDescription *)[self.note classDescription];
	NSUniqueIDSpecifier *noteSpecifier = (NSUniqueIDSpecifier *)[self.note objectSpecifier];
	
	return [[NSUniqueIDSpecifier alloc] initWithContainerClassDescription:noteClassDescription containerSpecifier:noteSpecifier key:@"tags" uniqueID:self.uniqueID];
}

@end
