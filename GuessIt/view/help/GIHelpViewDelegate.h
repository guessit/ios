//
//  GIHelpViewDelegate.h
//  GuessIt
//
//  Created by Marlon Andrade on 22/07/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GIHelpView;

@protocol GIHelpViewDelegate <NSObject>

- (BOOL)helpViewCanEliminateWrongLetter:(GIHelpView *)helpView;
- (BOOL)helpViewCanFillCorrectLetter:(GIHelpView *)helpView;

- (void)helpViewDidRequestToEliminateWrongLetter:(GIHelpView *)helpView;
- (void)helpViewDidRequestToFillCorrectLetter:(GIHelpView *)helpView;
- (void)helpViewDidRequestToSkipLevel:(GIHelpView *)helpView;

@optional

- (void)helpViewDidCancel:(GIHelpView *)helpView;

@end
