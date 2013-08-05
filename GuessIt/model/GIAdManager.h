//
//  GIAdManager.h
//  GuessIt
//
//  Created by Marlon Andrade on 08/05/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GIAdManager : NSObject

@property (nonatomic, assign, readonly) BOOL hasAdToShow;

+ (GIAdManager *)sharedInstance;
- (void)presentAdFromViewController:(UIViewController *)viewController;

@end
