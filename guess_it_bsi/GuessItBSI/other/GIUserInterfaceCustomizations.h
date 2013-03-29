//
//  GIUserInterfaceCustomizations.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 26/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GI_BACKGROUND_MAIN_COLOR [UIColor colorWithWhite:0.12f alpha:1.f]
#define GI_FONT_MAIN_COLOR [UIColor colorWithWhite:0.65 alpha:1.f]
@interface GIUserInterfaceCustomizations : NSObject

+ (instancetype)userInterfaceCustomizations;
- (void)customizeUserInterface;

@end
