//
//  GILevelView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 27/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevelView.h"

#import "GIConfiguration.h"
#import "GIInputView.h"
#import "GIInputViewDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface GILevelView () <GIInputViewDelegate>

@property (nonatomic, strong) UIView *imageViewFrame;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) GIInputView *inputView;

- (void)_initialize;

@end

@implementation GILevelView

#pragma mark - Getter

- (UIView *)imageViewFrame {
    if (!_imageViewFrame) {
        _imageViewFrame = [UIView viewWithFrame:CGRectMake(0.f, 0.f, 220.f, 220.f)];
        _imageViewFrame.backgroundColor = [UIColor whiteColor];
        _imageViewFrame.layer.cornerRadius = 1.f;
        _imageViewFrame.layer.borderColor = [GI_BACKGROUND_MAIN_DARKER_COLOR CGColor];
        _imageViewFrame.layer.borderWidth = 5.f;
    }
    return _imageViewFrame;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView viewWithFrame:CGRectInset(self.imageViewFrame.bounds, 10.f, 10.f)];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.imageViewFrame addSubview:_imageView];
    }
    return _imageView;
}

- (GIInputView *)inputView {
    if (!_inputView) {
        _inputView = [GIInputView viewWithFrame:CGRectMake(0.f, self.height - GI_INPUT_VIEW_HEIGHT,
                                                           self.width, GI_INPUT_VIEW_HEIGHT)];
        _inputView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _inputView.delegate = self;
    }
    return _inputView;
}

#pragma mark - Setter

- (void)setCurrentLevel:(GILevel *)currentLevel {
    _currentLevel = currentLevel;

    self.imageViewFrame.transform = CGAffineTransformMakeScale(0.05f, 0.05f);

    if (_currentLevel) {
        self.imageView.image = _currentLevel.image;
        self.inputView.currentLevel = _currentLevel;
    } else {
        self.imageView.alpha = 0.f;
        self.inputView.alpha = 0.f;
    }

    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.imageViewFrame.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.imageViewFrame.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
    }];
}

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

- (void)layoutSubviews {
    [super layoutSubviews];

    CGPoint center = self.center;
    center.y = (self.height - self.inputView.height) / 2.f;

    self.imageViewFrame.center = center;
}

#pragma mark - Private Interface

- (void)_initialize {
    self.backgroundColor = GI_BACKGROUND_MAIN_COLOR;

    [self addSubview:self.imageViewFrame];
    [self addSubview:self.inputView];
}

#pragma mark - GIInputViewDelegate Methods

- (void)inputView:(GIInputView *)inputView didFinishGuessingWithAnswer:(NSString *)answer {
    GIGuessingResult guessingResult = [self.currentLevel guessWithAnwser:answer];
    [self.levelDelegate levelView:self didFinishGuessingLevel:self.currentLevel withResult:guessingResult];
}

- (void)helpRequestedFromInputView:(GIInputView *)inputView {
    [self.levelDelegate didRequestHelpFromLevelView:self];
}

@end
