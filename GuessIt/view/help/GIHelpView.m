//
//  GIHelpView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 11/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIHelpView.h"

#import "GIConfiguration.h"
#import "GIDefinitions.h"
#import "GIIconButton.h"
#import "UIView+CBFrameHelpers.h"

@interface GIHelpView ()

@property (nonatomic, strong, readonly) GIUserInterfaceElement *ui;

@property (nonatomic, strong) UIButton *placeCorrectLetterButton;
@property (nonatomic, strong) UIButton *eliminateWrongLetterButton;
@property (nonatomic, strong) UIButton *skipLevelButton;
@property (nonatomic, strong) GIIconButton *facebookButton;
@property (nonatomic, strong) GIIconButton *twitterButton;

- (void)_initialize;

- (void)_placeCorrectLetterTouched:(id)sender;
- (void)_eliminateWrongLetterTouched:(id)sender;
- (void)_skipLevelTouched:(id)sender;
- (void)_facebookTouched:(id)sender;
- (void)_twitterTouched:(id)sender;

@end

@implementation GIHelpView

#pragma mark - Getter

- (GIUserInterfaceElement *)ui {
    return [GIConfiguration sharedInstance].game.interface.help;
}

- (UIButton *)placeCorrectLetterButton {
    if (!_placeCorrectLetterButton) {
        _placeCorrectLetterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _placeCorrectLetterButton.backgroundColor = self.ui.secondaryBackgroundColor;

        CGFloat x = GI_HELP_VIEW_PADDING;
        CGFloat y = GI_HELP_VIEW_PADDING;
        CGFloat width = self.width - (2 * GI_HELP_VIEW_PADDING);
        CGFloat height = GI_HELP_BUTTON_HEIGHT;

        _placeCorrectLetterButton.frame = CGRectMake(x, y, width, height);
        _placeCorrectLetterButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        [_placeCorrectLetterButton setTitle:@"Place correct letter" forState:UIControlStateNormal];
        [_placeCorrectLetterButton addTarget:self
                                     action:@selector(_placeCorrectLetterTouched:)
                           forControlEvents:UIControlEventTouchUpInside];
    }
    return _placeCorrectLetterButton;
}

- (UIButton *)eliminateWrongLetterButton {
    if (!_eliminateWrongLetterButton) {
        _eliminateWrongLetterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _eliminateWrongLetterButton.backgroundColor = self.ui.secondaryBackgroundColor;

        CGFloat x = GI_HELP_VIEW_PADDING;
        CGFloat y = (2 * GI_HELP_VIEW_PADDING) + GI_HELP_BUTTON_HEIGHT;
        CGFloat width = self.width - (2 * GI_HELP_VIEW_PADDING);
        CGFloat height = GI_HELP_BUTTON_HEIGHT;

        _eliminateWrongLetterButton.frame = CGRectMake(x, y, width, height);
        _eliminateWrongLetterButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        [_eliminateWrongLetterButton setTitle:@"Eliminate wrong letter" forState:UIControlStateNormal];
        [_eliminateWrongLetterButton addTarget:self
                                        action:@selector(_eliminateWrongLetterTouched:)
                              forControlEvents:UIControlEventTouchUpInside];
    }
    return _eliminateWrongLetterButton;
}

- (UIButton *)skipLevelButton {
    if (!_skipLevelButton) {
        _skipLevelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipLevelButton.backgroundColor = self.ui.secondaryBackgroundColor;

        CGFloat x = GI_HELP_VIEW_PADDING;
        CGFloat y = (3 * GI_HELP_VIEW_PADDING) + (2 * GI_HELP_BUTTON_HEIGHT);
        CGFloat width = self.width - (2 * GI_HELP_VIEW_PADDING);
        CGFloat height = GI_HELP_BUTTON_HEIGHT;

        _skipLevelButton.frame = CGRectMake(x, y, width, height);
        _skipLevelButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        [_skipLevelButton setTitle:@"Skip level" forState:UIControlStateNormal];
        [_skipLevelButton addTarget:self
                             action:@selector(_skipLevelTouched:)
                   forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipLevelButton;
}

- (UIButton *)facebookButton {
    if (!_facebookButton) {
        _facebookButton = [GIIconButton facebookButton];

        CGFloat x = GI_HELP_VIEW_PADDING;
        CGFloat y = self.height - GI_HELP_BUTTON_HEIGHT - GI_HELP_VIEW_PADDING;
        CGFloat width = (self.width - (3 * GI_HELP_VIEW_PADDING)) / 2.f;
        CGFloat height = GI_HELP_BUTTON_HEIGHT;

        _facebookButton.frame = CGRectMake(x, y, width, height);
        _facebookButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        [_facebookButton addTarget:self
                            action:@selector(_facebookTouched:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _facebookButton;
}

- (UIButton *)twitterButton {
    if (!_twitterButton) {
        _twitterButton = [GIIconButton twitterButton];

        CGFloat width = (self.width - (3 * GI_HELP_VIEW_PADDING)) / 2.f;
        CGFloat height = GI_HELP_BUTTON_HEIGHT;
        CGFloat x = 2 * GI_HELP_VIEW_PADDING + width;
        CGFloat y = self.height - GI_HELP_BUTTON_HEIGHT - GI_HELP_VIEW_PADDING;

        _twitterButton.frame = CGRectMake(x, y, width, height);
        _twitterButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;

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

#pragma mark - Private Interface

- (void)_initialize {
    self.backgroundColor = self.ui.backgroundColor;

    [self addSubview:self.placeCorrectLetterButton];
    [self addSubview:self.eliminateWrongLetterButton];
    [self addSubview:self.skipLevelButton];
    [self addSubview:self.facebookButton];
    [self addSubview:self.twitterButton];
}

#pragma mark - IBActions

- (void)_placeCorrectLetterTouched:(id)sender {
    if ([self.delegate helpViewCanPlaceCorrectLetter:self]) {
        [self.delegate helpViewDidRequestToPlaceCorrectLetter:self];
    } else {
        #warning TODO: make PAN sound
    }
}

- (void)_eliminateWrongLetterTouched:(id)sender {
    if ([self.delegate helpViewCanEliminateWrongLetter:self]) {
        [self.delegate helpViewDidRequestToEliminateWrongLetter:self];
    } else {
        #warning TODO: make PAN sound
    }
}

- (void)_skipLevelTouched:(id)sender {
    GIConfiguration *conf = [GIConfiguration sharedInstance];
    if (conf.game.todoLevels.count > 1) {
        conf.numberOfHelpRequested += 1;
        [self.delegate helpViewDidRequestToSkipLevel:self];
    }
}

- (void)_facebookTouched:(id)sender {
    [self.delegate helpViewDidRequestToPostOnFacebook:self];
}

- (void)_twitterTouched:(id)sender {
    [self.delegate helpViewDidRequestToPostOnTwitter:self];
}

@end
