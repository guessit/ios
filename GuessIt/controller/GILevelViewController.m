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
#import "GICongratulationsView.h"
#import "GIGame.h"
#import "GIHelpView.h"
#import "GILevel.h"
#import "GILevelView.h"
#import "GILevelViewDelegate.h"
#import "GIModalPanel.h"
#import "GINavigationBar.h"
#import "MALazykit.h"
#import "UIFont+GuessItFonts.h"
#import "UIViewController+KNSemiModal.h"

@interface GILevelViewController() <GIHelpViewDelegate, GILevelViewDelegate, UAModalPanelDelegate>

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
        _helpView.delegate = self;
        _helpView.backgroundColor = [UIColor yellowColor];
    }
    return _helpView;
}

- (UIBarButtonItem *)rightButtonItem {
    if (!_rightButtonItem) {
        GIUserInterface *ui = [GIConfiguration sharedInstance].game.interface;

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(_rightButtonTouched:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"?" forState:UIControlStateNormal];
        [button setTitleColor:ui.navigationButtonColor forState:UIControlStateNormal];

        button.titleLabel.font = [UIFont guessItBarButtonFont];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.frame = CGRectMake(0.f, 0.f, 70.f, 70.f);
        button.titleEdgeInsets = UIEdgeInsetsMake(0.f, 30.f, 0.f, 0.f);

        _rightButtonItem = [UIBarButtonItem barButtonItemWithCustomView:button];
    }
    return _rightButtonItem;
}

#pragma mark - UIViewController Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self _adjustViewForCurrentLevel];
}

- (void)viewDidLoad {
    [super viewDidLoad];

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

#pragma mark - GIHelpViewDelegate Methods

- (BOOL)helpViewCanEliminateWrongLetter:(GIHelpView *)helpView {
    #warning TODO: verify if exists wrong letters on keypad
    return YES;
}

- (BOOL)helpViewCanFillCorrectLetter:(GIHelpView *)helpView {
    #warning TODO: verify if it is not used more that 3? times
    return YES;
}

- (void)helpViewDidRequestToEliminateWrongLetter:(GIHelpView *)helpView {
    #warning TODO: remove wrong letter form keypad
}

- (void)helpViewDidRequestToFillCorrectLetter:(GIHelpView *)helpView {
    #warning TODO: get a correct letter from keypad and put it on answer
}

- (void)helpViewDidRequestToSkipLevel:(GIHelpView *)helpView {
    #warning TODO: skip level - mark level as skipped
}

#pragma mark - GILevelViewDelegate Methods

- (void)levelView:(GILevelView *)levelView didFinishGuessingLevel:(GILevel *)level withResult:(GIGuessingResult)guessingResult {
    if (guessingResult == GIGuessingResultCorrect) {
        UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;

        GIModalPanel *modalPanel = [GIModalPanel viewWithFrame:mainWindow.bounds];
        modalPanel.delegate = self;

        GICongratulationsView *congratsView = [GICongratulationsView view];
        congratsView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        congratsView.level = level;

        [modalPanel.contentView addSubview:congratsView];

        [mainWindow addSubview:modalPanel];
        [modalPanel showFromPoint:mainWindow.center];
    } else {
        [self performSelector:@selector(fail) withObject:nil afterDelay:0.25f];
    }
}

- (void)fail {
    [[GIConfiguration sharedInstance].game.sound playFailSound];
}

- (void)didRequestHelpFromLevelView:(GILevelView *)levelView {
    [self.levelView resignFirstResponder];

    [self presentSemiView:self.helpView
              withOptions:@{
        KNSemiModalOptionKeys.pushParentBack : @(NO),
        KNSemiModalOptionKeys.animationDuration : @(0.25f)
    }];
}

#pragma mark - UAModalPanelDelegate Methods

- (void)didShowModalPanel:(UAModalPanel *)modalPanel {
    [[GIConfiguration sharedInstance].game.sound playLevelFinishedSound];
}

- (void)didCloseModalPanel:(UAModalPanel *)modalPanel {
    [[GIConfiguration sharedInstance] loadNextLevel];
    [self _adjustViewForCurrentLevel];
}

@end
