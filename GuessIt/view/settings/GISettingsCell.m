//
//  GISettingsCell.m
//  GuessIt
//
//  Created by Marlon Andrade on 26/09/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GISettingsCell.h"

#import "GIConfiguration.h"
#import "GIUserInterfaceElement.h"
#import "UIFont+GuessItFonts.h"

@interface GISettingsCell ()

@property (nonatomic, strong, readonly) GIUserInterfaceElement *ui;

- (void)_initialize;

@end

@implementation GISettingsCell

#pragma mark - Getter

- (GIUserInterfaceElement *)ui {
    return [GIConfiguration sharedInstance].game.interface.settings;
}

#pragma mark - UITableViewCell Methods

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initialize];
    }
    return self;
}

#pragma mark - Private Interface

- (void)_initialize {
    self.backgroundColor = self.ui.secondaryBackgroundColor;
    self.textLabel.font = [UIFont guessItSettingsTextFont];
    self.textLabel.textColor = self.ui.secondaryTextColor;
    self.textLabel.shadowColor = self.ui.secondaryShadowColor;
    self.textLabel.shadowOffset = CGSizeMake(0.f, -1.f);
    self.textLabel.numberOfLines = 2;
}

@end
