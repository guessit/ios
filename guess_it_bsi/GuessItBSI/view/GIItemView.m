//
//  GIItemView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 27/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIItemView.h"

#import "GIInputView.h"
#import "GIUserInterfaceCustomizations.h"
#import "UIView+SizingAndPositioning.h"
#import <QuartzCore/QuartzCore.h>

@interface GIItemView ()

@property (nonatomic, strong) UIView *imageViewFrame;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong, readwrite) GIInputView *inputView;

- (void)_initialize;

@end

@implementation GIItemView

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
        [self.imageViewFrame addSubview:_imageView];
    }
    return _imageView;
}

#pragma mark - Setter

- (void)setItem:(GIItem *)item {
    _item = item;

    if (item) {
        self.imageView.image = item.image;
        self.inputView.item = item;
        [self becomeFirstResponder];
    } else {
        self.imageView.alpha = 0.f;
        [self resignFirstResponder];
    }
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
    }

    return _inputView;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - NSObject Methods

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private Interface

- (void)_initialize {
    self.backgroundColor = GI_BACKGROUND_MAIN_COLOR;

    [self addSubview:self.imageViewFrame];
}

@end
