//
//  GILevelViewDelegate.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 06/03/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GILevel;
@class GILevelView;

@protocol GILevelViewDelegate <NSObject>

- (void)levelView:(GILevelView *)levelView didFinishGuessingLevel:(GILevel *)level withResult:(GIGuessingResult)guessingResult;

@end
