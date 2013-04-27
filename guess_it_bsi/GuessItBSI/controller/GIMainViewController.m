//
//  GIMainViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 25/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIMainViewController.h"
#import "GIUserInterfaceCustomizations.h"
#import "UIFont+GuessItFonts.h"

@interface GIMainViewController ()

- (void)_applicationDidBecomeActive:(NSNotification *)notification;

@end

@implementation GIMainViewController

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.font = [UIFont guessItTitleFont];
    self.titleLabel.shineColor = GI_TITLE_SHINE_COLOR;

    self.view.backgroundColor = GI_BACKGROUND_MAIN_COLOR;

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

@end
