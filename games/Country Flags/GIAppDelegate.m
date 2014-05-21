//
//  GIAppDelegate.m
//  Country Flags
//
//  Created by Marlon Andrade on 20/05/14.
//  Copyright (c) 2014 Marlon Andrade. All rights reserved.
//

#import "GIAppDelegate.h"

#import "UINavigationController+GuessIt.h"

@implementation GIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [UINavigationController guessItGame];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
