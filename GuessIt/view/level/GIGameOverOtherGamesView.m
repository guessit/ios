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

@property (nonatomic, strong) UILabel *likedGuessIt;
@property (nonatomic, strong) UILabel *knowOtherGames;
@property (nonatomic, strong) UILabel *visitOurWebsite;
@property (nonatomic, strong) UILabel *website;

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *guessItImageView;

@property (nonatomic, strong) UITapGestureRecognizer *gestureRecognizer;

- (void)_initialize;
- (void)_tapRecognized:(UIGestureRecognizer *)gestureRecognizer;

@end

@implementation GIGameOverOtherGamesView

#pragma mark - Getter

- (GIUserInterfaceElement *)ui {
    return [GIConfiguration sharedInstance].game.interface.otherGames;
}

- (UILabel *)likedGuessIt {
    if (!_likedGuessIt) {
        _likedGuessIt = [UILabel label];
        _likedGuessIt.text = NSLocalizedStringFromTable(@"liked_guessit", @"game_over", nil);
        _likedGuessIt.backgroundColor = [UIColor clearColor];
        _likedGuessIt.font = [UIFont guessItKnowOtherGamesLikedItFont];
        _likedGuessIt.textColor = self.ui.secondaryTextColor;
        _likedGuessIt.shadowColor = self.ui.secondaryShadowColor;
        _likedGuessIt.shadowOffset = CGSizeMake(0.f, -1.f);
        _likedGuessIt.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-4.f));
        [_likedGuessIt sizeToFit];
    }
    return _likedGuessIt;
}

- (UILabel *)knowOtherGames {
    if (!_knowOtherGames) {
        _knowOtherGames = [UILabel label];
        _knowOtherGames.text = NSLocalizedStringFromTable(@"other_games", @"game_over", nil);
        _knowOtherGames.backgroundColor = [UIColor clearColor];
        _knowOtherGames.font = [UIFont guessItKnowOtherGamesTitleFont];
        _knowOtherGames.textColor = self.ui.textColor;
        _knowOtherGames.shadowColor = self.ui.shadowColor;
        _knowOtherGames.shadowOffset = CGSizeMake(0.f, -1.f);
        _knowOtherGames.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-4.f));
        [_knowOtherGames sizeToFit];
    }
    return _knowOtherGames;
}

- (UILabel *)visitOurWebsite {
    if (!_visitOurWebsite) {
        _visitOurWebsite = [UILabel label];
        _visitOurWebsite.text = NSLocalizedStringFromTable(@"visit_website", @"game_over", nil);
        _visitOurWebsite.backgroundColor = [UIColor clearColor];
        _visitOurWebsite.font = [UIFont guessItKnowOtherGamesDescription];
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
        _website.font = [UIFont guessItKnowOtherGamesWebsiteFont];
        _website.textColor = self.ui.textColor;
        _website.shadowColor = self.ui.shadowColor;
        _website.shadowOffset = CGSizeMake(0.f, -1.f);
        [_website sizeToFit];
    }
    return _website;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView imageViewWithImageNamed:@"background_soon"];
        _backgroundImageView.contentMode = UIViewContentModeCenter;
    }
    return _backgroundImageView;
}

- (UIImageView *)guessItImageView {
    if (!_guessItImageView) {
        _guessItImageView = [UIImageView imageViewWithImageNamed:@"guessit_soon"];
        _guessItImageView.contentMode = UIViewContentModeCenter;
        _guessItImageView.alpha = 0.25f;
    }
    return _guessItImageView;
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

    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.backgroundImageView.center = center;
    self.guessItImageView.center = center;

    CGFloat x = self.bounds.origin.x + (self.bounds.size.width / 2.f);
    CGFloat y = self.bounds.origin.y + (self.bounds.size.height / 2.f);

    self.likedGuessIt.center = CGPointMake(x, y - 40.f);
    self.knowOtherGames.center = CGPointMake(x, y + 30.f);
    self.visitOurWebsite.center = CGPointMake(x, y + 155.f);
    self.website.center = CGPointMake(x, y + 175.f);

    [self addGestureRecognizer:self.gestureRecognizer];
}

#pragma mark - Private Interface

- (void)_initialize {
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.guessItImageView];

    [self addSubview:self.likedGuessIt];
    [self addSubview:self.knowOtherGames];
    [self addSubview:self.visitOurWebsite];
    [self addSubview:self.website];
}

- (void)_tapRecognized:(UIGestureRecognizer *)recognizer {
    NSURL *guessItURL = [NSURL URLWithString:@"http://guessit.mobi"];
    [[UIApplication sharedApplication] openURL:guessItURL];
}

@end
