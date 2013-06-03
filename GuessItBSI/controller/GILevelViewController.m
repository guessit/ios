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
@property (nonatomic, strong) UIBarButtonItem *reloadBarButtonItem;

- (void)_loadRandomLevel;
- (void)_reloadTouched:(id)sender;

@end

@implementation GILevelViewController

#pragma mark - Setter

- (void)setLevel:(GILevel *)level {
    _level = level;

    self.levelView.level = level;
}

#pragma mark - Getter

- (GILevelView *)levelView {
    if (!_levelView) {
        _levelView = [GILevelView view];
        _levelView.levelDelegate = self;
    }
    return _levelView;
}

- (UIBarButtonItem *)reloadBarButtonItem {
    if (!_reloadBarButtonItem) {
        UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [reloadButton addTarget:self
                         action:@selector(_reloadTouched:)
               forControlEvents:UIControlEventTouchUpInside];
        [reloadButton setImage:[UIImage imageNamed:@"ico_reload"]
                      forState:UIControlStateNormal];
        reloadButton.frame = CGRectMake(0.f, 0.f, 70.f, 70.f);
        reloadButton.imageEdgeInsets = UIEdgeInsetsMake(3.f, 40.f, 0.f, 0.f);

        _reloadBarButtonItem = [UIBarButtonItem barButtonItemWithCustomView:reloadButton];
    }
    return _reloadBarButtonItem;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view = self.levelView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self _loadRandomLevel];
}

#pragma mark - Private Interface

- (void)_loadRandomLevel {
    NSArray *todoLevels = [GIConfiguration sharedInstance].game.todoLevels;

    self.level = todoLevels.randomObject;

    UIBarButtonItem *rightBarButtonItem = nil;
    if (todoLevels.count > 0) {
        rightBarButtonItem = self.reloadBarButtonItem;
    }

    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)_reloadTouched:(id)sender {
    [self _loadRandomLevel];
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
    #warning TODO: AJUSTAR! UGLYNESS!@!!!!!!!!
    [self.level guessWithAnwser:self.level.answer];

    [self _loadRandomLevel];
}

@end
