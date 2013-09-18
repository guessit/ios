//
//  GIUserInterface.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 14/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GIUserInterfaceElement.h"

@interface GIUserInterface : NSObject

@property (nonatomic, strong) GIUserInterfaceElement *main;
@property (nonatomic, strong) GIUserInterfaceElement *navigation;
@property (nonatomic, strong) GIUserInterfaceElement *title;
@property (nonatomic, strong) GIUserInterfaceElement *subtitle;
@property (nonatomic, strong) GIUserInterfaceElement *congratulations;
@property (nonatomic, strong) GIUserInterfaceElement *level;
@property (nonatomic, strong) GIUserInterfaceElement *answer;
@property (nonatomic, strong) GIUserInterfaceElement *placeholder;
@property (nonatomic, strong) GIUserInterfaceElement *category;
@property (nonatomic, strong) GIUserInterfaceElement *image;
@property (nonatomic, strong) GIUserInterfaceElement *frame;
@property (nonatomic, strong) GIUserInterfaceElement *keypad;
@property (nonatomic, strong) GIUserInterfaceElement *letter;
@property (nonatomic, strong) GIUserInterfaceElement *action;
@property (nonatomic, strong) GIUserInterfaceElement *help;
@property (nonatomic, strong) GIUserInterfaceElement *settings;
@property (nonatomic, strong) GIUserInterfaceElement *gameOver;
@property (nonatomic, strong) GIUserInterfaceElement *credits;
@property (nonatomic, strong) GIUserInterfaceElement *otherGames;

@end