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

    ui.main = [GIUserInterfaceElement elementWithDictionary:dictionary[@"main"]];
    ui.navigation = [GIUserInterfaceElement elementWithDictionary:dictionary[@"navigation"]];
    ui.title = [GIUserInterfaceElement elementWithDictionary:dictionary[@"title"]];
    ui.subtitle = [GIUserInterfaceElement elementWithDictionary:dictionary[@"subtitle"]];
    ui.congratulations = [GIUserInterfaceElement elementWithDictionary:dictionary[@"congratulations"]];
    ui.level = [GIUserInterfaceElement elementWithDictionary:dictionary[@"level"]];
    ui.answer = [GIUserInterfaceElement elementWithDictionary:dictionary[@"answer"]];
    ui.placeholder = [GIUserInterfaceElement elementWithDictionary:dictionary[@"placeholder"]];
    ui.category = [GIUserInterfaceElement elementWithDictionary:dictionary[@"category"]];
    ui.image = [GIUserInterfaceElement elementWithDictionary:dictionary[@"image"]];
    ui.frame = [GIUserInterfaceElement elementWithDictionary:dictionary[@"frame"]];
    ui.keypad = [GIUserInterfaceElement elementWithDictionary:dictionary[@"keypad"]];
    ui.letter = [GIUserInterfaceElement elementWithDictionary:dictionary[@"letter"]];
    ui.action = [GIUserInterfaceElement elementWithDictionary:dictionary[@"action"]];
    ui.help = [GIUserInterfaceElement elementWithDictionary:dictionary[@"help"]];

    return ui;
}

@end
