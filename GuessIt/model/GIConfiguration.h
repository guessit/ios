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

@property (nonatomic, assign) NSInteger numberOfLevelsPresented;
@property (nonatomic, assign) NSInteger numberOfHelpRequested;

@property (nonatomic, assign) BOOL showAds;

+ (instancetype)sharedInstance;

- (GILevel *)loadNextLevel;
- (void)resetProgress;
- (NSArray *)finishedLevelsName;
- (void)resetAfterShowingAd;

@end
