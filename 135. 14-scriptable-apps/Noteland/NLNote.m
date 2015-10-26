//
//  NLNote.m
//  Noteland
//
//  Created by Brent Simmons on 6/23/14.
//  Copyright (c) 2014 Q Branch LLC. All rights reserved.
//

#import "NLNote.h"
#import "NLTag.h"


@implementation NLNote


#pragma mark - Init

- (instancetype)init {

	self = [super init];
	if (!self) {
		return nil;
	}

	_uniqueID = [[NSUUID UUID] UUIDString];
	_creationDate = [NSDate date];
	_tags = [NSArray new];

	return self;
}


- (id)newScriptingObjectOfClass:(Class)objectClass forValueForKey:(NSString *)key withContentsValue:(id)contentsValue properties:(NSDictionary *)properties {

	NLTag *tag = (NLTag *)[super newScriptingObjectOfClass:objectClass forValueForKey:key withContentsValue:contentsValue properties:properties];
	tag.note = self;
	return tag;
}


- (NSUniqueIDSpecifier *)objectSpecifier {

	NSScriptClassDescription *appDescription = (NSScriptClassDescription *)[NSApp classDescription];
	return [[NSUniqueIDSpecifier alloc] initWithContainerClassDescription:appDescription containerSpecifier:nil key:@"notes" uniqueID:self.uniqueID];
}


- (NSString *)title {

	NSArray *components = [self.text componentsSeparatedByString:@"\n"];
	if (components) {
		return components[0];
	}
	return nil;
}


@end
