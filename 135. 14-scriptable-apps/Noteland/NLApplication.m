//
//  NLApplication.m
//  Noteland
//
//  Created by Brent Simmons on 6/25/14.
//  Copyright (c) 2014 Q Branch LLC. All rights reserved.
//

#import "NLApplication.h"
#import "NLNote.h"
#import "NLTag.h"


@interface NLApplication ()

@property (nonatomic) NSMutableArray *notes;

@end


@implementation NLApplication

@synthesize notes = _notes;


- (NSMutableArray *)notes {

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{

		NLNote *note0 = [NLNote new];
		note0.text = @"Note 0\nThis is text for note 0.";
		NLTag *tag0 = [NLTag new];
		tag0.name = @"Cats";
		tag0.note = note0;
		note0.tags = [@[tag0] mutableCopy];

		NLNote *note1 = [NLNote new];
		note1.text = @"Note 1\nThis is text for note 1.";
		NLTag *tag1 = [NLTag new];
		tag1.name = @"Tiger Swallowtail";
		tag1.note = note1;
		NLTag *tag2 = [NLTag new];
		tag2.name = @"Steak-frites";
		tag2.note = note1;
		note1.tags = [@[tag1, tag2] mutableCopy];

		_notes = [@[note0, note1] mutableCopy];
	});

	return _notes;
}


- (void)insertObject:(NLNote *)object inNotesAtIndex:(NSUInteger)index {

	[self.notes insertObject:object atIndex:index];
}


- (void)removeObjectFromNotesAtIndex:(NSUInteger)index {

	[self.notes removeObjectAtIndex:index];
}


@end
