//
//  UIView+GuessIt.h
//  GuessIt
//
//  Created by Marlon Andrade on 13/08/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GuessIt)

- (UIImage *)gi_screenshot;
- (UIImage *)gi_screenshotScaled:(CGFloat)scale;

@end
