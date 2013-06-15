//
//  GIShineLabel.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 21/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIShineLabel.h"

#import "MALazykit.h"
#import <QuartzCore/QuartzCore.h>

@interface GIShineLabel ()

@property (nonatomic, strong) UILabel *shineLabel;
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation GIShineLabel

#pragma mark - Getter

- (UIColor *)shineColor {
    if (!_shineColor) {
        _shineColor = [UIColor whiteColor];
    }
    return _shineColor;
}

- (UILabel *)shineLabel {
    if (!_shineLabel) {
        _shineLabel = [UILabel label];
        _shineLabel.font = self.font;
        _shineLabel.textAlignment = self.textAlignment;
        _shineLabel.backgroundColor = [UIColor clearColor];
        _shineLabel.layer.mask = self.maskLayer;

        [self.layer addSublayer:self.shineLabel.layer];
    }
    return _shineLabel;
}

- (CALayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CALayer layer];
        _maskLayer.backgroundColor = [UIColor clearColor].CGColor;
        _maskLayer.contents = (id)[UIImage imageNamed:@"shine_mask"].CGImage;
        _maskLayer.contentsGravity = kCAGravityCenter;
        [_maskLayer addAnimation:self.animation forKey:@"shine"];
    }
    return _maskLayer;
}

- (CABasicAnimation *)animation {
    if (!_animation) {
        _animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _animation.repeatCount = HUGE_VALF;
        _animation.removedOnCompletion = NO;
    }
    return _animation;
}

#pragma mark - UIView Methods

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;

    self.shineLabel.frame = CGRectMake(0.f, 1.f, width, height);
    self.shineLabel.text = self.text;
    self.shineLabel.textColor = self.shineColor;

    self.maskLayer.frame = CGRectMake(-width, 0, width * 1.25f, height);
}

#pragma mark - Public Interface

- (void)flash {
    CGFloat width = self.bounds.size.width;

    self.animation.duration = self.shineDuration > 0.f ? self.shineDuration : 3.f;
    self.animation.fromValue = @(-width * 0.25f);
    self.animation.toValue = @(width * 1.25f);
}

@end
