//
// Created by chris on 02.02.14.
//

#import <Foundation/Foundation.h>


@interface ScannerBasedAdvancedColorParser : NSObject


- (NSDictionary *)parse:(NSString *)string error:(NSError **)error;
@end
