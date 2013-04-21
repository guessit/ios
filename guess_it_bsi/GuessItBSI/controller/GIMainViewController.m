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

@implementation GIMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.font = [UIFont guessItTitleFont];
    self.titleLabel.shineColor = [UIColor colorWithRed:0.980 green:0.984 blue:0.843 alpha:1.000];

    self.view.backgroundColor = GI_BACKGROUND_MAIN_COLOR;
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

@end
