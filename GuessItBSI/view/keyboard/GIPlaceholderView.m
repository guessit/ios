//
//  GIPlaceholderView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIPlaceholderView.h"

#import <QuartzCore/QuartzCore.h>

@interface GIPlaceholderView ()

@property (nonatomic, strong) GILetterView *letterView;

- (void)_initialize;

@end

@implementation GIPlaceholderView

#pragma mark - Getter

- (NSString *)letter {
    NSString *letter = nil;

    if (self.subviews.count > 0) {
        letter = self.letterView.letter;
    }

    return letter;
}

#pragma mark - Setter

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
    self.backgroundColor = GI_ANSWER_PLACEHOLDER_COLOR;
    self.layer.cornerRadius = 3.f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1.f, 1.f);
    self.layer.shadowOpacity = 0.05f;
}

#pragma mark - Public Interface

- (BOOL)canDisplayLetterView {
    return self.subviews.count == 0;
}

- (void)displayLetterView:(GILetterView *)letterView {
    self.letterView = letterView;

    self.letterView.transform = CGAffineTransformIdentity;
    self.letterView.oldFrame = self.letterView.frame;
    self.letterView.frame = CGRectInset(self.bounds, 2.f, 2.f);
    self.letterView.alpha = 0.f;

    [self.letterView removeFromSuperview];
    [self addSubview:self.letterView];

    self.letterView.transform = CGAffineTransformMakeScale(GI_LETTER_MINIMIZED_SCALE, GI_LETTER_MINIMIZED_SCALE);

    [UIView animateWithDuration:0.2f animations:^{
        self.letterView.alpha = 1.f;
        self.letterView.transform = CGAffineTransformMakeScale(GI_LETTER_ZOOMED_SCALE, GI_LETTER_ZOOMED_SCALE);
        self.letterView.backgroundColor = GI_LETTER_ZOOMED_COLOR;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f animations:^{
            self.letterView.transform = CGAffineTransformIdentity;
            self.letterView.backgroundColor = GI_LETTER_COLOR;
        }];
    }];
}

@end
