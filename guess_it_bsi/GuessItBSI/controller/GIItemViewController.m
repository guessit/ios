//
//  GIItemViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 30/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIItemViewController.h"

#import "GIItem.h"
#import "GIItemView.h"

@interface GIItemViewController() <UIAlertViewDelegate>

@property (nonatomic, strong) GIItem *item;
@property (nonatomic, strong, readonly) GIItemView *itemView;
@property (nonatomic, strong) UIBarButtonItem *reloadBarButtonItem;

- (void)_loadRandomItem;
- (void)_reloadTouched:(id)sender;

- (void)_playerGuessedCorrectAnswer:(NSNotification *)notification;

@end

@implementation GIItemViewController

#pragma mark - Setter

- (void)setItem:(GIItem *)item {
    _item = item;

    self.itemView.item = item;
}

#pragma mark - Getter

- (GIItemView *)itemView {
    return (GIItemView *)self.view;
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

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_playerGuessedCorrectAnswer:)
                                                 name:GIPlayerGuessedCorrectAnswer
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self _loadRandomItem];
}

#pragma mark - Private Interface

- (void)_loadRandomItem {
    self.item = self.level.todoItems.randomObject;

    UIBarButtonItem *rightBarButtonItem = nil;
    if (self.level.todoItems.count > 0) {
        rightBarButtonItem = self.reloadBarButtonItem;
    }

    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)_reloadTouched:(id)sender {
    [self _loadRandomItem];
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
    [self.item guessWithAnwser:self.item.answer];

    [self _loadRandomItem];
}

@end
