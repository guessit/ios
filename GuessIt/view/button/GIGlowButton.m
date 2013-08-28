//
//  GIGlowButton.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 03/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIGlowButton.h"

#import "MALazykit.h"
#import <QuartzCore/QuartzCore.h>

@interface GIGlowButton ()

@property (nonatomic, strong) UILabel *glowLabel;

@end

@implementation GIGlowButton

#pragma mark - Getter

- (UIColor *)glowColor {
    if (!_glowColor) {
        _glowColor = [UIColor whiteColor];
    }
    return _glowColor;
}

- (UILabel *)glowLabel {
    if (!_glowLabel ) {
        _glowLabel = [UILabel label];
        _glowLabel.font = self.titleLabel.font;
        _glowLabel.textAlignment = NSTextAlignmentCenter;
        _glowLabel.contentMode = UIViewContentModeTop;
        _glowLabel.backgroundColor = [UIColor clearColor];

        [self.titleLabel addSubview:_glowLabel];
    }
    return _glowLabel;
}

#pragma mark - UIView Methods

- (void)layoutSubviews {
    [super layoutSubviews];

    self.glowLabel.frame = self.titleLabel.bounds;
    self.glowLabel.text = self.titleLabel.text;
    self.glowLabel.font = self.titleLabel.font;
    self.glowLabel.textColor = self.glowColor;
}

#pragma mark - Public Interface

- (void)glow {
    self.glowLabel.alpha = 0.f;

    UIViewAnimationOptions animationOptions = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionCurveEaseInOut;
    [UIView animateWithDuration:1.f delay:0.f options:animationOptions animations:^{
        self.glowLabel.alpha = 0.3f;
    } completion:NULL];
}

@end
