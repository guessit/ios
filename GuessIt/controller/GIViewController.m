//
//  GIViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 30/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIViewController.h"

#import "MALazykit.h"

@interface GIViewController()

- (void)_backButtonTouched:(id)sender;

@end

@implementation GIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"ico_back"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(3.f, 0.f, 0.f, 40.f);

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
