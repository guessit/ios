//
//  GIGameOverCongratulationsView.m
//  GuessIt
//
//  Created by Marlon Andrade on 16/09/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIGameOverCongratulationsView.h"

#import "GIConfiguration.h"
#import "GIDefinitions.h"
#import "GIIconButton.h"
#import "GIUserInterfaceElement.h"
#import "GIShineLabel.h"
#import "MALazykit.h"
#import "UIFont+GuessItFonts.h"
#import "UIView+CBFrameHelpers.h"

@interface GIGameOverCongratulationsView ()

@property (nonatomic, strong, readonly) GIUserInterfaceElement *ui;

@property (nonatomic, strong) GIShineLabel *congratulationsLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *resetProgressLabel;

@property (nonatomic, strong) UIButton *facebookButton;
@property (nonatomic, strong) UIButton *twitterButton;

- (void)_initialize;
- (void)_facebookTouched:(id)sender;
- (void)_twitterTouched:(id)sender;

@end

@implementation GIGameOverCongratulationsView

#pragma mark - Getter

- (GIUserInterfaceElement *)ui {
    return [GIConfiguration sharedInstance].game.interface.gameOver;
}

- (GIShineLabel *)congratulationsLabel {
    if (!_congratulationsLabel) {
        _congratulationsLabel = [GIShineLabel label];
        _congratulationsLabel.text = NSLocalizedStringFromTable(@"congratulations", @"game_over", nil);
        _congratulationsLabel.backgroundColor = [UIColor clearColor];
        _congratulationsLabel.font = [UIFont guessItGameOverCongratulationsFont];
        _congratulationsLabel.textColor = self.ui.textColor;
        _congratulationsLabel.shineColor = self.ui.secondaryColor;
        _congratulationsLabel.shadowColor = self.ui.shadowColor;
        _congratulationsLabel.shadowOffset = CGSizeMake(0.f, -1.f);
        _congratulationsLabel.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-5.f));
        [_congratulationsLabel sizeToFit];
    }
    return _congratulationsLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel label];
        _descriptionLabel.text = NSLocalizedStringFromTable(@"description", @"game_over", nil);
        _descriptionLabel.backgroundColor = [UIColor clearColor];
        _descriptionLabel.font = [UIFont guessItGameOverDescriptionFont];
        _descriptionLabel.textColor = self.ui.secondaryTextColor;
        _descriptionLabel.shadowColor = self.ui.secondaryShadowColor;
        _descriptionLabel.shadowOffset = CGSizeMake(0.f, -1.f);
        _descriptionLabel.transform = self.congratulationsLabel.transform;
        [_descriptionLabel sizeToFit];
    }
    return _descriptionLabel;
}

- (UILabel *)resetProgressLabel {
    if (!_resetProgressLabel) {
        _resetProgressLabel = [UILabel label];
        _resetProgressLabel.text = NSLocalizedStringFromTable(@"reset_progress", @"game_over", nil);
        _resetProgressLabel.backgroundColor = [UIColor clearColor];
        _resetProgressLabel.textAlignment = NSTextAlignmentCenter;
        _resetProgressLabel.font = [UIFont guessItGameOverResetProgressFont];
        _resetProgressLabel.textColor = self.ui.secondaryTextColor;
        _resetProgressLabel.shadowColor = self.ui.secondaryShadowColor;
        _resetProgressLabel.shadowOffset = CGSizeMake(0.f, -1.f);
        [_resetProgressLabel sizeToFit];
    }
    return _resetProgressLabel;
}

- (UIButton *)facebookButton {
    if (!_facebookButton) {
        _facebookButton = [GIIconButton facebookButton];
        _facebookButton.layer.cornerRadius = GI_CONGRATULATIONS_SHARE_BUTTON_CORNER_RADIUS;
        [_facebookButton addTarget:self
                            action:@selector(_facebookTouched:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _facebookButton;
}

- (UIButton *)twitterButton {
    if (!_twitterButton) {
        _twitterButton = [GIIconButton twitterButton];
        _twitterButton.layer.cornerRadius = GI_CONGRATULATIONS_SHARE_BUTTON_CORNER_RADIUS;
        [_twitterButton addTarget:self
                           action:@selector(_twitterTouched:)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    return _twitterButton;
}

#pragma mark - UIView Methods

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGPoint congratulationsCenter = CGPointMake(self.center.x, self.center.y - 60.f);
    self.congratulationsLabel.center = congratulationsCenter;

    CGPoint descriptionCenter = CGPointMake(self.center.x, congratulationsCenter.y + 36.f);
    self.descriptionLabel.center = descriptionCenter;

    self.resetProgressLabel.y = self.height - self.resetProgressLabel.height - 5.f;
    self.resetProgressLabel.w = self.width;

    CGFloat shareButtonY = self.resetProgressLabel.y - GI_CONGRATULATIONS_SHARE_BUTTON_HEIGHT - 2.f;
    CGFloat shareButtonWidth = floorf((self.width - (3 * GI_CONGRATULATIONS_SHARE_BUTTON_MARGIN)) / 2.f);
    CGFloat shareButtonHeight = GI_CONGRATULATIONS_SHARE_BUTTON_HEIGHT;

    CGFloat facebookButtonX = GI_CONGRATULATIONS_SHARE_BUTTON_MARGIN;
    self.facebookButton.frame = CGRectMake(facebookButtonX, shareButtonY, shareButtonWidth, shareButtonHeight);

    CGFloat twitterButtonX = facebookButtonX + shareButtonWidth + GI_CONGRATULATIONS_SHARE_BUTTON_MARGIN;
    self.twitterButton.frame = CGRectMake(twitterButtonX, shareButtonY, shareButtonWidth, shareButtonHeight);
}

#pragma mark - Private Methods

- (void)_initialize {
    self.backgroundColor = self.ui.backgroundColor;

    [self addSubview:self.descriptionLabel];
    [self addSubview:self.congratulationsLabel];
    [self addSubview:self.resetProgressLabel];
    [self addSubview:self.facebookButton];
    [self addSubview:self.twitterButton];

    [self.congratulationsLabel shine];
}

- (void)_facebookTouched:(id)sender {
    [self.gameOverDelegate gameOverViewDidRequestToPostOnFacebook:nil];
}

- (void)_twitterTouched:(id)sender {
    [self.gameOverDelegate gameOverViewDidRequestToPostOnTwitter:nil];
}

@end
