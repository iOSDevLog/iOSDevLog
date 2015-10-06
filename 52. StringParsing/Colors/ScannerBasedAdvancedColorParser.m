//
// Created by chris on 02.02.14.
//

#import "ScannerBasedAdvancedColorParser.h"
#import "ColorParser.h"
#import "UIColor+HexParsing.h"


@interface ScannerBasedAdvancedColorParser ()

@property (nonatomic, strong) NSScanner *scanner;
@end

@implementation ScannerBasedAdvancedColorParser

- (NSDictionary *)parse:(NSString *)string error:(NSError **)error
{
    self.scanner = [NSScanner scannerWithString:string];
    self.scanner.charactersToBeSkipped = [NSCharacterSet whitespaceCharacterSet];

    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    while (!self.scanner.isAtEnd) {
        NSString *key = nil;
        UIColor *value = nil;
        BOOL didScan = [self.scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&key] &&
                       [self.scanner scanString:@"=" intoString:NULL] &&
                       [self scanColor:&value];

        if (!didScan) {
            NSDictionary *errorDetail = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Couldn't parse: %u", self.scanner.scanLocation]};
            *error = [NSError errorWithDomain:MyErrorDomain code:FormatError userInfo:errorDetail];
            return nil;
        }
        result[key] = value;
        [self.scanner scanCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:NULL]; // scan an optional newline
    }
    return result;
}

- (BOOL)scanColor:(UIColor **)out
{
    return [self scanHexColorIntoColor:out] || [self scanTupleColorIntoColor:out];
}

- (BOOL)scanTupleColorIntoColor:(UIColor **)out
{
    NSInteger red, green, blue = 0;
    BOOL didScan = [self.scanner scanString:@"(" intoString:NULL]
            && [self.scanner scanInteger:&red]
            && [self.scanner scanString:@"," intoString:NULL]
            && [self.scanner scanInteger:&green]
            && [self.scanner scanString:@"," intoString:NULL]
            && [self.scanner scanInteger:&blue]
            && [self.scanner scanString:@")" intoString:NULL];
    if (didScan) {
        *out = [UIColor colorWithRed:(CGFloat)red/255. green:(CGFloat)green/255. blue:(CGFloat)blue/255. alpha:1];
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)scanHexColorIntoColor:(UIColor **)out
{
    NSCharacterSet *hexadecimalCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefABCDEF"];
    NSString *colorString = NULL;
    if ([self.scanner scanString:@"#" intoString:NULL] &&
            [self.scanner scanCharactersFromSet:hexadecimalCharacterSet intoString:&colorString] &&
            colorString.length == 6
            ) {
        *out = [UIColor colorWithHexString:colorString];
        return YES;
    }
    return NO;
}

@end
