//
//  GIInputViewDelegate.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 06/03/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GIInputView;

@protocol GIInputViewDelegate <NSObject>

- (void)inputView:(GIInputView *)inputView didFinishGuessingWithAnswer:(NSString *)answer;

@end
