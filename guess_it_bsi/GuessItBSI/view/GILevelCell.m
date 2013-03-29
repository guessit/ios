//
//  GILevelCell.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 29/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevelCell.h"

@implementation GILevelCell

#pragma mark - Setter

- (void)setLevel:(GILevel *)level {
    if (_level != level) {
        _level = level;

        self.nameLabel.text = level.name;
        self.progressLabel.text = [NSString stringWithFormat:@"%02d/%02d", 0, level.guessingItems.count];
    }
}

@end
