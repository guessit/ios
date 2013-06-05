//
//  GIInputView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIInputView.h"

#import "GIAnswerView.h"
#import "GIAnswerViewDelegate.h"
#import "GIKeypadView.h"
#import "GIKeypadViewDelegate.h"
#import "UIView+SizingAndPositioning.h"

@interface GIInputView () <GIAnswerViewDelegate, GIKeypadViewDelegate>

@property (nonatomic, strong) GIAnswerView *answerView;
@property (nonatomic, strong) GIKeypadView *keypadView;

- (void)_initialize;

@end

@implementation GIInputView

#pragma mark - Getter

- (GIAnswerView *)answerView {
    if (!_answerView) {
        _answerView = [GIAnswerView viewWithFrame:CGRectMake(0.f, 0.f, self.width, self.height - GI_KEYPAD_HEIGHT)];
        _answerView.delegate = self;
        _answerView.backgroundColor = GI_BACKGROUND_MAIN_DARKEST_COLOR;
    }
    return _answerView;
}

- (GIKeypadView *)keypadView {
    if (!_keypadView) {
        _keypadView = [GIKeypadView viewWithFrame:CGRectMake(0.f, self.height - GI_KEYPAD_HEIGHT, self.width, GI_KEYPAD_HEIGHT)];
        _keypadView.delegate = self;
        _keypadView.backgroundColor = GI_BACKGROUND_MAIN_DARKER_COLOR;
    }
    return _keypadView;
}

#pragma mark - Setter

- (void)setCurrentLevel:(GILevel *)currentLevel {
    _currentLevel = currentLevel;

    self.answerView.correctAnswer = currentLevel.answer;
    self.keypadView.correctAnswer = currentLevel.answer;
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

#pragma mark - UIInputViewAudioFeedback Methods

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}

#pragma mark - Private Methods

- (void)_initialize {
    [self addSubview:self.answerView];
    [self addSubview:self.keypadView];
}

#pragma mark - GIAnswerViewDelegate Methods

- (void)answerView:(GIAnswerView *)answerView didRemoveLetterView:(GILetterView *)letterView {
    [self.keypadView addLetterView:letterView];
}

#pragma mark - GIKeypadViewDelegate Methods

- (BOOL)keypadView:(GIKeypadView *)keypadView canAddLetterView:(GILetterView *)letterView {
    return self.answerView.canAddLetter;
}

- (void)keypadView:(GIKeypadView *)keypadView didAddLetterView:(GILetterView *)letterView {
    [self.answerView addLetterView:letterView];

    if (!self.answerView.canAddLetter) {
        [self.delegate inputView:self didFinishGuessingWithAnswer:self.answerView.answer];
    }
}

@end
