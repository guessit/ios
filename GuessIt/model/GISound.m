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

- (void)playFailSound {
    [self.fail play];
}

- (void)playLevelFinishedSound {
    [self.levelFinished play];
}

- (void)playRemoveLetterSound {
    [self.removeLetter play];
}

- (void)playCatEasterEggSound {
    [self.catEasterEgg play];
}

@end
