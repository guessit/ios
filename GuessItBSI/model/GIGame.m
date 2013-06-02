//
//  GIGame.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 02/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIGame.h"

#import "GIConfiguration.h"

@implementation GIGame

#pragma mark - Getter

- (NSArray *)todoLevels {
    NSArray *finishedItemsImages = [GIConfiguration sharedInstance].finishedLevelsName;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"not (imageName in %@)", finishedItemsImages];
    return [self.levels filteredArrayUsingPredicate:predicate];
}

- (NSArray *)finishedLevels {
    NSArray *finishedItemsImages = [GIConfiguration sharedInstance].finishedLevelsName;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"imageName in %@", finishedItemsImages];
    return [self.levels filteredArrayUsingPredicate:predicate];
}
@end
