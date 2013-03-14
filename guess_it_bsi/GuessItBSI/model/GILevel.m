//
//  GILevel.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 13/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevel.h"

@implementation GILevel

#pragma mark - Public Methods

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
