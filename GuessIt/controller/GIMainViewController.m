//
//  GIMainViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 25/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIMainViewController.h"

#import "GIConfiguration.h"
#import "GIDefinitions.h"
#import "GIGame+PrettyDescription.h"
#import "GILevelViewController.h"
#import "MALazykit.h"
#import "NSObject+Analytics.h"
#import "UIFont+GuessItFonts.h"
#import "UIView+CBFrameHelpers.h"

@interface GIMainViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *secondaryBackgroundImageView;
@property (nonatomic, strong) UIImageView *externalLogoImageView;
@property (nonatomic, strong) GIShineLabel *titleLabel;
@property (nonatomic, strong) UILabel *tapToPlayLabel;

- (void)_applicationDidBecomeActive:(NSNotification *)notification;

- (void)_tapRecognized:(UITapGestureRecognizer *)gesture;
- (void)_externalLogoTapRecognized:(UITapGestureRecognizer *)gesture;

@end

@implementation GIMainViewController

#pragma mark - Getter

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView imageViewWithImageNamed:@"main_background"];
        _backgroundImageView.contentMode = UIViewContentModeCenter;
    }
    return _backgroundImageView;
}

- (UIImageView *)secondaryBackgroundImageView {
    if (!_secondaryBackgroundImageView) {
        _secondaryBackgroundImageView = [UIImageView imageViewWithImageNamed:@"secondary_background"];
        _secondaryBackgroundImageView.contentMode = UIViewContentModeCenter;
    }
    return _secondaryBackgroundImageView;
}

- (UIImageView *)externalLogoImageView {
    if (!_externalLogoImageView) {
        _externalLogoImageView = [UIImageView imageViewWithImageNamed:@"external_logo"];
        _externalLogoImageView.contentMode = UIViewContentModeCenter;
        _externalLogoImageView.userInteractionEnabled = YES;

        UIGestureRecognizer *tapGesture = [UITapGestureRecognizer gestureRecognizerWithTarget:self
                                                                                       action:@selector(_externalLogoTapRecognized:)];
        [_externalLogoImageView addGestureRecognizer:tapGesture];
    }
    return _externalLogoImageView;
}

- (GIShineLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [GIShineLabel label];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont guessItTitleFont];
        _titleLabel.text = @"Guess It!";
        [_titleLabel sizeToFit];
        _titleLabel.w = _titleLabel.width + 10.f;

        GIUserInterface *ui = [GIConfiguration sharedInstance].game.interface;

        _titleLabel.textColor = ui.title.textColor;
        _titleLabel.shineColor  = ui.title.secondaryColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.shadowColor = ui.title.shadowColor;
        _titleLabel.shadowOffset = CGSizeMake(0.f, -1.f);
    }
    return _titleLabel;
}

- (UILabel *)tapToPlayLabel {
    if (!_tapToPlayLabel) {
        _tapToPlayLabel = [UILabel label];
        _tapToPlayLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _tapToPlayLabel.backgroundColor = [UIColor clearColor];
        _tapToPlayLabel.font = [UIFont guessItTapToPlayFont];
        _tapToPlayLabel.text = NSLocalizedStringFromTable(@"tap_to_play", @"general", nil);
        [_tapToPlayLabel sizeToFit];

        GIUserInterface *ui = [GIConfiguration sharedInstance].game.interface;

        _tapToPlayLabel.textColor = ui.subtitle.textColor;
        _tapToPlayLabel.textAlignment = NSTextAlignmentCenter;
        _tapToPlayLabel.shadowColor = ui.subtitle.shadowColor;
        _tapToPlayLabel.shadowOffset = CGSizeMake(0.f, -1.f);
    }
    return _tapToPlayLabel;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    [[GIConfiguration sharedInstance] loadInAppPurchasesProducts];

    if (self.secondaryBackgroundImageView.image) {
        [self.view addSubview:self.secondaryBackgroundImageView];
    }

    [self.view addSubview:self.backgroundImageView];

    if (self.externalLogoImageView.image) {
        [self.view addSubview:self.externalLogoImageView];
        self.externalLogoImageView.y = self.view.height - self.externalLogoImageView.height;
    }

    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.tapToPlayLabel];

    self.secondaryBackgroundImageView.frame = self.view.bounds;
    self.backgroundImageView.frame = self.view.bounds;

    self.titleLabel.center = CGPointMake(self.view.center.x, self.view.center.y - 50.f);
    self.tapToPlayLabel.center = CGPointMake(self.view.center.x, self.titleLabel.center.y + 46.f);

    GIUserInterface *interface = [GIConfiguration sharedInstance].game.interface;
    self.view.backgroundColor = interface.main.backgroundColor;

    UITapGestureRecognizer *tapGesture = [UITapGestureRecognizer gestureRecognizerWithTarget:self
                                                                                      action:@selector(_tapRecognized:)];
    [self.view addGestureRecognizer:tapGesture];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:animated];

    [self.titleLabel shine];

    [self trackViewWithName:@"MainView"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];

    [super viewWillDisappear:animated];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private Interface

- (void)_applicationDidBecomeActive:(NSNotification *)notification {
    [self.titleLabel shine];
}

- (void)_tapRecognized:(UITapGestureRecognizer *)gesture {
    GILevelViewController *level = [GILevelViewController viewController];
    [self.navigationController pushViewController:level animated:YES];
}

- (void)_externalLogoTapRecognized:(UITapGestureRecognizer *)gesture {
    NSString *urlString = [GIConfiguration sharedInstance].game.options[@"external_url"];
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

@end
