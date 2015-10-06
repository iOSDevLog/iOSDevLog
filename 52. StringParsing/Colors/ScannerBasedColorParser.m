//
// Created by chris on 01.02.14.
//

#import "ScannerBasedColorParser.h"
#import "ColorParser.h"
#import "UIColor+HexParsing.h"


@interface ScannerBasedColorParser ()

@end

@implementation ScannerBasedColorParser


- (NSDictionary *)parse:(NSString *)string error:(NSError **)error
{
    NSScanner *scanner = [NSScanner scannerWithString:string];
    scanner.charactersToBeSkipped = [NSCharacterSet whitespaceCharacterSet];
    
    // todo scanhexint
    NSCharacterSet *hexadecimalCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefABCDEF"];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    while (!scanner.isAtEnd) {
        NSString *key = nil;
        NSString *value = nil;
        BOOL didScan = [scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&key] &&
                       [scanner scanString:@"=" intoString:NULL] &&
                       [scanner scanString:@"#" intoString:NULL] &&
                       [scanner scanCharactersFromSet:hexadecimalCharacterSet intoString:&value];
        if (!didScan) {
            NSDictionary *errorDetail = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Couldn't parse: %u", scanner.scanLocation]};
            *error = [NSError errorWithDomain:MyErrorDomain code:FormatError userInfo:errorDetail];
            return nil;
        }
        result[key] = value;
        [scanner scanCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:NULL]; // scan an optional newline
    }
    return result;
}



@end
