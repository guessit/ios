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
    UIImage *blackPixel = [UIImage imageNamed:@"black_pixel"];

    [[UINavigationBar appearance] setBackgroundImage:blackPixel
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithWhite:0.05 alpha:1.f]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
        UITextAttributeFont: [UIFont fontWithName:@"GillSans-Bold" size:22.f],
        UITextAttributeTextColor: [UIColor colorWithWhite:0.40 alpha:1.f],
        UITextAttributeTextShadowColor: [UIColor colorWithWhite:0.9 alpha:0.25f],
        UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.f, -1.f)]
    }];
}

@end
