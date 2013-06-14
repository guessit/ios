//
//  GINavigationBar.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 27/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GINavigationBar.h"

#import "UIFont+GuessItFonts.h"
#import "UIImage+FromColor.h"

@interface GINavigationBar ()

- (void)_initialize;

@end

@implementation GINavigationBar

#pragma mark - UIView Methods

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initialize];
    }
    return self;
}

#pragma mark - Private Interface

- (void)_initialize {
    UILabel *label = [UILabel label];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont guessItNavigationTitleFont];
    label.textColor = GI_TITLE_COLOR;
    label.shadowColor = GI_TITLE_SHADOW_COLOR;
    label.shadowOffset = GI_TITLE_SHADOW_OFFSET;
    label.text = @"Guess It!";
    label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                             UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [label sizeToFit];
    label.center = self.center;

    [self addSubview:label];

    [self setBackgroundImage:[UIImage imageWithColor:GI_NAVIGATION_BACKGROUND_COLOR]
               forBarMetrics:UIBarMetricsDefault];
}

@end
