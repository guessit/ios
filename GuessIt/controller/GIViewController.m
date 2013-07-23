//
//  GIViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 30/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIViewController.h"

#import "GIConfiguration.h"
#import "GIUserInterface.h"
#import "MALazykit.h"
#import "UIFont+GuessItFonts.h"

@interface GIViewController()

- (void)_backButtonTouched:(id)sender;

@end

@implementation GIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self respondsToSelector:@selector(setExtendedLayoutIncludesOpaqueBars:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    GIUserInterface *ui = [GIConfiguration sharedInstance].game.interface;

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"<" forState:UIControlStateNormal];
    [backButton setTitleColor:ui.navigation.color forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont guessItBackButtonFont];
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0.f, 0.f, 0.f, 30.f);

    backButton.frame = CGRectMake(0.f, 0.f, 70.f, 40.f);
    [backButton addTarget:self
                   action:@selector(_backButtonTouched:)
         forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithCustomView:backButton];
}

#pragma mark - Private Interface

- (void)_backButtonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
