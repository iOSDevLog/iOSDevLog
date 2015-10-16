# Introduction

A UIStoryboard convenience category offering a standard way of naming components in UIStoryboards.

# Installation

Add the following to your [Podfile](http://docs.cocoapods.org/podfile.html):

    pod "KPAStoryboardConvenience"

# Usage

Set the name of your default storyboard using `setMainStoryboardName:`
Now access your storyboard anywhere in your app using `mainStoryboard`. 

Instantiate your view controllers using:

    [[UIStoryboard mainStoryboard] instantiateViewControllerForClass:[MyViewController class]];

You can also directly access the identifier for view controllers and segues:

- `+ (NSString *)storyboardIdentifierForClass:(Class)theClass;`
- `+ (NSString *)segueIdentifierForClass:(Class)theClass;`

All usage is documented in the [Spec](https://github.com/klaaspieter/KPAStoryboardConvenience/blob/master/Specs/UIStoryboard_KPAConvenienceSpec.m).
