//
//  GIKeypadView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/24/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIKeypadView.h"

#import "GILetterView.h"
#import "NSString+RandomString.h"
#import "UIView+SizingAndPositioning.h"

@interface GIKeypadView ()

@property (nonatomic, strong) UIView *lettersContainer;
@property (nonatomic, strong) NSMutableArray *letterViews;
@property (nonatomic, strong) UIButton *actionButton;

@property (nonatomic, strong, readonly) NSString *letters;

@property (nonatomic, weak) GILetterView *zoomedInLetter;

@property (nonatomic, assign) BOOL initialized;

- (void)_initialize;
- (void)_generateKeypad;

@end

@implementation GIKeypadView

#pragma mark - Getter

- (UIView *)lettersContainer {
    if (!_lettersContainer) {
        _lettersContainer = [UIView viewWithFrame:CGRectMake(0.f, 0.f, self.width - GI_KEYPAD_ACTION_WIDTH, self.height)];
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

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.backgroundColor = [UIColor yellowColor];
    }
    return _actionButton;
}

- (NSString *)letters {
    NSString *letters = @"";

    for (GILetterView *letterView in self.letterViews) {
        letters = [letters stringByAppendingString:letterView.letter];
    }

    return letters;
}

#pragma mark - Setter

- (void)setCorrectAnswer:(NSString *)correctAnswer {
    if (correctAnswer != _correctAnswer) {
        _correctAnswer = correctAnswer;

        [self _generateKeypad];
    }
}

- (void)setZoomedInLetter:(GILetterView *)zoomedInLetter {
    if (zoomedInLetter != _zoomedInLetter) {
        [self.lettersContainer sendSubviewToBack:_zoomedInLetter];
        _zoomedInLetter = zoomedInLetter;
        [self.lettersContainer bringSubviewToFront:_zoomedInLetter];
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

    if (!self.initialized) {
        CGFloat letterWidth = (self.lettersContainer.width - (GI_KEYPAD_NO_COLUMNS + 1) * GI_KEYPAD_PADDING) / GI_KEYPAD_NO_COLUMNS;
        CGFloat letterHeight = (self.lettersContainer.height - (GI_KEYPAD_NO_ROWS + 1) * GI_KEYPAD_PADDING) / GI_KEYPAD_NO_ROWS;

        [self.letterViews enumerateObjectsUsingBlock:^(GILetterView *letterView, NSUInteger idx, BOOL *stop) {
            NSUInteger xIdx = idx % GI_KEYPAD_NO_COLUMNS;
            NSUInteger yIdx = idx / GI_KEYPAD_NO_COLUMNS;
            
            CGFloat xOffset = xIdx * letterWidth + (xIdx + 1) * GI_KEYPAD_PADDING;
            CGFloat yOffset = yIdx * letterHeight + (yIdx + 1) * GI_KEYPAD_PADDING;

            letterView.frame = CGRectMake(xOffset, yOffset, letterWidth, letterHeight);
        }];

        self.initialized = YES;
    }
}

#pragma mark - UIResponder Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    if ([touch.view isKindOfClass:[GILetterView class]]) {
        GILetterView *letterView = (GILetterView *)touch.view;
        self.zoomedInLetter = letterView;

        [[UIDevice currentDevice] playInputClick];

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
                [self.zoomedInLetter zoomIn];
                break;
            }
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.zoomedInLetter) {
        BOOL canAdd = YES;

        if ([self.delegate respondsToSelector:@selector(keypadView:canAddLetterView:)]) {
            canAdd = [self.delegate keypadView:self canAddLetterView:self.zoomedInLetter];
        }

        if (canAdd) {
            [self.delegate keypadView:self didAddLetterView:self.zoomedInLetter];
        } else {
            #warning TODO: MAKE PANNNNN sound
            [self.zoomedInLetter zoomOut];
        }
    }

    self.zoomedInLetter = nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.zoomedInLetter) {
        [self.zoomedInLetter zoomOut];
    }

    self.zoomedInLetter = nil;
}

#pragma mark - Private Methods

- (void)_initialize {
    self.backgroundColor = GI_BACKGROUND_MAIN_DARKER_COLOR;
}

- (void)_generateKeypad {
    NSString *sanitizedAnswer = [self.correctAnswer stringByReplacingOccurrencesOfString:@" " withString:@""];
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
        if (!letterView.superview) {
            [self.lettersContainer addSubview:letterView];
        }

        [letterView reset];
    }];

    [self.letterViews shuffle];

    self.initialized = NO;
    [self setNeedsLayout];
}

#pragma mark - Public Methods

- (void)addLetterView:(GILetterView *)letterView {
    letterView.transform = CGAffineTransformIdentity;
    letterView.frame = letterView.oldFrame;
    letterView.alpha = 0.f;

    [self addSubview:letterView];

    letterView.transform = CGAffineTransformMakeScale(GI_LETTER_MINIMIZED_SCALE, GI_LETTER_MINIMIZED_SCALE);

    [UIView animateWithDuration:0.2f animations:^{
        letterView.alpha = 1.f;
        letterView.transform = CGAffineTransformMakeScale(GI_LETTER_ZOOMED_SCALE, GI_LETTER_ZOOMED_SCALE);
        letterView.backgroundColor = GI_LETTER_ZOOMED_COLOR;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f animations:^{
            letterView.transform = CGAffineTransformIdentity;
            letterView.backgroundColor = GI_LETTER_COLOR;
        }];
    }];
}

@end
