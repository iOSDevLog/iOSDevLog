#import <XCTest/XCTest.h>
#import "ScannerBasedAdvancedColorParser.h"

@interface ScannerBasedAdvancedColorParserTests : XCTestCase

@end

@interface ScannerBasedAdvancedColorParserTests ()

@property (nonatomic, strong) ScannerBasedAdvancedColorParser *parser;
@end

@implementation ScannerBasedAdvancedColorParserTests

- (void)setUp
{
    [super setUp];
    self.parser = [ScannerBasedAdvancedColorParser new];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testRGBColor
{
    NSError *error = nil;
    NSDictionary *result = [self.parser parse:@"backgroundColor = #ff0000\ntextColor = (1, 2, 255)" error:&error];
    NSDictionary *expected = @{@"backgroundColor": [UIColor colorWithRed:1 green:0 blue:0 alpha:1], @"textColor": [UIColor colorWithRed:1/255. green:2/255. blue:1 alpha:1]};
    XCTAssertNil(error);
    XCTAssertEqualObjects(result, expected);
}

@end
