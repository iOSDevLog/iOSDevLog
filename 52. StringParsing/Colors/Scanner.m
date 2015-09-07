//
//  Scanner.m
//  Parsers
//
//  Created by Chris Eidhof on 09.01.14.
//  Copyright (c) 2014 Chris Eidhof. All rights reserved.
//

#import "Scanner.h"
#import "CPKeywordToken.h"
#import "CPIdentifierToken.h"
#import "CPNumberToken.h"
#import "CPEOFToken.h"

@interface Scanner ()

@property (nonatomic, copy) NSArray *operators;
@property (nonatomic, strong) NSArray *reserved;
@end

@implementation Scanner

- (id)init
{
    self = [super init];
    if (self) {
        self.operators = @[@"=", @"+", @"*", @">=", @"<=", @"."];
        self.reserved = @[@"left", @"right", @"top", @"bottom", @"leading", @"trailing", @"width", @"height", @"centerX", @"centerY", @"baseline"];
    }

    return self;
}


- (NSArray *)tokenize:(NSString *)contents
{
    NSScanner *scanner = [NSScanner scannerWithString:contents];
    NSMutableArray *tokens = [NSMutableArray array];

    while (![scanner isAtEnd]) {
        NSUInteger startLocation = scanner.scanLocation;
        for (NSString *operator in self.operators) {
            if ([scanner scanString:operator intoString:NULL]) {
                [tokens addObject:[CPKeywordToken tokenWithKeyword:operator]];
            }
        }
        NSString *result = nil;
        if ([scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&result]) {
            NSString *rest = nil;
            [scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet] intoString:&rest];
            NSString *identifier = [result stringByAppendingString:rest ?: @""];
            BOOL isReserved =[self.reserved containsObject:identifier];
            [tokens addObject:isReserved ? [CPKeywordToken tokenWithKeyword:identifier] : [CPIdentifierToken tokenWithIdentifier:identifier]];
        }
        double doubleResult = 0;
        if ([scanner scanDouble:&doubleResult]) {
            NSNumber *number = @(doubleResult);
            [tokens addObject:[CPNumberToken tokenWithNumber:number]];
        }
        NSAssert(scanner.scanLocation != startLocation, @"Should have made progress: %d", scanner.scanLocation);
    }
    [tokens addObject:[CPEOFToken eof]];
    return tokens;
}

@end
