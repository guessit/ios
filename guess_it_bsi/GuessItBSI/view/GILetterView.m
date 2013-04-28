//
//  GILetterView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILetterView.h"

#import "UIFont+GuessItFonts.h"

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
        _label.textColor = GI_LETTER_TEXT_COLOR;
        _label.shadowColor = GI_LETTER_SHADOW_COLOR;
        _label.shadowOffset = CGSizeMake(0.f, -1.f);
        _label.font = [UIFont guessItKeypadLetterFont];
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

#pragma mark - Private Interface

- (void)_initialize {
    self.backgroundColor = GI_LETTER_COLOR;
    [self addSubview:self.label];
}

#pragma mark - Public Interface

- (void)zoomIn {
    [UIView animateWithDuration:0.2f animations:^{
        self.transform = CGAffineTransformMakeScale(GI_LETTER_ZOOMED_SCALE, GI_LETTER_ZOOMED_SCALE);
        self.backgroundColor = GI_LETTER_ZOOMED_COLOR;
        self.label.textColor = GI_LETTER_ZOOMED_TEXT_COLOR;
    }];
}

- (void)zoomOut {
    [UIView animateWithDuration:0.2f animations:^{
        self.transform = CGAffineTransformIdentity;
        self.backgroundColor = GI_LETTER_COLOR;
        self.label.textColor = GI_LETTER_TEXT_COLOR;
    }];
}

@end
