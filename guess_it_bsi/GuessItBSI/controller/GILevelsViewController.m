//
//  GILevelsViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 26/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevelsViewController.h"
#import "GILevel.h"

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

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bsiLevels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *levelsIdentifier = @"level_row";

    GILevel *level = [self.bsiLevels objectAtIndex:indexPath.row];

    UITableViewCell *levelCell = [tableView dequeueReusableCellWithIdentifier:levelsIdentifier];

    levelCell.textLabel.text = level.name;

    return levelCell;
}

#pragma mark - UITableViewDelegate Methods

@end
