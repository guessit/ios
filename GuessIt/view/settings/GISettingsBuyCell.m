//
//  GISettingsBuyCell.m
//  GuessIt
//
//  Created by Marlon Andrade on 26/09/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GISettingsBuyCell.h"

#import "MALazykit.h"
#import "UIView+CBFrameHelpers.h"

@implementation GISettingsBuyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.priceLabel = [UILabel label];
        UIFont *font = [self.textLabel.font fontWithSize:self.textLabel.font.pointSize + 10.f];
        self.priceLabel.font = font;
        self.priceLabel.textColor = self.textLabel.textColor;
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.shadowColor = self.textLabel.shadowColor;
        self.priceLabel.shadowOffset = self.textLabel.shadowOffset;

        [self.contentView addSubview:self.priceLabel];
    }
    return self;
}

#pragma mark - UIView Methods

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.priceLabel sizeToFit];

    CGFloat x = self.contentView.width - (self.priceLabel.width / 2.f) - 15.f;
    self.priceLabel.center = CGPointMake(x, self.contentView.center.y);

    self.textLabel.w = self.textLabel.width - (self.priceLabel.width + 10.f);
}

@end
