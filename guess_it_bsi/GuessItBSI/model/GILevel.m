//
//  GILevel.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 26/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevel.h"

@implementation GILevel

#pragma mark - Getter

- (NSArray *)finishedItems {
    NSArray *finishedItemsImages = [[NSUserDefaults standardUserDefaults] arrayForKey:self.name];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"imageName in %@", finishedItemsImages];
    return [self.items filteredArrayUsingPredicate:predicate];
}

- (NSArray *)todoItems {
    NSArray *finishedItemsImages = [[NSUserDefaults standardUserDefaults] arrayForKey:self.name];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"not (imageName in %@)", finishedItemsImages];
    return [self.items filteredArrayUsingPredicate:predicate];
}

#pragma mark - Public Interface

+ (instancetype)levelWithName:(NSString *)name {
    return [[self alloc] initWithName:name];
}

- (id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

@end
