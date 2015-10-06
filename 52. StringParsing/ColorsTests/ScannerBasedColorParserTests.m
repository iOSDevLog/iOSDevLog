#import <XCTest/XCTest.h>
#import "ScannerBasedColorParser.h"

@interface ScannerBasedColorParserTests : XCTestCase

@end

@interface ScannerBasedColorParserTests ()

@property (nonatomic, strong) ScannerBasedColorParser *parser;

@end

@implementation ScannerBasedColorParserTests

- (void)setUp
{
    [super setUp];
    self.parser = [ScannerBasedColorParser new];
}

- (void)tearDown
{
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

@end
