#import <XCTest/XCTest.h>
#import "Scanner.h"

@interface ScannerTests : XCTestCase

@end

@interface ScannerTests ()

@property (nonatomic, strong) Scanner *scanner;
@end

@implementation ScannerTests

- (void)setUp
{
    [super setUp];
    self.scanner = [[Scanner alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testExample
{
    NSString* example = @"myConstant = 100\nmyView.left = otherView.right + 10 * 2\nviewController.view.centerX + myConstant <= self.view.centerX";
    NSArray *result = [self.scanner tokenize:example];
    NSArray *expected = @[    @"myConstant", @"=", @100, @"myView", @".", @"left", @"=", @"otherView", @".", @"right",
            @"+", @10, @"*", @2, @"viewController", @".", @"view", @".", @"centerX", @"+", @"myConstant",
            @"<=", @"self", @".", @"view", @".", @"centerX"];
    XCTAssertEqualObjects(result, expected);
    
}

@end
