//
//  GIBuyViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 06/05/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIBuyViewController.h"

@interface GIBuyViewController ()

- (void)_cancelTouched:(id)sender;

@end

@implementation GIBuyViewController

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor magentaColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonWithSystemItem:UIBarButtonSystemItemCancel
                                                                           target:self
                                                                           action:@selector(_cancelTouched:)];
}

#pragma mark - Private Interface

- (void)_cancelTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
