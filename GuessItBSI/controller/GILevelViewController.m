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
#import "GIHelpView.h"
#import "GILevel.h"
#import "GILevelView.h"
#import "GILevelViewDelegate.h"
#import "GINavigationBar.h"
#import "UIViewController+KNSemiModal.h"

@interface GILevelViewController() <GILevelViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) GILevelView *levelView;
@property (nonatomic, strong) GIHelpView *helpView;
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;

- (void)_adjustViewForCurrentLevel;
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

- (GIHelpView *)helpView {
    if (!_helpView) {
        _helpView = [GIHelpView viewWithFrame:CGRectMake(0.f, 0.f, 320.f, 200.f)];
        _helpView.backgroundColor = [UIColor yellowColor];
    }
    return _helpView;
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
    NSLog(@"%@", NSStringFromSelector(_cmd));

    [self _adjustViewForCurrentLevel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", NSStringFromSelector(_cmd));

    self.view = self.levelView;
    self.navigationItem.rightBarButtonItem = self.rightButtonItem;
}

#pragma mark - Private Interface

- (void)_adjustViewForCurrentLevel {
    self.levelView.currentLevel = [GIConfiguration sharedInstance].currentLevel;
}

- (void)_rightButtonTouched:(id)sender {
    GIBuyViewController *buyViewController = [GIBuyViewController viewController];
    UINavigationController *navController = [UINavigationController navigationControllerWithNavigationBarClass:[GINavigationBar class]
                                                                                                  toolbarClass:nil];
    navController.viewControllers = @[buyViewController];
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

- (void)didRequestHelpFromLevelView:(GILevelView *)levelView {
    [self.levelView resignFirstResponder];
    [self presentSemiView:self.helpView];
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    [[GIConfiguration sharedInstance] loadNewRandomLevel];
    [self _adjustViewForCurrentLevel];
}

@end
