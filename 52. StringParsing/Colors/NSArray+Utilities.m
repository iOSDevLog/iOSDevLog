//
// Created by chris on 02.02.14.
//

#import "NSArray+Utilities.h"


@implementation NSArray (Utilities)


- (NSArray *)arrayByRemovingLastObject
{
    if (self.count == 0) return self;
    return [self subarrayWithRange:NSMakeRange(0, self.count-1)];

}
@end
