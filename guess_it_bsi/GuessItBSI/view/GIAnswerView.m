//
//  GIAnswerView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIAnswerView.h"

#import "GILetterView.h"
#import "GIPlaceholderView.h"
#import "UIView+SizingAndPositioning.h"

@interface GIAnswerView ()

@property (nonatomic, strong, readonly) NSString *currentAnswer;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *placeholderViews;

- (void)_initialize;
- (void)_generateAnswerPlaceholder;

@end

@implementation GIAnswerView

#pragma mark - Getter

- (NSString *)currentAnswer {
    NSMutableString *currentAnswer = [NSMutableString stringWithCapacity:self.placeholderViews.count];
    for (GIPlaceholderView *placeholder in self.placeholderViews) {
        NSString *letter = @" ";
        if (placeholder.letter) letter = placeholder.letter;

        [currentAnswer appendString:letter];
    }

    return currentAnswer;
}

#pragma mark - Setter

- (void)setAnswer:(NSString *)answer {
    if (answer != _answer) {
        _answer = answer;

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

    NSInteger noSpaces = [self.answer componentsSeparatedByString:@" "].count - 1;

    CGFloat width = (2 + noSpaces) * GI_ANSWER_PLACEHOLDER_SPACE_WIDTH + (self.answer.length - noSpaces - 1) * GI_ANSWER_PLACEHOLDER_PADDING + self.placeholderViews.count * placeholderView.width;
    CGFloat height = placeholderView.height;

    self.containerView.frame = CGRectMake(0.f, 0.f, width, height);
    self.containerView.center = self.center;

    CGFloat xOffset = GI_ANSWER_PLACEHOLDER_SPACE_WIDTH;
    NSInteger spaces = 0;
    for (NSInteger i = 0; i < self.answer.length; i++) {
        NSString *letter = [self.answer substringWithRange:NSMakeRange(i, 1)];

        GIPlaceholderView *view = [self.placeholderViews objectAtIndex:i - spaces];
        CGRect frame = view.frame;
        frame.origin.x = xOffset;
        view.frame = frame;

        if ([letter isEqualToString:@" "]) {
            xOffset += GI_ANSWER_PLACEHOLDER_SPACE_WIDTH;
            spaces++;
        } else {
            xOffset += view.width + GI_ANSWER_PLACEHOLDER_PADDING;
        }
    }
}

#pragma mark - Private Interface

- (void)_initialize {
    self.containerView = [UIView view];
    [self addSubview:self.containerView];
}

- (void)_generateAnswerPlaceholder {
    [self.placeholderViews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    NSInteger noSpaces = [self.answer componentsSeparatedByString:@" "].count - 1;
    CGFloat totalPadding = (2 + noSpaces) * GI_ANSWER_PLACEHOLDER_SPACE_WIDTH + (self.answer.length - noSpaces - 1) * GI_ANSWER_PLACEHOLDER_PADDING;

    CGFloat width = (self.width - totalPadding) / self.answer.length;
    if (width > GI_ANSWER_PLACEHOLDER_MAX_WIDTH) {
        width = GI_ANSWER_PLACEHOLDER_MAX_WIDTH;
    }

    CGFloat height = GI_ANSWER_PLACEHOLDER_MAX_WIDTH / GI_ANSWER_PLACEHOLDER_MAX_HEIGHT * width;

    NSInteger noLetters = self.answer.length - noSpaces;
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
        if (!placeholderView.letter) {
            canAddLetter = YES;
            break;
        }
    }

    return canAddLetter;
}

- (void)addLetter:(NSString *)letter {
    for (GIPlaceholderView *placeholderView in self.placeholderViews) {
        if (!placeholderView.letter) {
            placeholderView.letter = letter;
            break;
        }
    }

    NSString *trimmedAnswer = [self.answer stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([trimmedAnswer localizedCaseInsensitiveCompare:self.currentAnswer] == NSOrderedSame) {
        NSLog(@"YAY!");
        #warning TODO: implementar win
        [[[UIAlertView alloc] initWithTitle:@"YAY"
                                    message:@"Win!"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

@end
