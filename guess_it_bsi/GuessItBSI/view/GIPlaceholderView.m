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
    return self.letterView.letter;
}

- (GILetterView *)letterView {
    if (!_letterView) {
        _letterView = [GILetterView viewWithFrame:self.bounds];
        _letterView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    }
    return _letterView;
}

#pragma mark - Setter

- (void)setLetter:(NSString *)letter {
    if (letter) {
        self.letterView.letter = letter;

        [UIView animateWithDuration:0.1f animations:^{
            self.letterView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.05f animations:^{
                self.letterView.transform = CGAffineTransformIdentity;
            }];
        }];
    } else {
        [UIView animateWithDuration:0.05f animations:^{
            self.letterView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1f animations:^{
                self.letterView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
            } completion:^(BOOL finished) {
                self.letterView.letter = letter;
            }];
        }];
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

    self.letterView.frame = CGRectInset(self.bounds, 2.f, 2.f);
}

#pragma mark - Private Interface

- (void)_initialize {
    self.backgroundColor = GI_ANSWER_PLACEHOLDER_COLOR;
    self.layer.cornerRadius = 3.f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1.f, 1.f);
    self.layer.shadowOpacity = 0.05f;

    [self addSubview:self.letterView];
}

@end
