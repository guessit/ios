//
//  GIAnswerViewDelegate.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 06/03/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GIAnswerView;
@class GILetterView;

@protocol GIAnswerViewDelegate <NSObject>

@required
- (void)answerView:(GIAnswerView *)answerView didRemoveLetterView:(GILetterView *)letterView;

@optional
- (BOOL)answerView:(GIAnswerView *)answerView canRemoveLetterView:(GILetterView *)letterView;

@end
