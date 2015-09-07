//
// Created by chris on 01.02.14.
//

#import <Foundation/Foundation.h>


@interface ScannerBasedColorParser : NSObject

- (NSDictionary *)parse:(NSString *)string error:(NSError **)error;

@end
