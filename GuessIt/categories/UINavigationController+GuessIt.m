//
//  UINavigationController+GuessIt.m
//  GuessIt
//
//  Created by Marlon Andrade on 15/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "UINavigationController+GuessIt.h"

#import "GIMainViewController.h"
#import "GINavigationBar.h"
#import "MALazykit.h"

@implementation UINavigationController (GuessIt)

+ (instancetype)guessItGame {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    UINavigationController *nav = [UINavigationController navigationControllerWithNavigationBarClass:[GINavigationBar class]
                                                                                        toolbarClass:nil];
    nav.viewControllers = @[[GIMainViewController viewController]];

    return nav;
}

@end
