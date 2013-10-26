//
//  GIGame.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 02/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIGame.h"

#import "GIConfiguration.h"

@interface GIGame ()

@property (nonatomic, strong, readonly) NSArray *availableLevels;

@end

@implementation GIGame

#pragma mark - Getter

- (NSArray *)availableLevels {
    NSMutableArray *bundles = [NSMutableArray arrayWithObject:@""];
    [bundles addObjectsFromArray:[GIConfiguration sharedInstance].boughtBundles];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bundle in %@", bundles];
    return [self.levels filteredArrayUsingPredicate:predicate];
}

- (NSArray *)todoLevels {
    NSArray *finishedItemsImages = [GIConfiguration sharedInstance].finishedLevelsName;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"not (imageName in %@)", finishedItemsImages];
    return [self.availableLevels filteredArrayUsingPredicate:predicate];
}

- (NSArray *)finishedLevels {
    NSArray *finishedItemsImages = [GIConfiguration sharedInstance].finishedLevelsName;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"imageName in %@", finishedItemsImages];
    return [self.levels filteredArrayUsingPredicate:predicate];
}

- (CGFloat)progress {
    return (CGFloat) self.finishedLevels.count / (CGFloat) self.availableLevels.count;
}

@end
