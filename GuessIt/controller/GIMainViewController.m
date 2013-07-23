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
#import "UIFont+GuessItFonts.h"
#import "UIView+CBFrameHelpers.h"

@interface GIMainViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) GIShineLabel *titleLabel;
@property (nonatomic, strong) UILabel *tapToPlayLabel;

- (void)_applicationDidBecomeActive:(NSNotification *)notification;
- (void)_tapRecognized:(UITapGestureRecognizer *)gesture;

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
        _tapToPlayLabel.text = @"Tap to PLAY";
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

- (void)_resetTouched:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:GI_FINISHED_LEVELS];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:GI_CURRENT_LEVEL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    #warning TODO: Remover
    NSLog(@"Game: %@", [[GIConfiguration sharedInstance].game prettyDescription]);

    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.tapToPlayLabel];

    self.backgroundImageView.frame = self.view.bounds;

    self.titleLabel.center = CGPointMake(self.view.center.x, self.view.center.y - 50.f);
    self.tapToPlayLabel.center = CGPointMake(self.view.center.x, self.titleLabel.center.y + 46.f);

    GIUserInterface *interface = [GIConfiguration sharedInstance].game.interface;
    self.view.backgroundColor = interface.main.backgroundColor;

    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [resetButton addTarget:self action:@selector(_resetTouched:) forControlEvents:UIControlEventTouchUpInside];
    [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    resetButton.frame = CGRectMake(self.view.center.x - 50.f, self.view.bounds.size.height - 60.f, 100.f, 40.f);

    [self.view addSubview:resetButton];

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

@end
