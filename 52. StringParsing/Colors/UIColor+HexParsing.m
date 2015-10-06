//
// Created by chris on 02.02.14.
//

#import "UIColor+HexParsing.h"


@implementation UIColor (HexParsing)


+ (instancetype)colorWithHexString:(NSString *)colorString
{
    NSAssert(colorString.length == 6, @"Color string should be six digits");
    // From: http://stackoverflow.com/questions/8697205/convert-hex-color-code-to-nscolor
    unsigned colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    NSScanner* scanner = [NSScanner scannerWithString:colorString];
    (void) [scanner scanHexInt:&colorCode];
    redByte = (unsigned char)(colorCode >> 16);
    greenByte = (unsigned char)(colorCode >> 8);
    blueByte = (unsigned char)(colorCode); // masks off high bits

    return   [UIColor colorWithRed:(CGFloat)redByte
                             green:(CGFloat)greenByte
                              blue:(CGFloat)blueByte
                             alpha:1.0];
}
@end
