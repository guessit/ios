//
//  GILetterView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILetterView.h"

#import "GIDefinitions.h"
#import "GIConfiguration.h"
#import "MALazykit.h"
#import "UIFont+GuessItFonts.h"
#import "UIView+CBFrameHelpers.h"

@interface GILetterView ()

@property (nonatomic, strong) UILabel *label;

- (void)_initialize;

@end

@implementation GILetterView

#pragma mark - Getter

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel labelWithFrame:self.bounds];
        _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [GIConfiguration sharedInstance].game.interface.letterTextColor;
        _label.shadowColor = [GIConfiguration sharedInstance].game.interface.letterShadowColor;
        _label.shadowOffset = CGSizeMake(0.f, -1.f);
        _label.textAlignment = NSTextAlignmentCenter;
    }

    return _label;
}

- (NSString *)letter {
    return self.label.text;
}

#pragma mark - Setter

- (void)setLetter:(NSString *)letter {
    self.label.text = [letter uppercaseString];
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

    CGFloat fontSize = self.label.font.pointSize;
    CGSize size = [self.label.text sizeWithFont:self.label.font];
    while (size.height > self.label.height) {
        fontSize--;
        size = [self.label.text sizeWithFont:[UIFont fontWithName:self.label.font.fontName size:fontSize]];
    }

    UIFont *font = [UIFont guessItKeypadLetterFont];
    if (fontSize < self.label.font.pointSize) {
        font = [UIFont fontWithName:font.fontName size:fontSize + 1];
    }

    self.label.font = font;
}

#pragma mark - Private Interface

- (void)_initialize {
    [self reset];
    [self addSubview:self.label];
}

#pragma mark - Public Interface

- (void)reset {
    self.backgroundColor = [GIConfiguration sharedInstance].game.interface.letterBackgroundColor;
    self.transform = CGAffineTransformIdentity;
}

- (void)zoomIn {
    [UIView animateWithDuration:0.2f animations:^{
        self.transform = CGAffineTransformMakeScale(GI_LETTER_ZOOMED_SCALE, GI_LETTER_ZOOMED_SCALE);
        self.backgroundColor = [GIConfiguration sharedInstance].game.interface.letterSelectedColor;
        self.label.textColor = [GIConfiguration sharedInstance].game.interface.letterSelectedTextColor;
    }];
}

- (void)zoomOut {
    [UIView animateWithDuration:0.2f animations:^{
        self.transform = CGAffineTransformIdentity;
        self.backgroundColor = [GIConfiguration sharedInstance].game.interface.letterBackgroundColor;
        self.label.textColor = [GIConfiguration sharedInstance].game.interface.letterTextColor;
    }];
}

- (void)minimize {
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.3f animations:^{
        self.transform = CGAffineTransformMakeScale(GI_LETTER_MINIMIZED_SCALE, GI_LETTER_MINIMIZED_SCALE);
        self.backgroundColor = [GIConfiguration sharedInstance].game.interface.letterBackgroundColor;
        self.label.textColor = [GIConfiguration sharedInstance].game.interface.letterTextColor;
        self.alpha = 0.f;
    }];
}

- (void)restore {
    [UIView animateWithDuration:0.3f animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.f;
    }];
}

@end
