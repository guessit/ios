//
//  GILevel+Factory.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 02/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevel+Factory.h"

@implementation GILevel (Factory)

+ (GILevel *)levelWithDictionary:(NSDictionary *)dictionary {
    GILevel *level = [[GILevel alloc] init];
    level.imageName = dictionary[@"image"];
    level.answer = NSLocalizedStringFromTable(level.imageName, @"items", nil).uppercaseString;
    level.hints = dictionary[@"hints"];
    level.category = dictionary[@"category"];

    return level;
}

@end
