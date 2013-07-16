//
//  GISound.m
//  GuessIt
//
//  Created by Marlon Andrade on 16/07/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GISound.h"

@implementation GISound

#pragma mark - Public Interface

- (void)playKeypadSound {
    [self.keypad play];
}

- (void)playLevelFinishedSound {
    [self.levelFinished play];
}

@end
