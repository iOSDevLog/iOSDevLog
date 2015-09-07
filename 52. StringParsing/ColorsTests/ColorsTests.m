//
//  ColorsTests.m
//  ColorsTests
//
//  Created by Chris Eidhof on 26.01.14.
//  Copyright (c) 2014 Chris Eidhof. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ColorParser.h"

@interface ColorsTests : XCTestCase

@end

@interface ColorsTests ()

@property (nonatomic, strong) ColorParser *parser;
@end

@implementation ColorsTests

- (void)setUp
{
    [super setUp];
    self.parser = [[ColorParser alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSError *error = nil;
    NSDictionary *result = [self.parser parse:@"backgroundColor = #ff0000\ntextColor = #0000ff" error:&error];
    NSDictionary *expected = @{@"backgroundColor": @"ff0000", @"textColor": @"0000ff"};
    XCTAssertNil(error);
    XCTAssertEqualObjects(result, expected);
}

- (void)testError
{
    NSError *error = nil;
    NSDictionary *result = [self.parser parse:@"backgroundColor1 = #ff000" error:&error];
    NSDictionary *expected = nil;
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(result, expected);
}

@end
