//
//  GIAppDelegate.m
//  GuessIt
//
//  Created by Marlon Andrade on 15/06/13.
//  Copyright (c) 2013 GuessIt. All rights reserved.
//

#import "GIAppDelegate.h"

#import "MALazykit.h"
#import "UINavigationController+GuessIt.h"

@implementation GIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [UINavigationController guessItGame];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
