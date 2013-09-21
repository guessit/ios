//
//  GIGameOverViewDelegate.h
//  GuessIt
//
//  Created by Marlon Andrade on 21/09/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GIGameOverView;

@protocol GIGameOverViewDelegate <NSObject>

@optional

- (void)gameOverViewDidRequestToPostOnFacebook:(GIGameOverView *)gameOverView;
- (void)gameOverViewDidRequestToPostOnTwitter:(GIGameOverView *)gameOverView;

@end
