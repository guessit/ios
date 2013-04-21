//
//  GIShineLabel.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 21/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIShineLabel.h"

#import <QuartzCore/QuartzCore.h>

@interface GIShineLabel ()

@property (nonatomic, strong) UILabel *shineLabel;
@property (nonatomic, strong) CALayer *maskLayer;

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
    }
    return _shineLabel;
}

- (CALayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CALayer layer];
        _maskLayer.backgroundColor = [UIColor clearColor].CGColor;
        _maskLayer.contents = (id)[UIImage imageNamed:@"shine_mask"].CGImage;
        _maskLayer.contentsGravity = kCAGravityCenter;
    }
    return _maskLayer;
}

#pragma mark - Public Interface

- (void)flash {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;

    self.shineLabel.frame = CGRectMake(0.f, 1.f, width, height);
    self.shineLabel.text = self.text;
    self.shineLabel.textColor = self.shineColor;

    self.maskLayer.frame = CGRectMake(-width, 0, width * 1.25f, height);

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.byValue = @(width * 2.f);
    animation.duration = 3.f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;

    [self.layer addSublayer:self.shineLabel.layer];

    [self.maskLayer addAnimation:animation forKey:@"shine"];
}

#pragma mark - CAAnimation Delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.maskLayer removeAllAnimations];
    [self.shineLabel.layer removeFromSuperlayer];
}

@end
