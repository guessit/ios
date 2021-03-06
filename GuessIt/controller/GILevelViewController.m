//
//  GILevelViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 30/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevelViewController.h"

#import "GIAdManager.h"
#import "GIBarButton.h"
#import "GIConfiguration.h"
#import "GICongratulationsView.h"
#import "GICongratulationsViewDelegate.h"
#import "GIDefinitions.h"
#import "GIGame.h"
#import "GIGameOverView.h"
#import "GIGameOverViewDelegate.h"
#import "GIHelpView.h"
#import "GILevel.h"
#import "GILevelView.h"
#import "GILevelViewDelegate.h"
#import "GIModalPanel.h"
#import "GINavigationBar.h"
#import "GISettingsViewController.h"
#import "MALazykit.h"
#import "NSObject+Analytics.h"
#import "UIFont+GuessItFonts.h"
#import "UIView+CBFrameHelpers.h"
#import "UIView+GuessIt.h"
#import "UIViewController+MASimplestSemiModal.h"
#import <Social/Social.h>

@interface GILevelViewController() <GISettingsDelegate, GIHelpViewDelegate, GICongratulationsViewDelegate, GILevelViewDelegate, GIGameOverViewDelegate, UAModalPanelDelegate>

@property (nonatomic, strong) GILevelView *levelView;
@property (nonatomic, strong) GIGameOverView *gameOverView;
@property (nonatomic, strong) GIHelpView *helpView;
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;
@property (nonatomic, assign) BOOL showAdOnNextLevel;

- (void)_adjustViewForCurrentLevel;
- (void)_showGameOverView;
- (void)_rightButtonTouched:(id)sender;
- (void)_shareWithServiceType:(NSString *)service
                      message:(NSString *)message
                        alert:(NSString *)alert;

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

- (GIGameOverView *)gameOverView {
    if (!_gameOverView) {
        _gameOverView = [GIGameOverView view];
        _gameOverView.gameOverDelegate = self;
    }
    return _gameOverView;
}

- (GIHelpView *)helpView {
    if (!_helpView) {
        _helpView = [GIHelpView viewWithFrame:CGRectMake(0.f, 0.f, self.view.width, GI_HELP_VIEW_HEIGHT)];
        _helpView.delegate = self;
    }
    return _helpView;
}

- (UIBarButtonItem *)rightButtonItem {
    if (!_rightButtonItem) {
        GIUserInterface *ui = [GIConfiguration sharedInstance].game.interface;

        GIBarButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(_rightButtonTouched:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"?" forState:UIControlStateNormal];
        [button setTitleColor:ui.navigation.color forState:UIControlStateNormal];

        button.titleLabel.font = [UIFont guessItBarButtonFont];
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        button.frame = CGRectMake(0.f, 0.f, 70.f, 70.f);

        CGFloat leftEdge = 40.f;
        if (floorf(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            leftEdge = 52.f;
        }
        button.titleEdgeInsets = UIEdgeInsetsMake(0.f, leftEdge, 0.f, 0.f);

        _rightButtonItem = [UIBarButtonItem barButtonItemWithCustomView:button];
    }
    return _rightButtonItem;
}

#pragma mark - UIViewController Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self _adjustViewForCurrentLevel];

    if ([GIConfiguration sharedInstance].showAds) {
        [[GIAdManager sharedInstance] loadAds];
    }

    [self trackViewWithName:@"LevelView"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([GIConfiguration sharedInstance].currentLevel) {
        self.view = self.levelView;
    } else {
        self.view = self.gameOverView;
    }

    self.navigationItem.rightBarButtonItem = self.rightButtonItem;
}

#pragma mark - Private Interface

- (void)_adjustViewForCurrentLevel {
    self.levelView.currentLevel = [GIConfiguration sharedInstance].currentLevel;
    [self trackEventWithCategory:@"game"
                          action:@"level_loaded"
                           label:self.levelView.currentLevel.answer
                           value:nil];
}

- (void)_showGameOverView {
    CGAffineTransform shrinkTransform = CGAffineTransformMakeScale(0.001f, 0.001f);

    self.gameOverView.transform = shrinkTransform;
    [UIView animateWithDuration:0.2f animations:^{
        self.levelView.transform = shrinkTransform;
    } completion:^(BOOL finished) {
        self.view = self.gameOverView;
        [UIView animateWithDuration:0.2f animations:^{
            self.gameOverView.transform = CGAffineTransformIdentity;
        }];
    }];

    [self trackEventWithCategory:@"game"
                          action:@"game_over"
                           label:nil
                           value:nil];
}

- (void)_rightButtonTouched:(id)sender {
    GISettingsViewController *settings = [GISettingsViewController viewController];
    settings.settingsDelegate = self;
    UINavigationController *navController = [UINavigationController navigationControllerWithNavigationBarClass:[GINavigationBar class]
                                                                                                  toolbarClass:nil];
    navController.viewControllers = @[settings];
    [self presentViewController:navController animated:YES completion:NULL];
}

- (void)_shareWithServiceType:(NSString *)service
                      message:(NSString *)message
                        alert:(NSString *)alert {
    if ([SLComposeViewController isAvailableForServiceType:service]) {
        [self trackSocialInteractionWithNetwork:service
                                         action:@"share"
                                         target:nil];

        SLComposeViewController *share = [SLComposeViewController composeViewControllerForServiceType:service];
        [share setInitialText:message];
        [share addURL:[NSURL URLWithString:@"http://guessit.mobi"]];
        [share addImage:[[UIApplication sharedApplication].keyWindow gi_screenshot]];
        [self presentViewController:share animated:YES completion:NULL];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"GuessIt!"
                                    message:alert
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
    }
}

#pragma mark - GISettingsDelegate Methods

- (void)didCancelSettingsViewController:(GISettingsViewController *)settingsViewController {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didResetProgressWithSettingsViewController:(GISettingsViewController *)settingsViewController {
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - GIHelpViewDelegate Methods

- (BOOL)helpViewCanEliminateWrongLetter:(GIHelpView *)helpView {
    return self.levelView.hasWrongLetterToBeRemoved;
}

- (BOOL)helpViewCanPlaceCorrectLetter:(GIHelpView *)helpView {
    return self.levelView.hasCorrectLetterToBePlaced;
}

- (BOOL)helpViewCanSkipLevel:(GIHelpView *)helpView {
    return [GIConfiguration sharedInstance].game.todoLevels.count > 1;
}

- (void)helpViewDidRequestToEliminateWrongLetter:(GIHelpView *)helpView {
    [self.navigationController ma_dismissSemiView];
    [self.levelView performSelector:@selector(removeWrongLetter) withObject:nil afterDelay:0.3f];
}

- (void)helpViewDidRequestToPlaceCorrectLetter:(GIHelpView *)helpView {
    [self.navigationController ma_dismissSemiView];
    [self.levelView performSelector:@selector(placeCorrectLetter) withObject:nil afterDelay:0.3f];
}

- (void)helpViewDidRequestToSkipLevel:(GIHelpView *)helpView {
    [[GIConfiguration sharedInstance] loadNextLevel];
    [self _adjustViewForCurrentLevel];
    [self.navigationController ma_dismissSemiView];
}

- (void)helpViewDidRequestToPostOnFacebook:(GIHelpView *)helpView {
    [self.navigationController ma_dismissSemiView];

    [self _shareWithServiceType:SLServiceTypeFacebook
                        message:NSLocalizedStringFromTable(@"facebook_help", @"social", nil)
                          alert:NSLocalizedStringFromTable(@"facebook_unavailable", @"social", nil)];
}

- (void)helpViewDidRequestToPostOnTwitter:(GIHelpView *)helpView {
    [self.navigationController ma_dismissSemiView];

    [self _shareWithServiceType:SLServiceTypeTwitter
                        message:NSLocalizedStringFromTable(@"twitter_help", @"social", nil)
                          alert:NSLocalizedStringFromTable(@"twitter_unavailable", @"social", nil)];
}

#pragma mark - GICongratulationsViewDelegate Methods

- (void)congratulationsViewDidRequestToPostOnFacebook:(GICongratulationsView *)congratulationsView {
    [self _shareWithServiceType:SLServiceTypeFacebook
                        message:NSLocalizedStringFromTable(@"facebook_challenge", @"social", nil)
                          alert:NSLocalizedStringFromTable(@"facebook_unavailable", @"social", nil)];
}

- (void)congratulationsViewDidRequestToPostOnTwitter:(GICongratulationsView *)congratulationsView {
    [self _shareWithServiceType:SLServiceTypeTwitter
                        message:NSLocalizedStringFromTable(@"twitter_challenge", @"social", nil)
                          alert:NSLocalizedStringFromTable(@"twitter_unavailable", @"social", nil)];
}

#pragma mark - GIGameOverViewDelegate Methods

- (void)gameOverViewDidRequestToPostOnFacebook:(GIGameOverView *)gameOverView {
    [self _shareWithServiceType:SLServiceTypeFacebook
                        message:NSLocalizedStringFromTable(@"facebook_game_over", @"social", nil)
                          alert:NSLocalizedStringFromTable(@"facebook_unavailable", @"social", nil)];
}

- (void)gameOverViewDidRequestToPostOnTwitter:(GIGameOverView *)gameOverView {
    [self _shareWithServiceType:SLServiceTypeTwitter
                        message:NSLocalizedStringFromTable(@"twitter_game_over", @"social", nil)
                          alert:NSLocalizedStringFromTable(@"twitter_unavailable", @"social", nil)];
}

#pragma mark - GILevelViewDelegate Methods

- (void)levelView:(GILevelView *)levelView didFinishGuessingLevel:(GILevel *)level withResult:(GIGuessingResult)guessingResult {
    if (guessingResult == GIGuessingResultCorrect) {
        GIGame *game = [GIConfiguration sharedInstance].game;
        [self trackEventWithCategory:@"game"
                              action:@"progress"
                               label:nil
                               value:@(game.progress)];
        [self trackEventWithCategory:@"game"
                              action:@"level_correct"
                               label:level.answer
                               value:nil];

        [[GIConfiguration sharedInstance] loadNextLevel];

        UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;

        GIModalPanel *modalPanel = [GIModalPanel viewWithFrame:mainWindow.bounds];
        modalPanel.delegate = self;

        GICongratulationsView *congratsView = [GICongratulationsView view];
        congratsView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        congratsView.level = level;
        congratsView.delegate = self;

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
    [self.helpView adjustEnabledButtons];
    [self.navigationController ma_presentSemiView:self.helpView];

    [self trackEventWithCategory:@"game"
                          action:@"help_requested"
                           label:nil
                           value:nil];
}

#pragma mark - UAModalPanelDelegate Methods

- (void)didShowModalPanel:(UAModalPanel *)modalPanel {
    [[GIConfiguration sharedInstance].game.sound playLevelFinishedSound];
}

- (void)didCloseModalPanel:(UAModalPanel *)modalPanel {
    GIConfiguration *conf = [GIConfiguration sharedInstance];

    NSInteger levelsToShowAd = conf.game.levels.count / 10.f;
    NSInteger levelsPlusHelps = conf.numberOfLevelsPresented + conf.numberOfHelpRequested;

    if (conf.showAds && levelsPlusHelps >= levelsToShowAd && conf.hasMoreLevels) {
        [[GIAdManager sharedInstance] presentAdFromViewController:self];
        [conf resetAfterShowingAd];

        [self trackEventWithCategory:@"game"
                              action:@"ad_shown"
                               label:nil
                               value:nil];
    }

    if (conf.currentLevel) {
        [self _adjustViewForCurrentLevel];
    } else {
        [self _showGameOverView];
    }
}

@end
