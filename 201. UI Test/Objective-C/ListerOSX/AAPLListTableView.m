/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    An \c NSTableView subclass that ensures that the text field is always the first responder for an event.
*/

#import "AAPLListTableView.h"

@implementation AAPLListTableView

- (BOOL)validateProposedFirstResponder:(NSResponder *)responder forEvent:(NSEvent *)event {
    if ([responder isKindOfClass:[NSTextField class]]) {
        return YES;
    }

    return [super validateProposedFirstResponder:responder forEvent:event];
}

@end
