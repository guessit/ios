//
//  GIGame.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 02/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIGame.h"

#import "GIDataSource.h"
#import "GILevel.h"

@interface GIGame ()

- (void)_initialize;

@end

@implementation GIGame

#pragma mark - Getter

- (NSArray *)todoLevels {
    NSArray *finishedItemsImages = [GIGame finishedLevelsName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"not (imageName in %@)", finishedItemsImages];
    return [self.levels filteredArrayUsingPredicate:predicate];
}

- (NSArray *)finishedLevels {
    NSArray *finishedItemsImages = [GIGame finishedLevelsName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"imageName in %@", finishedItemsImages];
    return [self.levels filteredArrayUsingPredicate:predicate];
}

#pragma mark - NSObject

- (id)init {
    self = [super init];
    if (self) {
        [self _initialize];
    }

    return self;
}

#pragma mark - Private Interface

- (void)_initialize {
    self.levels = [[GIDataSource dataSource] loadLevels];
}

#pragma mark - Public Interface

+ (GIGame *)game {
    static GIGame *__game;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __game = [[GIGame alloc] init];
    });
    return __game;
}

+ (NSArray *)finishedLevelsName {
    return [[NSUserDefaults standardUserDefaults] arrayForKey:GI_FINISHED_LEVELS];
}

@end
