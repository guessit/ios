//
//  GIInputViewDelegate.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 20/05/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GIAnswerView;
@class GIKeypadView;
@class GILetterView;

@protocol GIInputViewDelegate <NSObject>

- (BOOL)keypadView:(GIKeypadView *)keypadView canAddLetterView:(GILetterView *)letterView;
- (void)keypadView:(GIKeypadView *)keypadView didAddLetterView:(GILetterView *)letterView;
- (void)answerView:(GIAnswerView *)answerView didRemoveLetterView:(GILetterView *)letterView;

@end
