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

#define GI_KEYPAD_NUMBER_OF_ROWS 2
#define GI_KEYPAD_NUMBER_OF_COLUMNS 7

@interface GIKeypadView ()

@property (nonatomic, strong) NSArray *letterViews;

- (void)_generateKeypad;

@end

@implementation GIKeypadView

#pragma mark - Getter

- (NSArray *)letterViews {
    if (!_letterViews) {
        NSInteger numberOfKeys = GI_KEYPAD_NUMBER_OF_ROWS * GI_KEYPAD_NUMBER_OF_COLUMNS;
        NSMutableArray *views = [NSMutableArray arrayWithCapacity:numberOfKeys];

        for (NSInteger i = 0; i < numberOfKeys; i++) {
            [views addObject:[GILetterView view]];
        }

        _letterViews = views;
    }
    return _letterViews;
}

#pragma mark - Setter

- (void)setAnswer:(NSString *)answer {
    if (answer != _answer) {
        _answer = answer;

        [self _generateKeypad];
    }
}

#pragma mark - UIView Methods

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews {

}

#pragma mark - Private Methods

- (void)_generateKeypad {
    NSString *sanitizedAnswer = [self.answer stringByReplacingOccurrencesOfString:@" " withString:@""];
    __block NSString *letters = @"";
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

        letters = [letters stringByAppendingString:letter];

        letterView.letter = letter;
    }];

    NSLog(@"%@", letters);

    [self setNeedsLayout];
}

@end
