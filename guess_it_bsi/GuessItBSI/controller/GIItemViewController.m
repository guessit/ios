//
//  GIItemViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 30/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIItemViewController.h"

#import "GIItem.h"
#import "GIUserInterfaceCustomizations.h"
#import "GIItem+PrettyDescription.h"
#import "GILevel+PrettyDescription.h"
#import <QuartzCore/QuartzCore.h>

@interface GIItemViewController()

@property (nonatomic, strong) GIItem *item;
@property (nonatomic, strong) UIBarButtonItem *reloadBarButtonItem;

- (void)_loadRandomItem;
- (void)_reloadTouched:(id)sender;

@end

@implementation GIItemViewController

#pragma mark - Setter

- (void)setItem:(GIItem *)item {
    _item = item;

    if (item) {
        self.imageView.image = item.image;
        // exibir item
        // reload word view
        // reload letters
    } else {
        // show congrats view and say no more items on this level
    }
}

#pragma mark - Getter

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

    self.view.backgroundColor = GI_BACKGROUND_MAIN_COLOR;
    self.imageFrameView.layer.cornerRadius = 8.f;
    self.imageView.layer.cornerRadius = 8.f;
    self.imageView.layer.shadowRadius = 5.f;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self _loadRandomItem];

    NSLog(@"         Items: %@", self.level.prettyDescription);
}

#pragma mark - Private Interface

- (void)_loadRandomItem {
    self.item = self.level.todoItems.randomObject;

    NSLog(@"%@", self.item.prettyDescription);

    [self.item guessWithAnwser:self.item.answer];

    UIBarButtonItem *rightBarButtonItem = nil;
    if (self.level.todoItems.count > 0) {
        rightBarButtonItem = self.reloadBarButtonItem;
    }

    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)_reloadTouched:(id)sender {
    [self _loadRandomItem];
}

@end
