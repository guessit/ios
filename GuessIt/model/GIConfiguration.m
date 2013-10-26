//
//  GIConfiguration.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 01/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIConfiguration.h"

#import "GIDefinitions.h"
#import "GIGame.h"
#import "GIGame+Factory.h"
#import "GIIAPManager.h"
#import "GILevel.h"
#import "GAI.h"
#import <iRate/iRate.h>
#import <SSToolkit/SSCategories.h>

@interface GIConfiguration ()

@property (nonatomic, strong) NSDictionary *gameData;
@property (nonatomic, strong, readonly) NSString *currentLevelName;

- (void)_initialize;
- (void)_loadGameFromJson;
- (void)_setupiRate;
- (void)_setupAnalytics;
- (void)_observePaymentQueue;
- (NSInteger)_integerForKey:(NSString *)key;
- (void)_setInteger:(NSInteger)integer forKey:(NSString *)key;

@end

@implementation GIConfiguration

#pragma mark - Getter

- (GILevel *)currentLevel {
    GILevel *currentLevel = nil;

    NSString *currentLevelName = self.currentLevelName;
    if (!currentLevelName) {
        currentLevel = [self loadNextLevel];
    } else if ([currentLevelName isEqualToString:@"guessit_final"]) {
        currentLevel = self.lastLevel;
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"imageName == %@", self.currentLevelName];
        NSArray *currentLevelArray = [self.game.todoLevels filteredArrayUsingPredicate:predicate];

        if (currentLevelArray.count > 0) {
            currentLevel = currentLevelArray.firstObject;
        }
    }

    return currentLevel;
}

- (GILevel *)lastLevel {
    if (!_lastLevel) {
        _lastLevel = [GILevel lastLevel];
    }
    return _lastLevel;
}

- (NSString *)currentLevelName {
    NSString *currentLevelName = [[NSUserDefaults standardUserDefaults] stringForKey:GI_CURRENT_LEVEL];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"imageName == %@", currentLevelName];
    NSArray *currentLevelFinished = [self.game.finishedLevels filteredArrayUsingPredicate:predicate];

    if (currentLevelFinished.count == 1) {
        currentLevelName = nil;
    }

    return currentLevelName;
}

- (NSInteger)numberOfLevelsPresented {
    return [self _integerForKey:GI_NUMBER_OF_LEVELS_PRESENTED];
}

- (NSInteger)numberOfHelpRequested {
    return [self _integerForKey:GI_NUMBER_OF_HELPS_REQUESTED];
}

- (BOOL)showAds {
    return [self _integerForKey:GI_SHOW_ADS] != 42;
}

- (BOOL)hasMoreLevels {
    return self.currentLevel && self.currentLevel != self.lastLevel;
}

#pragma mark - Setter

- (void)setCurrentLevel:(GILevel *)currentLevel {
    [[NSUserDefaults standardUserDefaults] setObject:currentLevel.imageName forKey:GI_CURRENT_LEVEL];
    [[NSUserDefaults standardUserDefaults] synchronize];

    if (currentLevel) {
        self.numberOfLevelsPresented += 1;
        [[NSNotificationCenter defaultCenter] postNotificationName:GICurrentLevelDidChangeNotification
                                                            object:currentLevel];
    }
}

- (void)setNumberOfLevelsPresented:(NSInteger)numberOfLevelsPresented {
    [self _setInteger:numberOfLevelsPresented forKey:GI_NUMBER_OF_LEVELS_PRESENTED];
}

- (void)setNumberOfHelpRequested:(NSInteger)numberOfHelpRequested {
    [self _setInteger:numberOfHelpRequested forKey:GI_NUMBER_OF_HELPS_REQUESTED];
}

- (void)setShowAds:(BOOL)showAds {
    NSInteger value = showAds ? 0 : 42;
    [self _setInteger:value forKey:GI_SHOW_ADS];
}

#pragma mark - NSObject Methods

- (id)init {
    self = [super init];
    if (self) {
        [self _initialize];
    }
    return self;
}

#pragma mark - Public Interface

+ (instancetype)sharedInstance {
    static GIConfiguration *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[GIConfiguration alloc] init];
    });
    return __sharedInstance;
}

- (GILevel *)loadNextLevel {
    NSArray *todoLevels = self.game.todoLevels;
    if (self.currentLevelName) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"imageName != %@", self.currentLevelName];
        todoLevels = [todoLevels filteredArrayUsingPredicate:predicate];
    }

    NSLog(@"Todo levels: %@", todoLevels);

    GILevel *nextLevel = nil;

    if ([self.game.options[@"randomize"] boolValue]) {
        nextLevel = todoLevels.randomObject;
    } else {
        nextLevel = todoLevels.firstObject;
    }

    if (!nextLevel && !self.lastLevel.isFinished) {
        nextLevel = self.lastLevel;
    }

    self.currentLevel = nextLevel;

    return nextLevel;
}

- (void)resetProgress {
    [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:GI_FINISHED_LEVELS];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:GI_CURRENT_LEVEL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)boughtBundles {
    return [[NSUserDefaults standardUserDefaults] arrayForKey:GI_BOUGHT_BUNDLES];
}

- (NSArray *)finishedLevelsName {
    return [[NSUserDefaults standardUserDefaults] arrayForKey:GI_FINISHED_LEVELS];
}

- (void)resetAfterShowingAd {
    self.numberOfLevelsPresented = 0;
    self.numberOfHelpRequested = 0;
}

- (void)markBundleBought:(NSString *)bundleName {
    NSMutableArray *boughtBundles = [NSMutableArray arrayWithArray:self.boughtBundles];
    if (![boughtBundles containsObject:bundleName]) {
        [boughtBundles addObject:bundleName];

        [[NSUserDefaults standardUserDefaults] setObject:boughtBundles forKey:GI_BOUGHT_BUNDLES];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)loadInAppPurchasesProducts {
    [[GIIAPManager sharedInstance] fetchProductsWithBlock:^(NSArray *products) {
        self.products = products;
        [[NSNotificationCenter defaultCenter] postNotificationName:GIProductsDidFinishLoadingNotification object:nil];
    }];
}

#pragma mark - Private Interface

- (void)_initialize {
    [self _observePaymentQueue];
    [self _loadGameFromJson];
    [self _setupiRate];
    [self _setupAnalytics];
    [self loadInAppPurchasesProducts];
}

- (void)_loadGameFromJson {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"game" ofType:@"json"];
    NSInputStream *jsonFileStream = [NSInputStream inputStreamWithFileAtPath:jsonPath];
    [jsonFileStream open];

    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithStream:jsonFileStream
                                                           options:0
                                                             error:&error];
    [jsonFileStream close];

    if (error) {
        NSLog(@"Error: %@", error);
        NSLog(@"%@", error.localizedDescription);
    }

    if (json) {
        self.game = [GIGame gameWithDictionary:json];
    }
}

- (void)_setupiRate {
    [iRate sharedInstance].applicationName = @"GuessIt";
    [iRate sharedInstance].daysUntilPrompt = 3.f;
    [iRate sharedInstance].promptAgainForEachNewVersion = NO;
}

- (void)_setupAnalytics {
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 30;
    [[GAI sharedInstance] trackerWithTrackingId:self.game.analyticsTrackingId];
}

- (void)_observePaymentQueue {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:[GIIAPManager sharedInstance]];
}

- (NSInteger)_integerForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

- (void)_setInteger:(NSInteger)integer forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setInteger:integer forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end