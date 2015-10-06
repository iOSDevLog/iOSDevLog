//
// Created by chris on 02.02.14.
//

#import "Expression.h"
#import "NSArray+Utilities.h"


@interface Expression ()

@property (nonatomic, strong) NSArray *keyPath;
@property (nonatomic) NSLayoutAttribute attribute;
@property (nonatomic) double multiplier;
@property (nonatomic) double constant;
@end

@implementation Expression

- (id)initWithSyntaxTree:(CPSyntaxTree *)syntaxTree
{
    self = [super init];
    if (self) {
        NSArray *keypathAndAttribute = [syntaxTree childAtIndex:0];
        NSArray *multiplier = [syntaxTree childAtIndex:1];
        NSArray *constant = [syntaxTree childAtIndex:2];
        self.keyPath = [keypathAndAttribute arrayByRemovingLastObject];
        self.attribute = (NSLayoutAttribute) [[keypathAndAttribute lastObject] integerValue];
        self.multiplier = multiplier.count ? [multiplier.lastObject doubleValue] : 1;
        self.constant = constant.count ? [constant.lastObject doubleValue] : 0;
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.keyPath=%@", self.keyPath];
    [description appendFormat:@", self.attribute=%d", self.attribute];
    [description appendFormat:@", self.multiplier=%f", self.multiplier];
    [description appendFormat:@", self.constant=%f", self.constant];
    [description appendString:@">"];
    return description;
}


@end
