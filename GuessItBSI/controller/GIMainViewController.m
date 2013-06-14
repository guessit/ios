//
//  GIMainViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 25/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIMainViewController.h"

#import "GIConfiguration.h"
#import "GILevelViewController.h"
#import "UIFont+GuessItFonts.h"

@interface GIMainViewController ()

@property (nonatomic, strong) GIShineLabel *titleLabel;
@property (nonatomic, strong) UILabel *tapToPlayLabel;

- (void)_applicationDidBecomeActive:(NSNotification *)notification;
- (void)_tapRecognized:(UITapGestureRecognizer *)gesture;

@end

@implementation GIMainViewController

#pragma mark - Getter

- (GIShineLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [GIShineLabel labelWithFrame:CGRectMake(20.f, 138.f, 280.f, 100.f)];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont guessItTitleFont];
        _titleLabel.text = @"Guess It!";
        _titleLabel.textColor = [GIConfiguration sharedInstance].game.interface.titleColor;
        _titleLabel.shineColor = [GIConfiguration sharedInstance].game.interface.titleShineColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.shadowColor = [GIConfiguration sharedInstance].game.interface.titleShadowColor;
        _titleLabel.shadowOffset = CGSizeMake(0.f, -1.f);
    }
    return _titleLabel;
}

- (UILabel *)tapToPlayLabel {
    if (!_tapToPlayLabel) {
        _tapToPlayLabel = [UILabel labelWithFrame:CGRectMake(108.f, 219.f, 105.f, 26.f)];
        _tapToPlayLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _tapToPlayLabel.backgroundColor = [UIColor clearColor];
        _tapToPlayLabel.text = @"Tap to PLAY";
        _tapToPlayLabel.textColor = [GIConfiguration sharedInstance].game.interface.subtitleColor;
        _tapToPlayLabel.font = [UIFont guessItTapToPlayFont];
        _tapToPlayLabel.textAlignment = NSTextAlignmentCenter;
        _tapToPlayLabel.shadowColor = [GIConfiguration sharedInstance].game.interface.subtitleShadowColor;
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

    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.tapToPlayLabel];

    self.view.backgroundColor = [GIConfiguration sharedInstance].game.interface.backgroundColor;

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

    [self.titleLabel flash];
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
    [self.titleLabel flash];
}

- (void)_tapRecognized:(UITapGestureRecognizer *)gesture {
    GILevelViewController *level = [GILevelViewController viewController];
    [self.navigationController pushViewController:level animated:YES];
}

@end
