//
//  GIKeypadView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/24/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIKeypadView.h"

#import "GILetterView.h"
#import "GIUserInterfaceCustomizations.h"
#import "NSString+RandomString.h"
#import "UIView+SizingAndPositioning.h"

#define GI_KEYPAD_NO_ROWS 2
#define GI_KEYPAD_NO_COLUMNS 7
#define GI_KEYPAD_PADDING 3.f
#define GI_KEYPAD_ACTION_WIDTH 50.f

@interface GIKeypadView ()

@property (nonatomic, strong) UIView *lettersContainer;
@property (nonatomic, strong) NSMutableArray *letterViews;
@property (nonatomic, strong, readonly) NSString *letters;

- (void)_initialize;
- (void)_generateKeypad;

@end

@implementation GIKeypadView

#pragma mark - Getter

- (UIView *)lettersContainer {
    if (!_lettersContainer) {
        _lettersContainer = [UIView view];
//        _lettersContainer.backgroundColor = [UIColor clearColor];
        _lettersContainer.backgroundColor = [UIColor greenColor];

        [self addSubview:_lettersContainer];
    }
    return _lettersContainer;
}

- (NSMutableArray *)letterViews {
    if (!_letterViews) {
        NSInteger numberOfKeys = GI_KEYPAD_NO_ROWS * GI_KEYPAD_NO_COLUMNS;
        NSMutableArray *views = [NSMutableArray arrayWithCapacity:numberOfKeys];

        for (NSInteger i = 0; i < numberOfKeys; i++) {
            GILetterView *letterView = [GILetterView view];
            letterView.backgroundColor = [UIColor redColor];
            [self.lettersContainer addSubview:letterView];
            [views addObject:letterView];
        }

        _letterViews = views;
    }
    return _letterViews;
}

- (NSString *)letters {
    NSString *letters = @"";

    for (GILetterView *letterView in self.letterViews) {
        letters = [letters stringByAppendingString:letterView.letter];
    }

    return letters;
}

#pragma mark - Setter

- (void)setAnswer:(NSString *)answer {
    if (answer != _answer) {
        _answer = answer;

        [self _generateKeypad];
    }
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

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat containerWidth = self.width - GI_KEYPAD_ACTION_WIDTH;
    CGFloat containerHeight = self.height;

    self.lettersContainer.frame = CGRectMake(0.f, 0.f, containerWidth, containerHeight);

    CGFloat letterWidth = (containerWidth - (GI_KEYPAD_NO_COLUMNS + 1) * GI_KEYPAD_PADDING) / GI_KEYPAD_NO_COLUMNS;
    CGFloat letterHeight = (containerHeight - (GI_KEYPAD_NO_ROWS + 1) * GI_KEYPAD_PADDING) / GI_KEYPAD_NO_ROWS;

    [self.letterViews enumerateObjectsUsingBlock:^(GILetterView *view, NSUInteger idx, BOOL *stop) {
        NSUInteger xIdx = idx % GI_KEYPAD_NO_COLUMNS;
        NSUInteger yIdx = idx / GI_KEYPAD_NO_COLUMNS;

        CGFloat xOffset = xIdx * letterWidth + (xIdx + 1) * GI_KEYPAD_PADDING;
        CGFloat yOffset = yIdx * letterHeight + (yIdx + 1) * GI_KEYPAD_PADDING;

        view.frame = CGRectMake(xOffset, yOffset, letterWidth, letterHeight);
    }];
}

#pragma mark - Private Methods

- (void)_initialize {
    self.backgroundColor = GI_BACKGROUND_MAIN_DARKER_COLOR;
    self.backgroundColor = [UIColor yellowColor];
}

- (void)_generateKeypad {
    NSString *sanitizedAnswer = [self.answer stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self.letterViews enumerateObjectsUsingBlock:^(GILetterView *letterView, NSUInteger idx, BOOL *stop) {
        NSString *letter = @"";
        if (idx < sanitizedAnswer.length) {
            letter = [sanitizedAnswer substringWithRange:NSMakeRange(idx, 1)];
        } else {
            if (idx % 2 == 0) {
                letter = [NSString randomVowel];
            } else {
                letter = [NSString randomConsonant];
            }
        }

        letterView.letter = letter;
    }];

    [self.letterViews shuffle];

    [self setNeedsLayout];
}

@end
