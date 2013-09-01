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

#define GI_CORRECT_LETTER_BACKGROUND_COLOR [UIColor colorWithRed:138.f/255.f green:111.f/255.f blue:179.f/255.f alpha:1.f]
#define GI_WRONG_LETTER_BACKGROUND_COLOR [UIColor colorWithRed:179.f/255.f green:112.f/255.f blue:120.f/255.f alpha:1.f]
#define GI_SKIP_LEVEL_BACKGROUND_COLOR [UIColor colorWithRed:111.f/255.f green:160.f/255.f blue:179.f/255.f alpha:1.f]
#define GI_DISABLED_TEXT_COLOR [UIColor colorWithWhite:0.4f alpha:0.4f]
#define GI_DISABLED_BACKGROUND_COLOR [UIColor colorWithWhite:0.3f alpha:0.2f]

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
        _placeCorrectLetterButton = [GIIconButton buttonWithIcon:FAIconMagic];

        _placeCorrectLetterButton.backgroundColor = GI_CORRECT_LETTER_BACKGROUND_COLOR;
        _placeCorrectLetterButton.layer.borderWidth = GI_SOCIAL_BUTTON_BORDER_WIDTH;
        _placeCorrectLetterButton.layer.borderColor = GI_SOCIAL_BUTTON_BORDER_COLOR;

        CGFloat x = GI_HELP_VIEW_PADDING;
        CGFloat y = GI_HELP_VIEW_PADDING;
        CGFloat width = self.width - (2 * GI_HELP_VIEW_PADDING);
        CGFloat height = GI_HELP_BUTTON_HEIGHT;

        _placeCorrectLetterButton.frame = CGRectMake(x, y, width, height);
        _placeCorrectLetterButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        [_placeCorrectLetterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_placeCorrectLetterButton setTitleColor:GI_DISABLED_TEXT_COLOR forState:UIControlStateDisabled];

        [_placeCorrectLetterButton setTitle:@"Place correct letter" forState:UIControlStateNormal];
        [_placeCorrectLetterButton addTarget:self
                                     action:@selector(_placeCorrectLetterTouched:)
                           forControlEvents:UIControlEventTouchUpInside];
    }
    return _placeCorrectLetterButton;
}

- (UIButton *)eliminateWrongLetterButton {
    if (!_eliminateWrongLetterButton) {
        _eliminateWrongLetterButton = [GIIconButton buttonWithIcon:FAIconTrash];

        _eliminateWrongLetterButton.backgroundColor = GI_WRONG_LETTER_BACKGROUND_COLOR;
        _eliminateWrongLetterButton.layer.borderWidth = GI_SOCIAL_BUTTON_BORDER_WIDTH;
        _eliminateWrongLetterButton.layer.borderColor = GI_SOCIAL_BUTTON_BORDER_COLOR;

        CGFloat x = GI_HELP_VIEW_PADDING;
        CGFloat y = (2 * GI_HELP_VIEW_PADDING) + GI_HELP_BUTTON_HEIGHT;
        CGFloat width = self.width - (2 * GI_HELP_VIEW_PADDING);
        CGFloat height = GI_HELP_BUTTON_HEIGHT;

        _eliminateWrongLetterButton.frame = CGRectMake(x, y, width, height);
        _eliminateWrongLetterButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        [_eliminateWrongLetterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_eliminateWrongLetterButton setTitleColor:GI_DISABLED_TEXT_COLOR forState:UIControlStateDisabled];

        [_eliminateWrongLetterButton setTitle:@"Eliminate wrong letter" forState:UIControlStateNormal];
        [_eliminateWrongLetterButton addTarget:self
                                        action:@selector(_eliminateWrongLetterTouched:)
                              forControlEvents:UIControlEventTouchUpInside];
    }
    return _eliminateWrongLetterButton;
}

- (UIButton *)skipLevelButton {
    if (!_skipLevelButton) {
        _skipLevelButton = [GIIconButton buttonWithIcon:FAIconRandom];

        _skipLevelButton.backgroundColor = GI_SKIP_LEVEL_BACKGROUND_COLOR;
        _skipLevelButton.layer.borderWidth = GI_SOCIAL_BUTTON_BORDER_WIDTH;
        _skipLevelButton.layer.borderColor = GI_SOCIAL_BUTTON_BORDER_COLOR;

        CGFloat x = GI_HELP_VIEW_PADDING;
        CGFloat y = (3 * GI_HELP_VIEW_PADDING) + (2 * GI_HELP_BUTTON_HEIGHT);
        CGFloat width = self.width - (2 * GI_HELP_VIEW_PADDING);
        CGFloat height = GI_HELP_BUTTON_HEIGHT;

        _skipLevelButton.frame = CGRectMake(x, y, width, height);
        _skipLevelButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        [_skipLevelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_skipLevelButton setTitleColor:GI_DISABLED_TEXT_COLOR forState:UIControlStateDisabled];

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

#pragma mark - Public Interface

- (void)adjustEnabledButtons {
    BOOL eliminateWrongLetters = [self.delegate helpViewCanEliminateWrongLetter:self];
    self.eliminateWrongLetterButton.enabled = eliminateWrongLetters;
    self.eliminateWrongLetterButton.backgroundColor = eliminateWrongLetters ?
            GI_WRONG_LETTER_BACKGROUND_COLOR : GI_DISABLED_BACKGROUND_COLOR;

    BOOL placeCorrectLetters = [self.delegate helpViewCanPlaceCorrectLetter:self];
    self.placeCorrectLetterButton.enabled = placeCorrectLetters;
    self.placeCorrectLetterButton.backgroundColor = placeCorrectLetters ?
            GI_CORRECT_LETTER_BACKGROUND_COLOR : GI_DISABLED_BACKGROUND_COLOR;

    BOOL skipLevel = [self.delegate helpViewCanSkipLevel:self];
    self.skipLevelButton.enabled = skipLevel;
    self.skipLevelButton.backgroundColor = skipLevel ?
            GI_SKIP_LEVEL_BACKGROUND_COLOR : GI_DISABLED_BACKGROUND_COLOR;
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
        [GIConfiguration sharedInstance].numberOfHelpRequested += 1;
        [self.delegate helpViewDidRequestToPlaceCorrectLetter:self];
    }
}

- (void)_eliminateWrongLetterTouched:(id)sender {
    if ([self.delegate helpViewCanEliminateWrongLetter:self]) {
        [GIConfiguration sharedInstance].numberOfHelpRequested += 1;
        [self.delegate helpViewDidRequestToEliminateWrongLetter:self];
    }
}

- (void)_skipLevelTouched:(id)sender {
    if ([self.delegate helpViewCanSkipLevel:self]) {
        [GIConfiguration sharedInstance].numberOfHelpRequested += 1;
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
