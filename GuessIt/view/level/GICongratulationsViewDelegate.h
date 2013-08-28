//
//  GICongratulationsViewDelegate.h
//  GuessIt
//
//  Created by Marlon Andrade on 08/28/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GICongratulationsView;

@protocol GICongratulationsViewDelegate <NSObject>

@optional

- (void)congratulationsViewDidRequestToPostOnFacebook:(GICongratulationsView *)congratulationsView;
- (void)congratulationsViewDidRequestToPostOnTwitter:(GICongratulationsView *)congratulationsView;

@end
