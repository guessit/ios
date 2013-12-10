//
//  GIConfiguration.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 01/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GIGame.h"
#import "GILevel.h"

@interface GIConfiguration : NSObject

@property (nonatomic, strong) GIGame *game;
@property (nonatomic, strong) GILevel *currentLevel;
@property (nonatomic, strong) GILevel *lastLevel;

@property (nonatomic, strong, readonly) NSArray *allProducts;
@property (nonatomic, strong) NSArray *donationProducts;
@property (nonatomic, strong) NSArray *bundleProducts;

@property (nonatomic, assign) NSInteger numberOfLevelsPresented;
@property (nonatomic, assign) NSInteger numberOfHelpRequested;

@property (nonatomic, assign) BOOL showAds;

@property (nonatomic, assign, readonly) BOOL hasMoreLevels;

+ (instancetype)sharedInstance;

- (GILevel *)loadNextLevel;
- (void)resetProgress;
- (NSArray *)boughtBundles;
- (NSArray *)finishedLevelsName;
- (void)resetAfterShowingAd;

- (void)markBundleBought:(NSString *)bundleName;
- (void)loadInAppPurchasesProducts;

@end
