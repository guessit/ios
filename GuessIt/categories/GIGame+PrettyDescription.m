//
//  GIGame+PrettyDescription.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/15/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIGame+PrettyDescription.h"

#import "GIGame.h"
#import "GILevel+PrettyDescription.h"

@implementation GIGame (PrettyDescription)

- (NSString *)prettyDescription {
    NSMutableArray *levelsDescription = [NSMutableArray arrayWithCapacity:self.levels.count];
    [self.levels enumerateObjectsUsingBlock:^(GILevel *level, NSUInteger idx, BOOL *stop) {
        [levelsDescription addObject:level.prettyDescription];
    }];

    NSMutableArray *finished = [NSMutableArray arrayWithCapacity:self.finishedLevels.count];
    [self.finishedLevels enumerateObjectsUsingBlock:^(GILevel *level, NSUInteger idx, BOOL *stop) {
        [finished addObject:level.prettyDescription];
    }];

    NSMutableArray *todo = [NSMutableArray arrayWithCapacity:self.todoLevels.count];
    [self.self.todoLevels enumerateObjectsUsingBlock:^(GILevel *level, NSUInteger idx, BOOL *stop) {
        [todo addObject:level.prettyDescription];
    }];

    return [NSString stringWithFormat:@"Game: %@ <levels: [%@], finished: [%@], todo: [%@]>",
            self, levelsDescription, finished, todo];
}

@end
