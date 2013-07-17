//
//  GISound.h
//  GuessIt
//
//  Created by Marlon Andrade on 16/07/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FISound.h"

@interface GISound : NSObject

@property (nonatomic, strong) FISound *keypad;
@property (nonatomic, strong) FISound *levelFinished;
@property (nonatomic, strong) FISound *removeLetter;

- (void)playKeypadSound;
- (void)playLevelFinishedSound;
- (void)playRemoveLetterSound;

@end
