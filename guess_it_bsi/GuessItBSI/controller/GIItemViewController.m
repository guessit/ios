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

@interface GIItemViewController()

@end

@implementation GIItemViewController

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = GI_BACKGROUND_MAIN_COLOR;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSLog(@"   Total items: %d", self.level.items.count);
    NSLog(@"    Todo items: %d", self.level.todoItems.count);
    NSLog(@"Finished items: %d", self.level.finishedItems.count);

    GIItem *item = [self.level.items randomObject];
    NSLog(@"%@", item.answer);
}

@end
