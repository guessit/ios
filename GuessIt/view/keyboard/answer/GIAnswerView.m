//
//  GIAnswerView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIAnswerView.h"

#import "GIConfiguration.h"
#import "GIDefinitions.h"
#import "GILetterView.h"
#import "GIPlaceholderView.h"
#import "MALazykit.h"
#import "UIView+CBFrameHelpers.h"

@interface GIAnswerView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *placeholderViews;
@property (nonatomic, strong) GILetterView *zoomedInLetter;

- (void)_initialize;
- (void)_generateAnswerPlaceholder;

@end

@implementation GIAnswerView

#pragma mark - Getter

- (NSString *)answer {
    NSMutableString *answer = [NSMutableString stringWithCapacity:self.correctAnswer.length];
    for (GIPlaceholderView *placeholder in self.placeholderViews) {
        NSString *letter = @" ";
        if (placeholder.letter) letter = placeholder.letter;
        if (placeholder.placedAfterSpace) [answer appendString:@" "];

        [answer appendString:letter];
    }

    NSLog(@"Current Answer: %@", answer);

    return answer;
}

#pragma mark - Setter

- (void)setCorrectAnswer:(NSString *)correctAnswer {
    if (correctAnswer != _correctAnswer) {
        _correctAnswer = correctAnswer;

        [self _generateAnswerPlaceholder];
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

    GIPlaceholderView *placeholderView = self.placeholderViews.firstObject;

    NSInteger noSpaces = [self.correctAnswer componentsSeparatedByString:@" "].count - 1;

    CGFloat width = (2 + noSpaces) * GI_ANSWER_PLACEHOLDER_SPACE_WIDTH + (self.correctAnswer.length - noSpaces - 1) * GI_ANSWER_PLACEHOLDER_PADDING + self.placeholderViews.count * placeholderView.width;
    CGFloat height = placeholderView.height;

    self.containerView.frame = CGRectMake(0.f, 0.f, width, height);
    self.containerView.center = self.center;

    CGFloat xOffset = GI_ANSWER_PLACEHOLDER_SPACE_WIDTH;
    NSInteger spaces = 0;
    for (NSInteger i = 0; i < self.correctAnswer.length; i++) {
        NSString *letter = [self.correctAnswer substringWithRange:NSMakeRange(i, 1)];

        GIPlaceholderView *view = [self.placeholderViews objectAtIndex:i - spaces];
        CGRect frame = view.frame;
        frame.origin.x = xOffset;
        view.frame = frame;

        if ([letter isEqualToString:@" "]) {
            view.placedAfterSpace = YES;
            xOffset += GI_ANSWER_PLACEHOLDER_SPACE_WIDTH;
            spaces++;
        } else {
            xOffset += view.width + GI_ANSWER_PLACEHOLDER_PADDING;
        }
    }
}

#pragma mark - Private Interface

- (void)_initialize {
    self.backgroundColor = [GIConfiguration sharedInstance].game.interface.answer.backgroundColor;
    self.containerView = [UIView view];
    [self addSubview:self.containerView];
}

- (void)_generateAnswerPlaceholder {
    [self.placeholderViews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    NSInteger noSpaces = [self.correctAnswer componentsSeparatedByString:@" "].count - 1;
    CGFloat totalPadding = (2 + noSpaces) * GI_ANSWER_PLACEHOLDER_SPACE_WIDTH + (self.correctAnswer.length - noSpaces - 1) * GI_ANSWER_PLACEHOLDER_PADDING;

    CGFloat width = (self.width - totalPadding) / self.correctAnswer.length;
    if (width > GI_ANSWER_PLACEHOLDER_MAX_WIDTH) {
        width = GI_ANSWER_PLACEHOLDER_MAX_WIDTH;
    }

    CGFloat height = GI_ANSWER_PLACEHOLDER_MAX_WIDTH / GI_ANSWER_PLACEHOLDER_MAX_HEIGHT * width;

    NSInteger noLetters = self.correctAnswer.length - noSpaces;
    self.placeholderViews = [NSMutableArray arrayWithCapacity:noLetters];
    for (NSInteger idx = 0; idx < noLetters; idx++) {
        GIPlaceholderView *placeholder = [GIPlaceholderView viewWithFrame:CGRectMake(0.f, 0.f, width, height)];
        [self.containerView addSubview:placeholder];
        [self.placeholderViews addObject:placeholder];
    }

    [self setNeedsLayout];
}

#pragma mark - Public Interface

- (BOOL)canAddLetter {
    BOOL canAddLetter = NO;

    for (GIPlaceholderView *placeholderView in self.placeholderViews) {
        if (placeholderView.canDisplayLetterView) {
            canAddLetter = YES;
            break;
        }
    }

    return canAddLetter;
}

- (void)addLetterView:(GILetterView *)letterView {
    for (GIPlaceholderView *placeholderView in self.placeholderViews) {
        if (placeholderView.canDisplayLetterView) {
            [placeholderView displayLetterView:letterView];
            break;
        }
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
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.zoomedInLetter) {
        [self.zoomedInLetter zoomOut];

        BOOL canRemove = YES;

        if ([self.delegate respondsToSelector:@selector(answerView:canRemoveLetterView:)]) {
            canRemove = [self.delegate answerView:self canRemoveLetterView:self.zoomedInLetter];
        }

        if (canRemove) {
            [self.delegate answerView:self didRemoveLetterView:self.zoomedInLetter];
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

@end
