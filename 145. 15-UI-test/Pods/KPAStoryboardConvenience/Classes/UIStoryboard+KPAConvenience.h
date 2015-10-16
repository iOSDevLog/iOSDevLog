//
//  UIStoryboard+KPAConvenience.h
//  KPAStoryboardConvenience
//
//  Created by Klaas Pieter Annema on 08-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (KPAConvenience)

+ (void)setMainStoryboardName:(NSString *)storyboardName;
+ (void)setMainStoryboardName:(NSString *)storyboardName bundle:(NSBundle *)bundle;
+ (UIStoryboard *)mainStoryboard;

+ (NSString *)storyboardIdentifierForClass:(Class)theClass;
- (id)instantiateViewControllerForClass:(Class)theClass;

+ (NSString *)segueIdentifierForClass:(Class)theClass;

+ (NSString *)reuseIdentifierForClass:(Class)theClass;

@end
