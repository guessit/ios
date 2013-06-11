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
#import "UIView+SizingAndPositioning.h"
#import <QuartzCore/QuartzCore.h>

@interface GILevelView () <GIInputViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIView *imageViewFrame;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong, readwrite) GIInputView *inputView;

@property (nonatomic, strong) UIActionSheet *helpActionSheet;

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

- (UIActionSheet *)helpActionSheet {
    if (!_helpActionSheet) {
        _helpActionSheet = [[UIActionSheet alloc] initWithTitle:@"Help"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Remove Letter", @"Add Letter", @"Hint", @"Random Level", nil];
        _helpActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;

    }
    return _helpActionSheet;
}

#pragma mark - Setter

- (void)setCurrentLevel:(GILevel *)currentLevel {
    _currentLevel = currentLevel;

    self.imageViewFrame.transform = CGAffineTransformMakeScale(0.05f, 0.05f);

    if (_currentLevel) {
        self.imageView.image = _currentLevel.image;
        self.inputView.currentLevel = _currentLevel;
        [self becomeFirstResponder];
    } else {
        self.imageView.alpha = 0.f;
        [self resignFirstResponder];
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

#pragma mark - UIResponder Methods

- (UIView *)inputView {
    if (!_inputView) {
        _inputView = [GIInputView viewWithFrame:CGRectMake(0.f, 0.f, self.width, GI_INPUT_VIEW_HEIGHT)];
        _inputView.delegate = self;
    }

    return _inputView;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - Private Interface

- (void)_initialize {
    self.backgroundColor = GI_BACKGROUND_MAIN_COLOR;

    [self addSubview:self.imageViewFrame];
}

#pragma mark - GIInputViewDelegate Methods

- (void)inputView:(GIInputView *)inputView didFinishGuessingWithAnswer:(NSString *)answer {
    GIGuessingResult guessingResult = [self.currentLevel guessWithAnwser:answer];
    [self.levelDelegate levelView:self didFinishGuessingLevel:self.currentLevel withResult:guessingResult];
}

- (void)helpRequestedFromInputView:(GIInputView *)inputView {
    [self.helpActionSheet showInView:self.superview];
}

#pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Clicked: %d", buttonIndex);
}

@end
