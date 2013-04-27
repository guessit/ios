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
#define GI_KEYPAD_PADDING 2.f
#define GI_KEYPAD_ACTION_WIDTH 50.f

@interface GIKeypadView ()

@property (nonatomic, strong) UIView *lettersContainer;
@property (nonatomic, strong) NSMutableArray *letterViews;
@property (nonatomic, strong, readonly) NSString *letters;

@property (nonatomic, weak) GILetterView *zoomedInLetter;

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
        NSInteger numberOfKeys = GI_KEYPAD_NO_ROWS * GI_KEYPAD_NO_COLUMNS;
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

#pragma mark - UIResponder Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    if ([touch.view isKindOfClass:[GILetterView class]]) {
        self.zoomedInLetter = (GILetterView *)touch.view;
        [self.lettersContainer bringSubviewToFront:self.zoomedInLetter];
        [self.zoomedInLetter zoomIn];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.zoomedInLetter];
    if (![self.zoomedInLetter pointInside:point withEvent:event]) {
        if (self.zoomedInLetter) {
            [self.zoomedInLetter zoomOut];
            self.zoomedInLetter = nil;
        }

        for (GILetterView *letterView in self.letterViews) {
            point = [touch locationInView:letterView];
            if ([letterView pointInside:point withEvent:event]) {
                self.zoomedInLetter = letterView;
                [self.lettersContainer bringSubviewToFront:self.zoomedInLetter];
                [self.zoomedInLetter zoomIn];
                break;
            }
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.zoomedInLetter) {
        [self.zoomedInLetter zoomOut];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.zoomedInLetter) {
        [self.zoomedInLetter zoomOut];
    }
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

    [self setNeedsLayout];
}

@end
