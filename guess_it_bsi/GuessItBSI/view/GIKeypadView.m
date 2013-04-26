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

#define GI_KEYPAD_NUMBER_OF_ROWS 2
#define GI_KEYPAD_NUMBER_OF_COLUMNS 7
#define GI_KEYPAD_SPACING 2.f
#define GI_KEYPAD_SPECIAL_ITEM_WIDTH 40.f

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
        _lettersContainer.backgroundColor = [UIColor clearColor];

        [self addSubview:_lettersContainer];
    }
    return _lettersContainer;
}

- (NSMutableArray *)letterViews {
    if (!_letterViews) {
        NSInteger numberOfKeys = GI_KEYPAD_NUMBER_OF_ROWS * GI_KEYPAD_NUMBER_OF_COLUMNS;
        NSMutableArray *views = [NSMutableArray arrayWithCapacity:numberOfKeys];

        for (NSInteger i = 0; i < numberOfKeys; i++) {
            GILetterView *letterView = [GILetterView view];
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

    CGFloat columnsSpacing = (GI_KEYPAD_NUMBER_OF_COLUMNS - 1) * GI_KEYPAD_SPACING;
    CGFloat rowsSpacing = (GI_KEYPAD_NUMBER_OF_ROWS - 1) * GI_KEYPAD_SPACING;

    CGFloat containerWidth = self.width - 2 * GI_KEYPAD_SPACING - GI_KEYPAD_SPECIAL_ITEM_WIDTH;
    CGFloat containerHeight = self.height - 2 * GI_KEYPAD_SPACING;

    CGFloat letterWidth = floorf((containerWidth - columnsSpacing) / GI_KEYPAD_NUMBER_OF_COLUMNS);
    CGFloat letterHeight = floorf((containerHeight - rowsSpacing) / GI_KEYPAD_NUMBER_OF_ROWS);

    self.lettersContainer.frame = CGRectMake(GI_KEYPAD_SPACING, GI_KEYPAD_SPACING, containerWidth, containerHeight);

    [self.letterViews enumerateObjectsUsingBlock:^(GILetterView *view, NSUInteger idx, BOOL *stop) {
        NSUInteger column = idx % GI_KEYPAD_NUMBER_OF_COLUMNS;
        NSUInteger row = idx / GI_KEYPAD_NUMBER_OF_COLUMNS;

        view.frame = CGRectMake((letterWidth + GI_KEYPAD_SPACING) * column,
                                (letterHeight + GI_KEYPAD_SPACING) * row,
                                letterWidth, letterHeight);
    }];
}

#pragma mark - Private Methods

- (void)_initialize {
    self.backgroundColor = GI_BACKGROUND_MAIN_DARKER_COLOR;
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

    NSLog(@"Letters: %@", self.letters);

    [self setNeedsLayout];
}

@end
