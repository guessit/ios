//
//  GIKeypadView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/24/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIKeypadView.h"

#import "GIConfiguration.h"
#import "GIDefinitions.h"
#import "GIGlowButton.h"
#import "GILetterView.h"
#import "MALazykit.h"
#import "NSString+RandomString.h"
#import "NSString+Search.h"
#import "UIFont+GuessItFonts.h"
#import "UIView+CBFrameHelpers.h"
#import "UIView+EasingFunctions/UIView+EasingFunctions.h"
#import <AHEasing/easing.h>
#import <SSToolkit/SSCategories.h>

@interface GIKeypadView ()

@property (nonatomic, strong) UIView *lettersContainer;
@property (nonatomic, strong) NSMutableArray *letterViews;
@property (nonatomic, strong) GIGlowButton *actionButton;

@property (nonatomic, strong, readonly) NSString *letters;

@property (nonatomic, weak) GILetterView *zoomedInLetter;

@property (nonatomic, assign) BOOL initialized;

@property (nonatomic, strong, readonly) NSArray *placedLetterViews;
@property (nonatomic, strong, readonly) NSArray *notPlacedLetterViews;
@property (nonatomic, strong, readonly) GILetterView *firstWrongLetterView;

- (void)_initialize;
- (void)_generateKeypad;
- (void)_increaseLetterCountOnLetters:(NSMutableDictionary *)letters withLetter:(NSString *)letter;
- (void)_actionButtonTouched:(id)sender;

@end

@implementation GIKeypadView

#pragma mark - Getter

- (UIView *)lettersContainer {
    if (!_lettersContainer) {
        _lettersContainer = [UIView view];
        _lettersContainer.backgroundColor = [UIColor clearColor];
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

- (GIGlowButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [GIGlowButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(self.width - GI_KEYPAD_ACTION_WIDTH, GI_KEYPAD_PADDING,
                                  GI_KEYPAD_ACTION_WIDTH - GI_KEYPAD_PADDING, self.height - 2 * GI_KEYPAD_PADDING);
        _actionButton.frame = frame;
        _actionButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;

        GIUserInterfaceElement *ui = [GIConfiguration sharedInstance].game.interface.action;

        _actionButton.backgroundColor = ui.backgroundColor;
        _actionButton.glowColor = ui.secondaryColor;
        _actionButton.titleLabel.font = [UIFont guessItActionFont];
        _actionButton.titleEdgeInsets = UIEdgeInsetsMake(0.f, 2.f, 0.f, 0.f);
        _actionButton.titleLabel.shadowOffset = CGSizeMake(0.f, -1.f);
        [_actionButton setTitleShadowColor:ui.shadowColor forState:UIControlStateNormal];
        [_actionButton setTitleColor:ui.textColor forState:UIControlStateNormal];
        [_actionButton setTitleColor:ui.secondaryTextColor forState:UIControlStateHighlighted];
        [_actionButton setTitle:@"?" forState:UIControlStateNormal];

        [_actionButton addTarget:self
                          action:@selector(_actionButtonTouched:)
                forControlEvents:UIControlEventTouchUpInside];
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

- (NSArray *)placedLetterViews {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K != %@ and %K != %f",
                              @"superview", self.lettersContainer,
                              @"alpha", 0.f];
    return [self.letterViews filteredArrayUsingPredicate:predicate];
}

- (NSArray *)notPlacedLetterViews {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"superview", self.lettersContainer];
    return [self.letterViews filteredArrayUsingPredicate:predicate];
}

- (GILetterView *)firstWrongLetterView {
    GILetterView *wrongLetterView = nil;

    NSMutableDictionary *letters = [NSMutableDictionary dictionaryWithCapacity:self.correctAnswer.length];
    for (GILetterView *letterView in self.placedLetterViews) {
        [self _increaseLetterCountOnLetters:letters withLetter:letterView.letter];
    }

    for (GILetterView *letterView in self.notPlacedLetterViews) {
        if (![self.correctAnswer containsString:letterView.letter]) {
            wrongLetterView = letterView;
            break;
        } else {
            [self _increaseLetterCountOnLetters:letters withLetter:letterView.letter];

            NSNumber *letterCount = [letters objectForKey:letterView.letter];
            NSInteger occurrencesOfLetter = [self.correctAnswer numberOfOccurrencesOfString:letterView.letter];
            if (letterCount.integerValue > occurrencesOfLetter) {
                wrongLetterView = letterView;
                break;
            }
        }
    }

    return wrongLetterView;
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

    [self.lettersContainer setSizeFromSize:CGSizeMake(self.width - GI_KEYPAD_ACTION_WIDTH, self.height)];
    
    if (!self.initialized) {
        CGFloat letterWidth = (self.lettersContainer.width - (GI_KEYPAD_NO_COLUMNS + 1) * GI_KEYPAD_PADDING) / GI_KEYPAD_NO_COLUMNS;
        CGFloat letterHeight = (self.lettersContainer.height - (GI_KEYPAD_NO_ROWS + 1) * GI_KEYPAD_PADDING) / GI_KEYPAD_NO_ROWS;

        [self.letterViews enumerateObjectsUsingBlock:^(GILetterView *letterView, NSUInteger idx, BOOL *stop) {
            NSUInteger xIdx = idx % GI_KEYPAD_NO_COLUMNS;
            NSUInteger yIdx = idx / GI_KEYPAD_NO_COLUMNS;
            
            CGFloat xOffset = xIdx * letterWidth + (xIdx + 1) * GI_KEYPAD_PADDING;
            CGFloat yOffset = yIdx * letterHeight + (yIdx + 1) * GI_KEYPAD_PADDING;

            letterView.transform = CGAffineTransformIdentity;
            letterView.frame = CGRectMake(xOffset, yOffset, letterWidth, letterHeight);

            CGPoint center = letterView.center;

            letterView.transform = CGAffineTransformMakeScale(GI_LETTER_MINIMIZED_SCALE, GI_LETTER_MINIMIZED_SCALE);
            letterView.alpha = 0.f;
            letterView.center = CGPointMake(self.center.x, self.height + 10.f);

            CGFloat delay = ((double)arc4random() / 0x100000000) * 0.3f + 0.1f;
            CGFloat duration = ((double)arc4random() / 0x100000000) * 0.3f + 0.05f;
            [UIView animateWithDuration:duration delay:delay options:0 animations:^{
                [letterView setEasingFunction:BackEaseInOut forKeyPath:@"transform"];
                [letterView setEasingFunction:QuadraticEaseInOut forKeyPath:@"alpha"];
                letterView.alpha = 1.f;
                letterView.center = center;
                letterView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [letterView removeEasingFunctionForKeyPath:@"transform"];
                [letterView removeEasingFunctionForKeyPath:@"alpha"];
            }];
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
        [self.zoomedInLetter zoomOut];

        BOOL canAdd = YES;

        if ([self.delegate respondsToSelector:@selector(keypadView:canAddLetterView:)]) {
            canAdd = [self.delegate keypadView:self canAddLetterView:self.zoomedInLetter];
        }

        if (canAdd) {
            [self.delegate keypadView:self didAddLetterView:self.zoomedInLetter];
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
    self.backgroundColor = [GIConfiguration sharedInstance].game.interface.keypad.backgroundColor;

    [self addSubview:self.actionButton];
    [self addSubview:self.lettersContainer];

    [self.actionButton glow];
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

        [letterView removeFromSuperview];
        [self.lettersContainer addSubview:letterView];

        [letterView reset];
    }];

    [self.letterViews shuffle];

    self.initialized = NO;
    [self setNeedsLayout];
}

- (void)_increaseLetterCountOnLetters:(NSMutableDictionary *)letters withLetter:(NSString *)letter {
    NSNumber *letterCount = [letters objectForKey:letter];
    if (!letterCount) {
        letterCount = @1;
    } else {
        letterCount = @(letterCount.integerValue + 1);
    }
    [letters setObject:letterCount forKey:letter];
}

- (void)_actionButtonTouched:(id)sender {
    [self.delegate keypadView:self actionButtonPressed:sender];
}

#pragma mark - Public Methods

- (BOOL)hasWrongLetterToBeRemoved {
    return self.firstWrongLetterView != nil;
}

- (void)removeWrongLetter {
    GILetterView *wrongLetter = self.firstWrongLetterView;
    [wrongLetter minimizeWithCompletion:^(BOOL finished) {
        [wrongLetter removeFromSuperview];
    }];
}

- (BOOL)hasAvailableLetterViewForLetters:(NSString *)letters {
    return [self availableLetterViewForLetters:letters] != nil;
}

- (GILetterView *)availableLetterViewForLetters:(NSString *)letters {
    __block GILetterView *availableLetter = nil;

    for (NSInteger i = 0; i < letters.length; i++) {
        NSString *letter = [letters substringWithRange:NSMakeRange(i, 1)];
        [self.letterViews enumerateObjectsUsingBlock:^(GILetterView *letterView, NSUInteger idx, BOOL *stop) {
            if (letterView.superview == self.lettersContainer) {
                if ([letter isEqualToString:letterView.letter]) {
                    availableLetter = letterView;
                    *stop = YES;
                }
            }
        }];

        if (availableLetter) break;
    }

    return availableLetter;
}

- (void)addLetterView:(GILetterView *)letterView {
    letterView.transform = CGAffineTransformIdentity;
    letterView.frame = letterView.oldFrame;
    letterView.alpha = 0.f;

    [self.lettersContainer addSubview:letterView];

    letterView.transform = CGAffineTransformMakeScale(GI_LETTER_MINIMIZED_SCALE, GI_LETTER_MINIMIZED_SCALE);

    GIUserInterfaceElement *ui = [GIConfiguration sharedInstance].game.interface.letter;

    [UIView animateWithDuration:0.2f animations:^{
        letterView.alpha = 1.f;
        letterView.transform = CGAffineTransformMakeScale(GI_LETTER_ZOOMED_SCALE, GI_LETTER_ZOOMED_SCALE);
        letterView.backgroundColor = ui.secondaryBackgroundColor;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f animations:^{
            letterView.transform = CGAffineTransformIdentity;
            letterView.backgroundColor = ui.backgroundColor;
        }];
    }];
}

@end
