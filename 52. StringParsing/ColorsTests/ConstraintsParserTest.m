#import <XCTest/XCTest.h>
#import "ConstraintsParser.h"
#import "Constant.h"
#import "Expression.h"

@interface ConstraintsParserTest : XCTestCase

@end

@interface ConstraintsParserTest ()

@property (nonatomic, strong) ConstraintsParser *parser;
@end

@implementation ConstraintsParserTest

- (void)setUp
{
    [super setUp];
    self.parser = [[ConstraintsParser alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testExample
{
    Constant *result = [self.parser parse:@"x = 10"];
    XCTAssertEqualObjects(result.name, @"x");
    XCTAssertEqualObjects(result.value, @10);
}

- (void)testConstraint
{
    Expression *result = [self.parser parse:@"viewController.view.centerX + 20 <= self.view.centerX * 0.5"];
    NSLog(@"result: %@", result);
}

@end
