//
// Created by chris on 26.01.14.
//

#import "ConstraintsParser.h"
#import "CPTokeniser.h"
#import "Scanner.h"
#import "CPGrammar.h"
#import "CPParser.h"
#import "CPLALR1Parser.h"
#import "Constant.h"
#import "CPKeywordRecogniser.h"
#import "CPIdentifierToken.h"
#import "CPNumberToken.h"


@interface ConstraintsParser () <CPParserDelegate>

@property (nonatomic, strong) NSDictionary *layoutAttributes;
@property (nonatomic, strong) NSDictionary *layoutRelations;
@end

@implementation ConstraintsParser

- (id)init
{
    self = [super init];
    if (self) {
        self.layoutAttributes = @{
                @"left": @(NSLayoutAttributeLeft),
                @"right":@(NSLayoutAttributeRight),
                @"top": @(NSLayoutAttributeTop),
                @"bottom": @(NSLayoutAttributeBottom),
                @"leading": @(NSLayoutAttributeLeading),
                @"trailing": @(NSLayoutAttributeTrailing),
                @"width": @(NSLayoutAttributeWidth),
                @"height": @(NSLayoutAttributeHeight),
                @"centerX": @(NSLayoutAttributeCenterX),
                @"centerY": @(NSLayoutAttributeCenterY),
                @"baseline": @(NSLayoutAttributeBaseline),
        };
        self.layoutRelations = @{
            @"=": @(NSLayoutRelationEqual),
            @"<=": @(NSLayoutRelationLessThanOrEqual),
            @">=": @(NSLayoutRelationGreaterThanOrEqual),
        };
    }

    return self;
}


- (id)parse:(NSString *)string
{
    Scanner *scanner = [[Scanner alloc] init];
    NSArray *tokens = [scanner tokenize:string];
    CPTokenStream *stream = [CPTokenStream tokenStreamWithTokens:tokens];
    NSString* grammarString = [@[
            @"Atom ::= num@'Number' | ident@'Identifier';",
            @"Relation ::= '=' | '>=' | '<=';",
            @"Attribute ::= 'left' | 'right' | 'top' | 'bottom' | 'leading' | 'trailing' | 'width' | 'height' | 'centerX' | 'centerY' | 'baseline';",
            @"Multiplier ::= '*' num@'Number';",
            @"AddConstant ::= '+' num@'Number';",
            @"KeypathAndAttribute ::= 'Identifier' '.' <AttributeOrRest>;",
            @"AttributeOrRest ::= att@<Attribute> | 'Identifier' '.' <AttributeOrRest>;",
            @"Expression ::= <KeypathAndAttribute> <Multiplier>? <AddConstant>?;",
            @"LayoutConstraint ::= lhs@<Expression> rel@<Relation> rhs@<Expression>;",
            @"Rule ::= <LayoutConstraint>;",
    ] componentsJoinedByString:@"\n"];
    NSError *error = nil;
    CPGrammar *grammar = [CPGrammar grammarWithStart:@"LayoutConstraint" backusNaurForm:grammarString error:&error];
    if (nil == grammar) {
        NSLog(@"error: %@", error.localizedDescription);
        NSAssert(NO,@"");
    }
    CPParser *parser = [CPLALR1Parser parserWithGrammar:grammar];
    parser.delegate = self;
    Constant *result = [parser parse:stream];
    return result;
}

- (id)parser:(CPParser *)parser didProduceSyntaxTree:(CPSyntaxTree *)syntaxTree
{
    NSString *ruleName = syntaxTree.rule.name;
    if ([ruleName isEqualToString:@"Attribute"]) {
        return self.layoutAttributes[[[syntaxTree childAtIndex:0] keyword]];
    } else if ([ruleName isEqualToString:@"KeypathAndAttribute"]) {
        CPIdentifierToken *start = [syntaxTree childAtIndex:0];
        return [@[[start identifier]] arrayByAddingObjectsFromArray:[syntaxTree childAtIndex:2]];
    } else if ([ruleName isEqualToString:@"AttributeOrRest"]) {
        id attribute = [syntaxTree valueForTag:@"att"];
        if (attribute) {
            return @[attribute];
        } else {
            id identifier = [[syntaxTree childAtIndex:0] identifier];
            return [@[identifier] arrayByAddingObjectsFromArray:[syntaxTree childAtIndex:2]];
        }
    } else if ([ruleName isEqualToString:@"Multiplier"] || [ruleName isEqualToString:@"AddConstant"]) {
        return [[syntaxTree valueForTag:@"num"] number];
    } else if ([ruleName isEqualToString:@"Relation"]) {
        return self.layoutRelations[[[syntaxTree childAtIndex:0] keyword]];
    }
    return syntaxTree;
}

- (CPRecoveryAction *)parser:(CPParser *)parser didEncounterErrorOnInput:(CPTokenStream *)inputStream
{
    NSLog(@"error: %@", parser);
    return nil;
}

- (CPRecoveryAction *)parser:(CPParser *)parser didEncounterErrorOnInput:(CPTokenStream *)inputStream expecting:(NSSet *)acceptableTokens
{
    NSLog(@"did encounter error, %@, expecting: %@", inputStream, acceptableTokens);
    return nil;
}

@end
