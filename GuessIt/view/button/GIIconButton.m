//
//  GIIconButton.m
//  GuessIt
//
//  Created by Marlon Andrade on 08/21/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIIconButton.h"

#import "MALazykit.h"
#import "UIView+CBFrameHelpers.h"
#import "UIFont+FontAwesome.h"
#import "UIFont+GuessItFonts.h"

@interface GIIconButton ()

@property (nonatomic, strong) FAImageView *imageButton;

- (void)_initialize;

@end

@implementation GIIconButton

#pragma mark - Getter

- (FAImageView *)imageButton {
    if (!_imageButton) {
        _imageButton = [FAImageView view];
        _imageButton.image = nil;
    }
    return _imageButton;
}

- (FAIcon)icon {
    return self.imageButton.defaultIcon;
}

#pragma mark - Setter

- (void)setIcon:(FAIcon)icon {
    self.imageButton.defaultIcon = icon;
}

#pragma mark - UIView Methods

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}

#pragma mark - Designated Initializer

+ (instancetype)buttonWithIcon:(FAIcon)icon {
    GIIconButton *button = [GIIconButton buttonWithType:UIButtonTypeCustom];
    button.icon = icon;
    button.titleLabel.font = [UIFont guessItIconButtonFont];
    [button setTitleColor:[UIColor colorWithWhite:1.f alpha:0.9f] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithWhite:0.f alpha:0.2f] forState:UIControlStateNormal];
    button.titleLabel.shadowOffset = CGSizeMake(0.f, -1.f);
    button.titleEdgeInsets = UIEdgeInsetsMake(2.f, 0.f, 0.f, 0.f);
    return button;
}

+ (instancetype)facebookButton {
    GIIconButton *facebookButton = [GIIconButton buttonWithIcon:FAIconFacebookSign];

    facebookButton.backgroundColor = GI_FACEBOOK_BACKGROUND_COLOR;
    facebookButton.layer.borderWidth = GI_SOCIAL_BUTTON_BORDER_WIDTH;
    facebookButton.layer.borderColor = GI_SOCIAL_BUTTON_BORDER_COLOR;

    [facebookButton setTitle:@"Facebook" forState:UIControlStateNormal];

    return facebookButton;
}

+ (instancetype)twitterButton {
    GIIconButton *twitterButton = [GIIconButton buttonWithIcon:FAIconTwitterSign];

    twitterButton.backgroundColor = GI_TWITTER_BACKGROUND_COLOR;
    twitterButton.layer.borderWidth = GI_SOCIAL_BUTTON_BORDER_WIDTH;
    twitterButton.layer.borderColor = GI_SOCIAL_BUTTON_BORDER_COLOR;

    [twitterButton setTitle:@"Twitter" forState:UIControlStateNormal];

    return twitterButton;
}

#pragma mark - Private Interface

- (void)_initialize {
    [self addSubview:self.imageButton];
}

#define GI_IMAGE_BUTTON_MARGIN 10.f

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat x = GI_IMAGE_BUTTON_MARGIN;
    CGFloat y = GI_IMAGE_BUTTON_MARGIN;
    CGFloat width = self.height - 2 * GI_IMAGE_BUTTON_MARGIN;
    CGFloat height = width;
    self.imageButton.frame = CGRectMake(x, y, width, height);

    self.imageButton.defaultView.font = [UIFont iconicFontOfSize:self.imageButton.bounds.size.height];
    self.imageButton.defaultView.textColor = self.titleLabel.textColor;
    self.imageButton.defaultView.backgroundColor = [UIColor clearColor];
    self.imageButton.defaultView.shadowColor = self.titleLabel.shadowColor;
    self.imageButton.defaultView.shadowOffset = self.titleLabel.shadowOffset;

    CGFloat iconRigth = width + 2 * GI_IMAGE_BUTTON_MARGIN;
    if (iconRigth > self.titleLabel.x) {
        self.titleLabel.x = iconRigth;
    }
}

@end
