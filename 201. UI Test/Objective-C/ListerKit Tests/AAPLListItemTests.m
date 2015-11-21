/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    The test case class for the \c AAPLListItem class.
*/

@import ListerKit;
@import XCTest;

@interface AAPLListItemTests : XCTestCase

@property (nonatomic, strong) AAPLListItem *item;

@end

@implementation AAPLListItemTests

#pragma mark - Setup

- (void)setUp {
    [super setUp];

    self.item = [[AAPLListItem alloc] initWithText:@"foo"];
}

#pragma mark - Initialization

- (void)testConvenienceTextAndCompleteInit {
    NSString *text = @"foo";
    BOOL complete = YES;
    
    AAPLListItem *item = [[AAPLListItem alloc] initWithText:text complete:complete];
    
    XCTAssertEqualObjects(item.text, text);
    XCTAssertEqual(item.isComplete, complete);
}

- (void)testConvenienceTextInit {
    NSString *text = @"foo";
    
    AAPLListItem *item = [[AAPLListItem alloc] initWithText:text];
    
    XCTAssertEqualObjects(item.text, text);
    
    // The default value for the complete state should be false.
    XCTAssertFalse(item.isComplete);
}

#pragma mark - NSCopying

- (void)testCopyingListItems {
    AAPLListItem *itemCopy = [self.item copy];
    
    XCTAssertEqualObjects(self.item, itemCopy);
}

#pragma mark - NSCoding

- (void)testEncodingListItems {
    NSData *archivedListItemData = [NSKeyedArchiver archivedDataWithRootObject:self.item];

    XCTAssertTrue(archivedListItemData.length > 0);
}

- (void)testDecodingListItems {
    NSData *archivedListItemData = [NSKeyedArchiver archivedDataWithRootObject:self.item];
    
    AAPLListItem *unarchivedListItem = [NSKeyedUnarchiver unarchiveObjectWithData:archivedListItemData];
    
    XCTAssertEqualObjects(unarchivedListItem, self.item);
}

#pragma mark - -refereshIdentity

- (void)testRefreshIdentity {
    AAPLListItem *itemCopy = [self.item copy];
    
    XCTAssertEqualObjects(itemCopy, self.item);
    
    [self.item refreshIdentity];
    
    XCTAssertNotEqualObjects(itemCopy, self.item);
}

#pragma mark - -isEqual:

- (void)testIsEqual {
    // -isEqual: should be strictly based of the underlying UUID of the list item.
    
    AAPLListItem *itemTwo = [[AAPLListItem alloc] initWithText:@"foo"];
    
    XCTAssertNotEqualObjects(self.item, nil);
    XCTAssertEqualObjects(self.item, self.item);
    XCTAssertNotEqualObjects(self.item, itemTwo);
}

@end
