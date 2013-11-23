//
//  GIGame+Factory.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 02/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIGame+Factory.h"
#import "GILevel+Factory.h"
#import "GISound+Factory.h"
#import "GIUserInterface+Factory.h"

@implementation GIGame (Factory)

+ (GIGame *)gameWithDictionary:(NSDictionary *)dictionary {
    GIGame *game = [[GIGame alloc] init];
    game.name = dictionary[@"name"];

    NSArray *levels = dictionary[@"levels"];
    NSMutableArray *gameLevels = [NSMutableArray arrayWithCapacity:levels.count];

    for (NSDictionary *level in levels) {
        [gameLevels addObject:[GILevel levelWithDictionary:level]];
    }

    game.options = dictionary[@"options"];
    game.interface = [GIUserInterface userInterfaceWithDictionary:dictionary[@"ui"]];
    game.sound = [GISound soundWithDictionary:dictionary[@"sound"]];
    game.levels = gameLevels;
    game.bundles = dictionary[@"bundles"];
    game.adMediationId = dictionary[@"ad_mediation_id"];
    game.analyticsTrackingId = dictionary[@"analytics_tracking_id"];

    return game;
}

@end
