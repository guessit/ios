//
//  GIInputView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIInputView.h"

#import "GIAnswerView.h"
#import "GIKeypadView.h"
#import "UIView+SizingAndPositioning.h"

@interface GIInputView ()

@property (nonatomic, strong) GIAnswerView *answerView;
@property (nonatomic, strong) GIKeypadView *keypadView;

- (void)_initialize;

@end

@implementation GIInputView

#pragma mark - Getter

- (GIAnswerView *)answerView {
    if (!_answerView) {
        _answerView = [GIAnswerView viewWithFrame:CGRectMake(0.f, 0.f, self.width, self.height - GI_KEYPAD_HEIGHT)];
    }
    return _answerView;
}

- (GIKeypadView *)keypadView {
    if (!_keypadView) {
        _keypadView = [GIKeypadView viewWithFrame:CGRectMake(0.f, self.height - GI_KEYPAD_HEIGHT, self.width, GI_KEYPAD_HEIGHT)];
    }
    return _keypadView;
}

#pragma mark - Setter

- (void)setItem:(GIItem *)item {
    _item = item;

    self.answerView.answer = item.answer;
    self.keypadView.answer = item.answer;
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

@end
