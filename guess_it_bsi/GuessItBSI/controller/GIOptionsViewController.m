//
//  GIOptionsViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/24/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIOptionsViewController.h"

@interface GIOptionsViewController ()

- (void)_resetGameProgress;

- (IBAction)_resetTouched:(id)sender;

@end

@implementation GIOptionsViewController

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Private Interface

- (void)_resetGameProgress {
    [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:GI_FINISHED_ITEMS];
}

#pragma mark - IBActions

- (IBAction)_resetTouched:(id)sender {
    [self _resetGameProgress];
}

@end
