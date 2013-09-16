//
//  GIGameOverOtherGamesView.m
//  GuessIt
//
//  Created by Marlon Andrade on 16/09/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIGameOverOtherGamesView.h"

#import "GIConfiguration.h"
#import "GIDefinitions.h"
#import "MALazykit.h"
#import "UIFont+GuessItFonts.h"

@interface GIGameOverOtherGamesView ()

@property (nonatomic, strong) GIUserInterfaceElement *ui;

@property (nonatomic, strong) UILabel *knowOtherGames;
@property (nonatomic, strong) UILabel *visitOurWebsite;
@property (nonatomic, strong) UILabel *website;

@property (nonatomic, strong) UITapGestureRecognizer *gestureRecognizer;

- (void)_initialize;
- (void)_tapRecognized:(UIGestureRecognizer *)gestureRecognizer;

@end

@implementation GIGameOverOtherGamesView

#pragma mark - Getter

- (GIUserInterfaceElement *)ui {
    return [GIConfiguration sharedInstance].game.interface.congratulations;
}

- (UILabel *)knowOtherGames {
    if (!_knowOtherGames) {
        _knowOtherGames = [UILabel label];
        _knowOtherGames.text = NSLocalizedStringFromTable(@"other_games", @"game_over", nil);
        _knowOtherGames.backgroundColor = [UIColor clearColor];
        _knowOtherGames.font = [UIFont guessItCongratulationDescriptionFont];
        _knowOtherGames.textColor = self.ui.secondaryTextColor;
        _knowOtherGames.shadowColor = self.ui.secondaryShadowColor;
        _knowOtherGames.shadowOffset = CGSizeMake(0.f, -1.f);
        _knowOtherGames.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-5.f));
        [_knowOtherGames sizeToFit];
    }
    return _knowOtherGames;
}

- (UILabel *)visitOurWebsite {
    if (!_visitOurWebsite) {
        _visitOurWebsite = [UILabel label];
        _visitOurWebsite.text = NSLocalizedStringFromTable(@"visit_website", @"game_over", nil);
        _visitOurWebsite.backgroundColor = [UIColor clearColor];
        _visitOurWebsite.textColor = self.ui.secondaryTextColor;
        _visitOurWebsite.shadowColor = self.ui.secondaryShadowColor;
        _visitOurWebsite.shadowOffset = CGSizeMake(0.f, -1.f);
        [_visitOurWebsite sizeToFit];
    }
    return _visitOurWebsite;
}

- (UILabel *)website {
    if (!_website) {
        _website = [UILabel label];
        _website.text = @"http://guessit.mobi";
        _website.backgroundColor = [UIColor clearColor];
        _website.textColor = self.ui.secondaryTextColor;
        _website.shadowColor = self.ui.secondaryShadowColor;
        _website.shadowOffset = CGSizeMake(0.f, -1.f);
        [_website sizeToFit];
    }
    return _website;
}

- (UITapGestureRecognizer *)gestureRecognizer {
    if (!_gestureRecognizer) {
        _gestureRecognizer = [UITapGestureRecognizer gestureRecognizerWithTarget:self
                                                                          action:@selector(_tapRecognized:)];
    }
    return _gestureRecognizer;
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

    CGFloat x = self.bounds.origin.x + (self.bounds.size.width / 2.f);
    CGFloat y = self.bounds.origin.y + (self.bounds.size.height / 2.f);

    self.knowOtherGames.center = CGPointMake(x, y - 100.f);
    self.visitOurWebsite.center = CGPointMake(x, y - 40.f);
    self.website.center = CGPointMake(x, y + 50.f);

    [self addGestureRecognizer:self.gestureRecognizer];
}

#pragma mark - Private Interface

- (void)_initialize {
    [self addSubview:self.knowOtherGames];
    [self addSubview:self.visitOurWebsite];
    [self addSubview:self.website];
}

- (void)_tapRecognized:(UIGestureRecognizer *)recognizer {
    NSURL *guessItURL = [NSURL URLWithString:@"http://guessit.mobi"];
    [[UIApplication sharedApplication] openURL:guessItURL];
}

@end
