//
//  UIStoryboard+KPAConvenience.m
//  KPAStoryboardConvenience
//
//  Created by Klaas Pieter Annema on 08-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "UIStoryboard+KPAConvenience.h"

static NSString *mainStoryboardName;
static NSBundle *mainStoryboardBundle;

@implementation UIStoryboard (KPAConvenience)

+ (void)setMainStoryboardName:(NSString *)storyboardName;
{
    [self setMainStoryboardName:storyboardName bundle:nil];
}

+ (void)setMainStoryboardName:(NSString *)storyboardName bundle:(NSBundle *)bundle;
{
    mainStoryboardName = storyboardName;
    mainStoryboardBundle = bundle;
}

+ (UIStoryboard *)mainStoryboard;
{
    return [self storyboardWithName:mainStoryboardName bundle:mainStoryboardBundle];
}

+ (NSString *)storyboardIdentifierForClass:(Class)theClass;
{
    return NSStringFromClass(theClass);
}

- (id)instantiateViewControllerForClass:(Class)theClass;
{
    NSString *identifier = [self.class storyboardIdentifierForClass:theClass];
    return [self instantiateViewControllerWithIdentifier:identifier];
}

+ (NSString *)segueIdentifierForClass:(Class)theClass;
{
    return [NSStringFromClass(theClass) stringByAppendingString:@"Segue"];
}

+ (NSString *)reuseIdentifierForClass:(Class)theClass;
{
    return [NSStringFromClass(theClass) stringByAppendingString:@"ReuseIdentifier"];
}

@end
