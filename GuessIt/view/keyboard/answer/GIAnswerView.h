//
//  GIAnswerView.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GIAnswerViewDelegate.h"
#import "GILetterView.h"

@interface GIAnswerView : UIView

@property (nonatomic, weak) id<GIAnswerViewDelegate> delegate;
@property (nonatomic, copy) NSString *correctAnswer;
@property (nonatomic, strong, readonly) NSString *answer;

- (BOOL)canAddLetter;
- (void)addLetterView:(GILetterView *)letterView;
- (void)addLetterViewOnCorrectPlace:(GILetterView *)letterView;

@end
