//
//  GILevelView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 27/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevelView.h"

#import "GIConfiguration.h"
#import "GIDefinitions.h"
#import "GIInputView.h"
#import "GIInputViewDelegate.h"
#import "MALazykit.h"
#import "UIView+CBFrameHelpers.h"
#import "UIFont+GuessItFonts.h"
#import <QuartzCore/QuartzCore.h>

@interface GILevelView () <GIInputViewDelegate>

@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) UIView *imageViewFrame;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) GIInputView *inputView;

- (void)_initialize;

@end

@implementation GILevelView

#pragma mark - Getter

- (UILabel *)categoryLabel {
    if (!_categoryLabel) {
        GIUserInterfaceElement *ui = [GIConfiguration sharedInstance].game.interface.category;

        _categoryLabel = [UILabel labelWithFrame:CGRectMake(0.f, 0.f, self.width, GI_CATEGORY_HEIGHT)];
        _categoryLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _categoryLabel.backgroundColor = ui.backgroundColor;
        _categoryLabel.textColor = ui.textColor;
        _categoryLabel.shadowOffset = CGSizeMake(0.f, -1.f);
        _categoryLabel.shadowColor = ui.shadowColor;
        _categoryLabel.text = @"Category";
        _categoryLabel.textAlignment = NSTextAlignmentCenter;
        _categoryLabel.font = [UIFont guessItCategoryFont];
    }
    return _categoryLabel;
}

- (UIView *)imageViewFrame {
    if (!_imageViewFrame) {
        GIUserInterface *interface = [GIConfiguration sharedInstance].game.interface;

        _imageViewFrame = [UIView view];
        _imageViewFrame.backgroundColor = interface.image.backgroundColor;
        _imageViewFrame.layer.cornerRadius = 1.f;
        _imageViewFrame.layer.borderColor = [interface.frame.backgroundColor CGColor];
        _imageViewFrame.layer.borderWidth = 5.f;
    }
    return _imageViewFrame;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView viewWithFrame:CGRectInset(self.imageViewFrame.bounds, GI_IMAGE_FRAME_BORDER, GI_IMAGE_FRAME_BORDER)];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.imageViewFrame addSubview:_imageView];
    }
    return _imageView;
}

- (GIInputView *)inputView {
    if (!_inputView) {
        _inputView = [GIInputView viewWithFrame:CGRectMake(0.f, self.height - GI_INPUT_HEIGHT,
                                                           self.width, GI_INPUT_HEIGHT)];
        _inputView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _inputView.delegate = self;
    }
    return _inputView;
}

#pragma mark - Setter

- (void)setCurrentLevel:(GILevel *)currentLevel {
    _currentLevel = currentLevel;

    self.imageViewFrame.transform = CGAffineTransformIdentity;
    self.imageViewFrame.w = currentLevel.image.size.width + 2 * GI_IMAGE_FRAME_BORDER;
    self.imageViewFrame.h = currentLevel.image.size.height + 2 * GI_IMAGE_FRAME_BORDER;

    self.imageViewFrame.transform = CGAffineTransformMakeScale(0.05f, 0.05f);
    self.imageView.alpha = 0.f;
    self.inputView.alpha = 0.f;
    self.categoryLabel.alpha = 0.f;

    if (_currentLevel) {
        self.inputView.currentLevel = _currentLevel;
        self.imageView.image = _currentLevel.image;
        self.categoryLabel.text = _currentLevel.category;

        self.inputView.alpha = 1.f;
        if (self.imageView.image) self.imageView.alpha = 1.f;
        if (self.categoryLabel.text.length > 0) self.categoryLabel.alpha = 1.f;
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

    if (self.categoryLabel.alpha) center.y = center.y + (GI_CATEGORY_HEIGHT / 2.f);

    self.imageViewFrame.center = center;
}

#pragma mark - Private Interface

- (void)_initialize {
    self.backgroundColor = [GIConfiguration sharedInstance].game.interface.level.backgroundColor;

    [self addSubview:self.categoryLabel];
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
