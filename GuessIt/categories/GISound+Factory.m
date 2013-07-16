//
//  GISound+Factory.m
//  GuessIt
//
//  Created by Marlon Andrade on 16/07/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GISound+Factory.h"

#import "FISoundEngine.h"

@implementation GISound (Factory)

+ (GISound *)soundWithDictionary:(NSDictionary *)dictionary {
    GISound *sound = [[GISound alloc] init];

    FISoundEngine *engine = [FISoundEngine sharedEngine];
    sound.keypad = [engine soundNamed:dictionary[@"keystroke"] error:NULL];
    sound.levelFinished = [engine soundNamed:dictionary[@"success"] error:NULL];

    return sound;
}

@end
