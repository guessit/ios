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
#import "CargoBay.h"
#import "MALazykit.h"

@implementation UINavigationController (GuessIt)

+ (instancetype)guessItGame {
    NSLog(@"Bundle: %@", [NSBundle mainBundle]);

    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier.lowercaseString;
    NSMutableSet *identifiers = [NSMutableSet set];
    for (NSString *product in GI_IAP) {
//        NSString *productId = [NSString stringWithFormat:@"%@.%@", bundleId, product];
        NSString *productId = product;
        [identifiers addObject:productId];
    }

    NSLog(@"Identifiers: %@", identifiers);

    [[CargoBay sharedManager] productsWithIdentifiers:identifiers
                                              success:^(NSArray *products, NSArray *invalidIdentifiers) {
                                                  NSLog(@"Products: %@", products);
                                                  NSLog(@"Invalid: %@", invalidIdentifiers);
                                              } failure:^(NSError *error) {
                                                  NSLog(@"Error :%@", error);
                                              }];


    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    UINavigationController *nav = [UINavigationController navigationControllerWithNavigationBarClass:[GINavigationBar class]
                                                                                        toolbarClass:nil];
    nav.viewControllers = @[[GIMainViewController viewController]];

    return nav;
}

@end
