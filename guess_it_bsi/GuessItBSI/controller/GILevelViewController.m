//
//  GILevelViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 30/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevelViewController.h"

#import "GIGame.h"
#import "GILevel.h"
#import "GILevelView.h"

@interface GILevelViewController() <UIAlertViewDelegate>

@property (nonatomic, strong, readonly) GILevelView *levelView;
@property (nonatomic, strong) UIBarButtonItem *reloadBarButtonItem;

- (void)_loadRandomLevel;
- (void)_reloadTouched:(id)sender;

- (void)_playerGuessedCorrectAnswer:(NSNotification *)notification;

@end

@implementation GILevelViewController

#pragma mark - Setter

- (void)setLevel:(GILevel *)level {
    _level = level;

    self.levelView.level = level;
}

#pragma mark - Getter

- (GILevelView *)levelView {
    return (GILevelView *)self.view;
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

    self.view = [GILevelView view];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_playerGuessedCorrectAnswer:)
                                                 name:GIPlayerGuessedCorrectAnswer
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self _loadRandomLevel];
}

#pragma mark - Private Interface

- (void)_loadRandomLevel {
    self.level = [GIGame game].todoLevels.randomObject;

    UIBarButtonItem *rightBarButtonItem = nil;
    if ([GIGame game].todoLevels.count > 0) {
        rightBarButtonItem = self.reloadBarButtonItem;
    }

    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)_reloadTouched:(id)sender {
    [self _loadRandomLevel];
}

- (void)_playerGuessedCorrectAnswer:(NSNotification *)notification {
    [[[UIAlertView alloc] initWithTitle:@"YAY"
                                message:@"YAYYYYYYYY"
                               delegate:self
                      cancelButtonTitle:@"Ok"
                      otherButtonTitles:nil] show];
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    #warning TODO: AJUSTAR! UGLYNESS!@!!!!!!!!
    [self.level guessWithAnwser:self.level.answer];

    [self _loadRandomLevel];
}

@end
