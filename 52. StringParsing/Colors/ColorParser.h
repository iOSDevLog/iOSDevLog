//
// Created by chris on 26.01.14.
//

#import <Foundation/Foundation.h>

static const int FormatError = 100;
static NSString *MyErrorDomain = @"io.objc.parsing";

@interface ColorParser : NSObject

- (NSDictionary *)parse:(NSString *)string error:(NSError **)error;

@end
