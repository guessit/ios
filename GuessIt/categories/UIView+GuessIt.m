//
//  UIView+GuessIt.m
//  GuessIt
//
//  Created by Marlon Andrade on 13/08/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "UIView+GuessIt.h"

@implementation UIView (GuessIt)

- (UIImage *)gi_screenshot {
    return [self gi_screenshotScaled:self.window.screen.scale];
}

- (UIImage *)gi_screenshotScaled:(CGFloat)scale {
    UIImage *screenshot = nil;

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return screenshot;
}

@end
