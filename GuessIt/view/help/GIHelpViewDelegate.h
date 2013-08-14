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

- (BOOL)helpViewCanPlaceCorrectLetter:(GIHelpView *)helpView;
- (BOOL)helpViewCanEliminateWrongLetter:(GIHelpView *)helpView;

- (void)helpViewDidRequestToPlaceCorrectLetter:(GIHelpView *)helpView;
- (void)helpViewDidRequestToEliminateWrongLetter:(GIHelpView *)helpView;
- (void)helpViewDidRequestToSkipLevel:(GIHelpView *)helpView;

- (void)helpViewDidRequestToPostOnFacebook:(GIHelpView *)helpView;
- (void)helpViewDidRequestToPostOnTwitter:(GIHelpView *)helpView;

@optional

- (void)helpViewDidCancel:(GIHelpView *)helpView;

@end
