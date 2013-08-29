//
//  GIIconButton.h
//  GuessIt
//
//  Created by Marlon Andrade on 08/21/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FAImageView.h"

#define GI_SOCIAL_BUTTON_BORDER_WIDTH 1.f
#define GI_SOCIAL_BUTTON_BORDER_COLOR [UIColor colorWithWhite:0.f alpha:0.15f].CGColor

#define GI_FACEBOOK_BACKGROUND_COLOR [UIColor colorWithRed:76.f/255.f green:102.f/255.f blue:164.f/255.f alpha:1.f]
#define GI_TWITTER_BACKGROUND_COLOR [UIColor colorWithRed:0.f/255.f green:190.f/255.f blue:246.f/255.f alpha:1.f]

@interface GIIconButton : UIButton

+ (instancetype)buttonWithIcon:(FAIcon)icon;

+ (instancetype)facebookButton;
+ (instancetype)twitterButton;

@property (nonatomic, assign) FAIcon icon;

@end