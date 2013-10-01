//
//  GIBarButton.m
//  GuessIt
//
//  Created by Marlon Andrade on 30/09/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIBarButton.h"

#import "UIView+CBFrameHelpers.h"

@implementation GIBarButton

- (UIEdgeInsets)alignmentRectInsets {
    UIEdgeInsets insets = UIEdgeInsetsZero;

    if (floorf(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        if ([self _isLeftButton]) {
            insets = UIEdgeInsetsMake(0.f, 9.f, 0.f, 0.f);
        } else {
            insets = UIEdgeInsetsMake(0.f, 0.f, 0.f, 9.f);
        }
    }

    return insets;
}

- (BOOL)_isLeftButton {
    return self.x < (self.superview.width / 2.f);
}

@end
