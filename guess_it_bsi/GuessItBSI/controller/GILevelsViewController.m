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

@end

@implementation GILevelsViewController

#pragma mark - Getter

- (NSArray *)bsiLevels {
    if (!_bsiLevels) {
        GILevel *algoritmos = [GILevel levelWithName:@"Algoritmos"];
        GILevel *bancoDados = [GILevel levelWithName:@"Banco de Dados"];
        GILevel *linguagensProgramacao = [GILevel levelWithName:@"Linguagens de Programação"];
        GILevel *padroesProjeto = [GILevel levelWithName:@"Padrões de Projeto"];

        _bsiLevels = @[
            algoritmos,
            bancoDados,
            linguagensProgramacao,
            padroesProjeto
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

    GILevelCell *levelCell = [tableView dequeueReusableCellWithIdentifier:levelsIdentifier];
    levelCell.level = [self.bsiLevels objectAtIndex:indexPath.row];

    return levelCell;
}

#pragma mark - UITableViewDelegate Methods

@end
