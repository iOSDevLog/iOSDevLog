//
// Created by chris on 02.02.14.
//

#import "Constant.h"
#import "CPSyntaxTree.h"
#import "CPIdentifierToken.h"
#import "CPNumberToken.h"


@implementation Constant

- (instancetype)initWithSyntaxTree:(CPSyntaxTree *)syntaxTree
{
    self = [super init];
    if (self) {
        self.name = [[syntaxTree valueForTag:@"name"] identifier];
        self.value = [[[syntaxTree valueForTag:@"value"] valueForTag:@"num"] number];
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.name=%@", self.name];
    [description appendFormat:@", self.value=%@", self.value];
    [description appendString:@">"];
    return description;
}

@end
