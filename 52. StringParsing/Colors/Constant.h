//
// Created by chris on 02.02.14.
//

#import <Foundation/Foundation.h>
#import "CPParser.h"

@class CPSyntaxTree;

@interface Constant : NSObject <CPParseResult>

@property (nonatomic, strong) id name;
@property (nonatomic, strong) id value;
- (instancetype)initWithSyntaxTree:(CPSyntaxTree *)syntaxTree;
- (NSString *)description;

@end
