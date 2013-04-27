//
//  GILetterView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/24/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILetterView.h"

#import "GIUserInterfaceCustomizations.h"
#import "UIFont+GuessItFonts.h"

#define GI_LETTER_ZOOMED_SCALE 1.15f
#define GI_LETTER_ZOOMED_COLOR [UIColor colorWithWhite:0.25 alpha:1.f]
#define GI_LETTER_ZOOMED_TEXT_COLOR [UIColor colorWithWhite:0.95 alpha:1.f]

#define GI_LETTER_COLOR GI_BACKGROUND_MAIN_COLOR
#define GI_LETTER_TEXT_COLOR [UIColor colorWithWhite:0.88f alpha:1.f]

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
        _label.shadowColor = [UIColor colorWithWhite:0.38f alpha:1.f];
        _label.shadowOffset = CGSizeMake(0.f, -1.f);
        _label.font = [UIFont guessItKeypadLetterFont];
        _label.textAlignment = NSTextAlignmentCenter;

        [self addSubview:_label];
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

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
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

#pragma mark - Private Interface

- (void)_initialize {
    self.backgroundColor = GI_LETTER_COLOR;
}

@end
