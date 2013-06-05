//
//  GILevelViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 30/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevelViewController.h"

#import "GIBuyViewController.h"
#import "GIConfiguration.h"
#import "GIGame.h"
#import "GILevel.h"
#import "GILevelView.h"
#import "GILevelViewDelegate.h"
#import "GINavigationController.h"

@interface GILevelViewController() <GILevelViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) GILevelView *levelView;
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;

- (void)_rightButtonTouched:(id)sender;

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

- (UIBarButtonItem *)rightButtonItem {
    if (!_rightButtonItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(_rightButtonTouched:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"ico_guess_it"]
                forState:UIControlStateNormal];
        button.frame = CGRectMake(0.f, 0.f, 70.f, 70.f);
        button.imageEdgeInsets = UIEdgeInsetsMake(3.f, 40.f, 0.f, 0.f);

        _rightButtonItem = [UIBarButtonItem barButtonItemWithCustomView:button];
    }
    return _rightButtonItem;
}

#pragma mark - UIViewController Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.levelView.currentLevel = [GIConfiguration sharedInstance].currentLevel;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view = self.levelView;
    self.navigationItem.rightBarButtonItem = self.rightButtonItem;
}
#pragma mark - Private Interface

- (void)_rightButtonTouched:(id)sender {
    GIBuyViewController *buyViewController = [GIBuyViewController viewController];
    GINavigationController *navController = [GINavigationController navigationControllerWithRootViewController:buyViewController];
    [self presentViewController:navController animated:YES completion:NULL];
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
