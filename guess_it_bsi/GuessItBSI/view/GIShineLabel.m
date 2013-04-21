//
//  GIShineLabel.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 21/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIShineLabel.h"

#import <QuartzCore/QuartzCore.h>

@implementation GIShineLabel

#pragma mark - Getter

- (UIColor *)shineColor {
    if (!_shineColor) {
        _shineColor = [UIColor whiteColor];
    }
    return _shineColor;
}

#pragma mark - Public Interface

- (void)flash {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;

    UILabel *shineLabel = [UILabel labelWithFrame:CGRectMake(0.f, 1.f, self.bounds.size.width, self.bounds.size.height)];
    shineLabel.font = self.font;
    shineLabel.text = self.text;
    shineLabel.textColor = self.shineColor;
    shineLabel.backgroundColor = [UIColor clearColor];
    shineLabel.textAlignment = NSTextAlignmentCenter;

    CALayer *mask = [CALayer layer];
    mask.backgroundColor = [UIColor clearColor].CGColor;
    mask.contents = (id) [UIImage imageNamed:@"shine_mask"].CGImage;
    mask.contentsGravity = kCAGravityCenter;
    mask.frame = CGRectMake(-width, 0, width * 1.25f, height);

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.byValue = @(width * 2.f);
    animation.repeatCount = HUGE_VALF;
    animation.duration = 3.f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CALayer *shineLayer = shineLabel.layer;
    [self.layer addSublayer:shineLayer];
    shineLayer.mask = mask;

    [mask addAnimation:animation forKey:@"shine"];
}

@end
