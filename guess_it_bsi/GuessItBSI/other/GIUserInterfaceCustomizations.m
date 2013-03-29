//
//  GIUserInterfaceCustomizations.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 26/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIUserInterfaceCustomizations.h"

@interface GIUserInterfaceCustomizations()

- (void)_customizeNavigationBar;

@end

@implementation GIUserInterfaceCustomizations

#pragma mark - Public Interface

+ (instancetype)userInterfaceCustomizations {
    return [[self alloc] init];
}

- (void)customizeUserInterface {
    [self _customizeNavigationBar];
}

#pragma mark - Private Interface

- (void)_customizeNavigationBar {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar_background"]
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:GI_BACKGROUND_MAIN_COLOR];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
        UITextAttributeFont: [UIFont fontWithName:@"GillSans-Bold" size:22.f],
        UITextAttributeTextColor: GI_FONT_MAIN_COLOR
    }];
}

@end
