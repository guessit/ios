//
//  GIUserInterfaceCustomizations.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 26/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GI_BACKGROUND_MAIN_COLOR [UIColor colorWithWhite:0.200 alpha:1.000]
#define GI_BACKGROUND_MAIN_DARKER_COLOR [UIColor colorWithWhite:0.170 alpha:1.000]
#define GI_BACKGROUND_MAIN_LIGHTER_COLOR [UIColor colorWithWhite:0.230 alpha:1.000]

#define GI_TITLE_COLOR [UIColor colorWithRed:1.000 green:0.800 blue:0.000 alpha:1.000]
#define GI_TITLE_SHINE_COLOR [UIColor colorWithRed:0.980 green:0.984 blue:0.843 alpha:1.000]
#define GI_TITLE_SHADOW_COLOR [UIColor blackColor]
#define GI_TITLE_SHADOW_OFFSET CGSizeMake(0.f, -1.f)

#define GI_FONT_MAIN_COLOR [UIColor colorWithWhite:0.65f alpha:1.f]

@interface GIUserInterfaceCustomizations : NSObject

+ (instancetype)userInterfaceCustomizations;
- (void)customizeUserInterface;

@end
