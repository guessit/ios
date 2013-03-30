//
//  GILevelsViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 26/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevelsViewController.h"

#import "GILevel.h"
#import "GILevelCell.h"
#import "GIUserInterfaceCustomizations.h"

@interface GILevelsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *bsiLevels;

- (void)_backButtonTouched:(id)sender;

@end

@implementation GILevelsViewController

#pragma mark - Getter

- (NSArray *)bsiLevels {
    if (!_bsiLevels) {
        _bsiLevels = @[
            [GILevel levelWithName:@"Algoritmos"],
            [GILevel levelWithName:@"Banco de Dados"],
            [GILevel levelWithName:@"Linguagens de Programação"],
            [GILevel levelWithName:@"Padrões de Projeto"],
            [GILevel levelWithName:@"UML"]
        ];
    }
    return _bsiLevels;
}

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
    self.navigationItem.hidesBackButton = YES;
}

#pragma mark - Private Interface

- (void)_backButtonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bsiLevels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *levelsIdentifier = @"level_row";

    GILevelCell *levelCell = [tableView dequeueReusableCellWithIdentifier:levelsIdentifier];
    levelCell.level = [self.bsiLevels objectAtIndex:indexPath.row];

    return levelCell;
}

#pragma mark - UITableViewDelegate Methods

@end
