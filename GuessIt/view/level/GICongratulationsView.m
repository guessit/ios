//
//  GICongratulationsView.m
//  GuessIt
//
//  Created by Marlon Andrade on 16/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GICongratulationsView.h"

#import "GIConfiguration.h"
#import "GIDefinitions.h"
#import "GIIconButton.h"
#import "GIShineLabel.h"
#import "MALazykit.h"
#import "UIFont+GuessItFonts.h"
#import "UIView+CBFrameHelpers.h"
#import <QuartzCore/QuartzCore.h>

@interface GICongratulationsView ()

@property (nonatomic, strong, readonly) GIUserInterfaceElement *ui;
@property (nonatomic, strong) GIShineLabel *congratsLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *answerDescriptionLabel;
@property (nonatomic, strong) UILabel *answerLabel;
@property (nonatomic, strong) UIButton *facebookButton;
@property (nonatomic, strong) UIButton *twitterButton;

- (void)_initialize;

- (void)_facebookTouched:(id)sender;
- (void)_twitterTouched:(id)sender;

@end

@implementation GICongratulationsView

#pragma mark - Getter

- (GIUserInterfaceElement *)ui {
    return [GIConfiguration sharedInstance].game.interface.congratulations;
}

- (GIShineLabel *)congratsLabel {
    if (!_congratsLabel) {
        _congratsLabel = [GIShineLabel label];
        _congratsLabel.font = [UIFont guessItCongratulationTitleFont];
        _congratsLabel.text = NSLocalizedStringFromTable(@"congratulations", @"congratulations", nil);
        _congratsLabel.textColor = self.ui.textColor;
        _congratsLabel.backgroundColor = [UIColor clearColor];
        _congratsLabel.shineColor = self.ui.secondaryColor;
        _congratsLabel.shadowColor = self.ui.shadowColor;
        _congratsLabel.shadowOffset = CGSizeMake(0.f, -1.f);
        _congratsLabel.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-5.f));
        [_congratsLabel sizeToFit];
    }
    return _congratsLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel label];
        _descriptionLabel.text = NSLocalizedStringFromTable(@"correct_answer", @"congratulations", nil);
        _descriptionLabel.backgroundColor = [UIColor clearColor];
        _descriptionLabel.font = [UIFont guessItCongratulationDescriptionFont];
        _descriptionLabel.textColor = self.ui.secondaryTextColor;
        _descriptionLabel.shadowColor = self.ui.secondaryShadowColor;
        _descriptionLabel.shadowOffset = CGSizeMake(0.f, -1.f);
        _descriptionLabel.transform = self.congratsLabel.transform;
        [_descriptionLabel sizeToFit];
    }
    return _descriptionLabel;
}

- (UILabel *)answerDescriptionLabel {
    if (!_answerDescriptionLabel) {
        _answerDescriptionLabel = [UILabel label];
        _answerDescriptionLabel.text = NSLocalizedStringFromTable(@"answer_was", @"congratulations", nil);
        _answerDescriptionLabel.backgroundColor = [UIColor clearColor];
        _answerDescriptionLabel.font = [UIFont guessItCongratulationAnswerDescriptionFont];
        _answerDescriptionLabel.textColor = self.ui.secondaryTextColor;
        _answerDescriptionLabel.shadowColor = self.ui.secondaryShadowColor;
        _answerDescriptionLabel.shadowOffset = CGSizeMake(0.f, -1.f);
        [_answerDescriptionLabel sizeToFit];
    }
    return _answerDescriptionLabel;
}

- (UILabel *)answerLabel {
    if (!_answerLabel) {
        _answerLabel = [UILabel label];
        _answerLabel.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.9f];
        _answerLabel.layer.cornerRadius = 8.f;
        _answerLabel.font = [UIFont guessItCongratulationAnswerFont];
        _answerLabel.textAlignment = NSTextAlignmentCenter;
        _answerLabel.textColor = [UIColor whiteColor];
        _answerLabel.shadowColor = [UIColor colorWithWhite:0.12 alpha:1.f];
        _answerLabel.shadowOffset = CGSizeMake(0.f, -2.f);
    }
    return _answerLabel;
}

#define GI_CONGRATULATIONS_SHARE_BUTTON_MARGIN 10.f
#define GI_CONGRATULATIONS_SHARE_BUTTON_HEIGHT 45.f
#define GI_CONGRATULATIONS_SHARE_BUTTON_CORNER_RADIUS 6.f
#define GI_CONGRATULATIONS_SHARE_BUTTON_BORDER_WIDTH 1.f
#define GI_CONGRATULATIONS_SHARE_BUTTON_BORDER_COLOR [UIColor colorWithWhite:0.f alpha:0.15f].CGColor

- (UIButton *)facebookButton {
    if (!_facebookButton) {
        _facebookButton = [GIIconButton buttonWithIcon:FAIconFacebookSign];

        _facebookButton.backgroundColor = [UIColor colorWithRed:76.f/255.f green:102.f/255.f blue:164.f/255.f alpha:1.f];
        _facebookButton.layer.cornerRadius = GI_CONGRATULATIONS_SHARE_BUTTON_CORNER_RADIUS;
        _facebookButton.layer.borderWidth = GI_CONGRATULATIONS_SHARE_BUTTON_BORDER_WIDTH;
        _facebookButton.layer.borderColor = GI_CONGRATULATIONS_SHARE_BUTTON_BORDER_COLOR;

        [_facebookButton setTitle:@"Facebook" forState:UIControlStateNormal];
        [_facebookButton addTarget:self
                            action:@selector(_facebookTouched:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _facebookButton;
}

- (UIButton *)twitterButton {
    if (!_twitterButton) {
        _twitterButton = [GIIconButton buttonWithIcon:FAIconTwitterSign];

        _twitterButton.backgroundColor = [UIColor colorWithRed:0.f/255.f green:190.f/255.f blue:246.f/255.f alpha:1.f];
        _twitterButton.layer.cornerRadius = GI_CONGRATULATIONS_SHARE_BUTTON_CORNER_RADIUS;
        _twitterButton.layer.borderWidth = GI_CONGRATULATIONS_SHARE_BUTTON_BORDER_WIDTH;
        _twitterButton.layer.borderColor = GI_CONGRATULATIONS_SHARE_BUTTON_BORDER_COLOR;

        [_twitterButton setTitle:@"Twitter" forState:UIControlStateNormal];
        [_twitterButton addTarget:self
                           action:@selector(_twitterTouched:)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    return _twitterButton;
}

#pragma mark - UIView Methods

- (id)init {
    self = [super init];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.congratsLabel.center = CGPointMake(self.center.x, self.center.y - 145.f);
    self.descriptionLabel.center = CGPointMake(self.center.x, self.congratsLabel.center.y + 36.f);
    self.answerDescriptionLabel.center = CGPointMake(self.center.x, self.center.y + 55.f);

    self.answerLabel.text = self.level.answer.uppercaseString;
    [self.answerLabel sizeToFit];
    self.answerLabel.w = self.answerLabel.width + 30.f;
    self.answerLabel.center = CGPointMake(self.center.x, self.answerDescriptionLabel.center.y + 34.f);

    CGFloat shareButtonY = self.height - GI_CONGRATULATIONS_SHARE_BUTTON_MARGIN - GI_CONGRATULATIONS_SHARE_BUTTON_HEIGHT;
    CGFloat shareButtonWidth = floorf((self.width - (3 * GI_CONGRATULATIONS_SHARE_BUTTON_MARGIN)) / 2.f);
    CGFloat shareButtonHeight = GI_CONGRATULATIONS_SHARE_BUTTON_HEIGHT;

    CGFloat facebookButtonX = GI_CONGRATULATIONS_SHARE_BUTTON_MARGIN;
    _facebookButton.frame = CGRectMake(facebookButtonX, shareButtonY, shareButtonWidth, shareButtonHeight);

    CGFloat twitterButtonX = facebookButtonX + shareButtonWidth + GI_CONGRATULATIONS_SHARE_BUTTON_MARGIN;
    _twitterButton.frame = CGRectMake(twitterButtonX, shareButtonY, shareButtonWidth, shareButtonHeight);
}

#pragma mark - Private Methods

- (void)_initialize {
    [self addSubview:self.congratsLabel];
    [self.congratsLabel shine];

    [self addSubview:self.descriptionLabel];
    [self addSubview:self.answerDescriptionLabel];
    [self addSubview:self.answerLabel];
    [self addSubview:self.facebookButton];
    [self addSubview:self.twitterButton];
}

- (void)_facebookTouched:(id)sender {
    NSLog(@"Facebook!");
}

- (void)_twitterTouched:(id)sender {
    NSLog(@"Twitter!");
}

@end
