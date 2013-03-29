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

@interface GILevelsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *bsiLevels;

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
    backButton.frame = CGRectMake(0.f, 0.f, 100.f, 40.f);
    backButton.backgroundColor = [UIColor redColor];
    [backButton setTitle:@"Teste" forState:UIControlStateNormal];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithCustomView:backButton];
    self.navigationItem.hidesBackButton = YES;
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
