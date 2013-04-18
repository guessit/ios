//
//  GILevelCell.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 29/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevelCell.h"

@interface GILevelCell()

- (void)_initialize;

@end

@implementation GILevelCell

#pragma mark - Setter

- (void)setLevel:(GILevel *)level {
    if (_level != level) {
        _level = level;

        self.nameLabel.text = level.name;
        self.progressLabel.text = level.progress;
    }
}

#pragma mark - Designated Initializer

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initialize];
    }
    return self;
}

#pragma mark - Private Interface

- (void)_initialize {
    self.accessoryView = [UIImageView imageViewWithImageNamed:@"ico_accessory_view"];
}

@end
