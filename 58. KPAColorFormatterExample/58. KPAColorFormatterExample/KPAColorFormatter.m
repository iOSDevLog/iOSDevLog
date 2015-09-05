//
//  KPAColorFormatter.m
//  KPAColorFormatter
//
//  Created by Klaas Pieter Annema on 22-11-13.
//  Copyright (c) 2013 Annema. All rights reserved.
//

#import "KPAColorFormatter.h"

static NSDictionary *KPAColorFormatterDefaultColors;
static KPAColorFormatter *KPAColorFormatterReusableInstance;

@implementation KPAColorFormatter

+ (void)initialize;
{
    if (self != [KPAColorFormatter class]) {
        return;
    }

    NSURL *colorsURL = [[NSBundle bundleForClass:self.class] URLForResource:@"colors" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:colorsURL];
    NSDictionary *colorData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    NSMutableDictionary *colors = [NSMutableDictionary dictionary];
    [colorData enumerateKeysAndObjectsUsingBlock:^(NSString *rgb, NSString *name, BOOL *stop) {
        NSArray *components = [rgb componentsSeparatedByString:@","];
        CGFloat red = [components[0] doubleValue];
        CGFloat green = [components[1] doubleValue];
        CGFloat blue = [components[2] doubleValue];

        KPAColorClass *color = [KPAColorClass colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
        colors[color] = name;
    }];

    KPAColorFormatterDefaultColors = [colors copy];
}

- (id)init;
{
    return [self initWithColors:KPAColorFormatterDefaultColors];
}

- (void)awakeFromNib;
{
    self.colors = KPAColorFormatterDefaultColors;
}

- (id)initWithColors:(NSDictionary *)colors;
{
    self = [super init];
    if (self) {
        _colors = colors;
    }

    return self;
}

+ (NSString *)localizedStringFromColor:(KPAColorClass *)color;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KPAColorFormatterReusableInstance = [[KPAColorFormatter alloc] init];
    });

    return [KPAColorFormatterReusableInstance stringForObjectValue:color];
}

- (NSString *)stringForObjectValue:(id)value;
{
    if (![value isKindOfClass:[KPAColorClass class]]) {
        return nil;
    }

    NSString *name = [self.colors objectForKey:value];
    if (!name) {
        name = [self.colors objectForKey:[self colorClosestToColor:value]];
    }

    return [self localizedColorNameForEnglishName:name];
}

- (NSAttributedString *)attributedStringForObjectValue:(id)value withDefaultAttributes:(NSDictionary *)defaultAttributes;
{
    NSString *string = [self stringForObjectValue:value];

    if  (!string) {
        return nil;
    }

    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:defaultAttributes];
    attributes[NSForegroundColorAttributeName] = value;
    return [[NSAttributedString alloc] initWithString:string attributes:attributes];
}

- (KPAColorClass *)colorClosestToColor:(KPAColorClass *)color;
{
    CGFloat red1, green1, blue1;
    [color getRed:&red1 green:&green1 blue:&blue1 alpha:nil];

    __block CGFloat closestDelta = CGFLOAT_MAX;
    __block KPAColorClass *closestColor = nil;
    [[self.colors allKeys] enumerateObjectsUsingBlock:^(KPAColorClass *possibleColor, NSUInteger idx, BOOL *stop) {
        CGFloat red2, green2, blue2;
        [possibleColor getRed:&red2 green:&green2 blue:&blue2 alpha:nil];
        CGFloat deltaR = pow(red2 - red1, 2);
        CGFloat deltaG = pow(green2 - green1, 2);
        CGFloat deltaB = pow(blue2 - blue1, 2);
        CGFloat delta = deltaR + deltaG + deltaB;
        if (delta < closestDelta) {
            closestDelta = delta;
            closestColor = possibleColor;
        }
    }];

    return closestColor;
}

- (NSString *)localizedColorNameForEnglishName:(NSString *)name;
{
    NSString *languageCode = [self.locale objectForKey:NSLocaleLanguageCode];
    NSURL *bundleURL = [[NSBundle bundleForClass:self.class] URLForResource:languageCode withExtension:@"lproj"];
    NSBundle *languageBundle = [NSBundle bundleWithURL:bundleURL];
    return [languageBundle localizedStringForKey:name value:name table:nil];
}

- (BOOL)getObjectValue:(out __autoreleasing id *)obj forString:(NSString *)string errorDescription:(out NSString *__autoreleasing *)error;
{
    __block KPAColorClass *matchingColor = nil;
    [self.colors enumerateKeysAndObjectsUsingBlock:^(KPAColorClass *color, NSString *name, BOOL *stop) {
        if([name isEqualToString:string]) {
            matchingColor = color;
            *stop = YES;
        }
    }];

    if (matchingColor) {
        *obj = matchingColor;
        return YES;
    } else if (error) {
        *error = [NSString stringWithFormat:@"No known color for name: %@", string];
    }

    return NO;
}

- (NSLocale *)locale;
{
    if (!_locale) {
        _locale = [NSLocale currentLocale];
    }

    return _locale;
}

@end