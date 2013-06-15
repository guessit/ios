//
//  GIKeypadViewDelegate.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 06/03/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GIKeypadView;
@class GILetterView;

@protocol GIKeypadViewDelegate <NSObject>

@required
- (void)keypadView:(GIKeypadView *)keypadView didAddLetterView:(GILetterView *)letterView;
- (void)keypadView:(GIKeypadView *)keypadView actionButtonPressed:(id)sender;

@optional
- (BOOL)keypadView:(GIKeypadView *)keypadView canAddLetterView:(GILetterView *)letterView;

@end
