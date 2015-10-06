//
// Created by chris on 26.01.14.
//

#import "ColorParser.h"


@implementation ColorParser


- (NSDictionary *)parse:(NSString *)input error:(NSError **)error
{
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"(\\w+) = #([\\p{Hex_Digit}]{6})" options:0 error:NULL];
    NSArray *lines = [input componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (NSString *line in lines) {
        NSTextCheckingResult *textCheckingResult = [expression firstMatchInString:line options:0 range:NSMakeRange(0, line.length)];
        if (!textCheckingResult) {
            NSDictionary *errorDetail = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Couldn't parse line: %@", line]};
            *error = [NSError errorWithDomain:MyErrorDomain code:FormatError userInfo:errorDetail];
            return nil;
        }
        NSString* key = [line substringWithRange:[textCheckingResult rangeAtIndex:1]];
        NSString* value = [line substringWithRange:[textCheckingResult rangeAtIndex:2]];
        result[key] = value;
    }
    return result;
}

@end
