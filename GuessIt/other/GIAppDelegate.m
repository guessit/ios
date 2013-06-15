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
    UIViewController *vc = [UIViewController viewController];
    vc.view.backgroundColor = [UIColor whiteColor];

    UILabel *label = [UILabel label];
    label.text = @"GuessIt is a framework, create a new app and add it as a pod";
    label.numberOfLines = 3;
    label.font = [UIFont systemFontOfSize:26.f];
    label.frame = CGRectInset(vc.view.bounds, 20.f, 20.f);
    label.textAlignment = NSTextAlignmentCenter;

    [vc.view addSubview:label];

    label.center = vc.view.center;

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
