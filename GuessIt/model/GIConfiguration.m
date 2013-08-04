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
#import "GILevel.h"
#import <SSToolkit/SSCategories.h>

@interface GIConfiguration ()

@property (nonatomic, strong) NSDictionary *gameData;
@property (nonatomic, strong, readonly) NSString *currentLevelName;

- (void)_initialize;

@end

@implementation GIConfiguration

#pragma mark - Getter

- (GILevel *)currentLevel {
    GILevel *currentLevel = nil;

    NSString *currentLevelName = self.currentLevelName;
    if (!currentLevelName) {
        currentLevel = [self loadNextLevel];
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"imageName == %@", self.currentLevelName];
        NSArray *currentLevelArray = [self.game.todoLevels filteredArrayUsingPredicate:predicate];

        if (currentLevelArray.count > 0) {
            currentLevel = currentLevelArray.firstObject;
        }
    }

    return currentLevel;
}

- (NSString *)currentLevelName {
    return [[NSUserDefaults standardUserDefaults] stringForKey:GI_CURRENT_LEVEL];
}

- (NSInteger)numberOfLevelsPresented {
    return [[NSUserDefaults standardUserDefaults] integerForKey:GI_NUMBER_OF_LEVELS_PRESENTED];
}

- (BOOL)showAds {
    return [[NSUserDefaults standardUserDefaults] boolForKey:GI_SHOW_ADS];
}

#pragma mark - Setter

- (void)setCurrentLevel:(GILevel *)currentLevel {
    self.numberOfLevelsPresented += 1;

    [[NSUserDefaults standardUserDefaults] setObject:currentLevel.imageName forKey:GI_CURRENT_LEVEL];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:GICurrentLevelDidChangeNotification
                                                        object:currentLevel];
}

- (void)setNumberOfLevelsPresented:(NSInteger)numberOfLevelsPresented {
    [[NSUserDefaults standardUserDefaults] setInteger:numberOfLevelsPresented forKey:GI_NUMBER_OF_LEVELS_PRESENTED];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setShowAds:(BOOL)showAds {
    [[NSUserDefaults standardUserDefaults] setBool:showAds forKey:GI_SHOW_ADS];
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

    GILevel *nextLevel = nil;

    if ([self.game.options[@"randomize"] boolValue]) {
        nextLevel = todoLevels.randomObject;
    } else {
        nextLevel = todoLevels.firstObject;
    }

    self.currentLevel = nextLevel;

    return nextLevel;
}

- (void)resetProgress {
    [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:GI_FINISHED_LEVELS];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:GI_CURRENT_LEVEL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (NSArray *)finishedLevelsName {
    return [[NSUserDefaults standardUserDefaults] arrayForKey:GI_FINISHED_LEVELS];
}

#pragma mark - Private Interface

- (void)_initialize {
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

    self.showAds = YES;
}

@end