//
//  GIGame.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 02/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GIGame : NSObject

@property (nonatomic, strong) NSArray *levels;
@property (nonatomic, strong, readonly) NSArray *todoLevels;
@property (nonatomic, strong, readonly) NSArray *finishedLevels;

+ (GIGame *)game;

+ (NSArray *)finishedLevelsName;

@end
