//
//  GIGlowButton.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 03/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIGlowButton.h"

#import <QuartzCore/QuartzCore.h>

@interface GIGlowButton ()

@property (nonatomic, strong) UILabel *glowLabel;
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, strong) CABasicAnimation *animation;

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
        _glowLabel.textAlignment = self.titleLabel.textAlignment;
        _glowLabel.backgroundColor = [UIColor clearColor];
        _glowLabel.layer.mask = self.maskLayer;

        [self.titleLabel.layer addSublayer:self.glowLabel.layer];
    }
    return _glowLabel;
}

- (CALayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CALayer layer];
        _maskLayer.backgroundColor = [UIColor clearColor].CGColor;
        _maskLayer.backgroundColor = [UIColor cyanColor].CGColor;
        _maskLayer.contents = (id)[UIImage imageNamed:@"shine_mask"].CGImage;
        [_maskLayer addAnimation:self.animation forKey:@"glow"];
    }
    return _maskLayer;
}

- (CABasicAnimation *)animation {
    if (!_animation) {
        _animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _animation.delegate = self;
        _animation.repeatCount = HUGE_VALF;
        _animation.removedOnCompletion = NO;
    }
    return _animation;
}

#pragma mark - UIView Methods

- (void)layoutSubviews {
    [super layoutSubviews];

    self.glowLabel.frame = self.bounds;
    self.glowLabel.text = self.titleLabel.text;
    self.glowLabel.font = self.titleLabel.font;
    self.glowLabel.textColor = self.glowColor;

    self.maskLayer.frame = self.bounds;
}

#pragma mark - Public Interface

- (void)glow {
    self.animation.duration = self.glowDuration > 0.f ? self.glowDuration : 3.f;
    self.animation.fromValue = @(1.f);
    self.animation.toValue = @(0.25f);
}

@end
