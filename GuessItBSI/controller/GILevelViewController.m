//
//  GILevelViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 30/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevelViewController.h"

#import "GIConfiguration.h"
#import "GIGame.h"
#import "GILevel.h"
#import "GILevelView.h"
#import "GILevelViewDelegate.h"

@interface GILevelViewController() <GILevelViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) GILevelView *levelView;

- (void)_adjustForCurrentLevel;
- (void)_reloadTouched:(id)sender;
- (void)_currentLevelDidChange:(NSNotification *)notification;

@end

@implementation GILevelViewController

#pragma mark - Getter

- (GILevelView *)levelView {
    if (!_levelView) {
        _levelView = [GILevelView view];
        _levelView.levelDelegate = self;
    }
    return _levelView;
}

//- (UIBarButtonItem *)reloadBarButtonItem {
//    if (!_reloadBarButtonItem) {
//        UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [reloadButton addTarget:self
//                         action:@selector(_reloadTouched:)
//               forControlEvents:UIControlEventTouchUpInside];
//        [reloadButton setImage:[UIImage imageNamed:@"ico_reload"]
//                      forState:UIControlStateNormal];
//        reloadButton.frame = CGRectMake(0.f, 0.f, 70.f, 70.f);
//        reloadButton.imageEdgeInsets = UIEdgeInsetsMake(3.f, 40.f, 0.f, 0.f);
//
//        _reloadBarButtonItem = [UIBarButtonItem barButtonItemWithCustomView:reloadButton];
//    }
//    return _reloadBarButtonItem;
//}

#pragma mark - UIViewController Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _adjustForCurrentLevel];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view = self.levelView;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_currentLevelDidChange:)
                                                 name:GICurrentLevelDidChangeNotification
                                               object:nil];
}

#pragma mark - NSObject Methods

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private Interface

- (void)_adjustForCurrentLevel {
    self.levelView.currentLevel = [GIConfiguration sharedInstance].currentLevel;
}

- (void)_reloadTouched:(id)sender {
    [[GIConfiguration sharedInstance] loadNewRandomLevel];
}

- (void)_currentLevelDidChange:(NSNotification *)notification {
    [self _adjustForCurrentLevel];
}

#pragma mark - GILevelViewDelegate Methods

- (void)levelView:(GILevelView *)levelView didFinishGuessingLevel:(GILevel *)level withResult:(GIGuessingResult)guessingResult {
    if (guessingResult == GIGuessingResultCorrect) {
        [[[UIAlertView alloc] initWithTitle:@"YAY"
                                    message:@"YAYYYYYYYY"
                                   delegate:self
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
    } else {

    }
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [[GIConfiguration sharedInstance] loadNewRandomLevel];
}

@end
