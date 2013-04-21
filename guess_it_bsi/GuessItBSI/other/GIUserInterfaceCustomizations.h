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
#define GI_FONT_MAIN_COLOR [UIColor colorWithWhite:0.65f alpha:1.f]

@interface GIUserInterfaceCustomizations : NSObject

+ (instancetype)userInterfaceCustomizations;
- (void)customizeUserInterface;

@end
