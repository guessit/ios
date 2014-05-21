//
//  UINavigationController+GuessIt.m
//  GuessIt
//
//  Created by Marlon Andrade on 15/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "UINavigationController+GuessIt.h"

#import "GIDefinitions.h"
#import "GIMainViewController.h"
#import "GINavigationBar.h"
#import "MALazykit.h"

@implementation UINavigationController (GuessIt)

+ (instancetype)guessItGame {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

#ifdef LIGHT_STATUS_BAR
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
#endif

    UINavigationController *nav = [UINavigationController navigationControllerWithNavigationBarClass:[GINavigationBar class]
                                                                                        toolbarClass:nil];
    nav.viewControllers = @[[GIMainViewController viewController]];

    return nav;
}

@end
