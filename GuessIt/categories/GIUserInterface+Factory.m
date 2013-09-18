//
//  GIUserInterface+Factory.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 14/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIUserInterface+Factory.h"

#import "GIUserInterfaceElement+Factory.h"

@implementation GIUserInterface (Factory)

+ (GIUserInterface *)userInterfaceWithDictionary:(NSDictionary *)dictionary {
    GIUserInterface *ui = [[GIUserInterface alloc] init];

    NSArray *elements = @[
        @"main",
        @"navigation",
        @"title",
        @"subtitle",
        @"congratulations",
        @"level",
        @"answer",
        @"placeholder",
        @"category",
        @"image",
        @"frame",
        @"keypad",
        @"letter",
        @"action",
        @"help",
        @"settings",
        @"game_over",
        @"credits",
        @"other_games"
    ];

    [elements enumerateObjectsUsingBlock:^(NSString *element, NSUInteger idx, BOOL *stop) {
        __block NSMutableString *setter = [NSMutableString stringWithString:@"set"];
        NSArray *components = [element componentsSeparatedByString:@"_"];
        [components enumerateObjectsUsingBlock:^(NSString *component, NSUInteger idx, BOOL *stop) {
            [setter appendString:[component capitalizedString]];
        }];
        [setter appendString:@":"];

        GIUserInterfaceElement *uiElement = [GIUserInterfaceElement elementWithDictionary:dictionary[element]];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [ui performSelector:NSSelectorFromString(setter) withObject:uiElement];
#pragma clang diagnostic pop
    }];

    return ui;
}

@end
