//
//  GICategoriesViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 13/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GICategoriesViewController.h"
#import "GICategory.h"

@interface GICategoriesViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *bsiCategories;

@end

@implementation GICategoriesViewController

#pragma mark - Getter

- (NSArray *)bsiCategories {
    if (!_bsiCategories) {
        _bsiCategories = @[
            [GICategory categoryWithName:@"Algoritmos"],
            [GICategory categoryWithName:@"Banco de Dados"],
            [GICategory categoryWithName:@"Linguagens de Programação"],
            [GICategory categoryWithName:@"Padrões de Projeto"],
            [GICategory categoryWithName:@"UML"],
        ];
    }
    return _bsiCategories;
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bsiCategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *categoriesIdentifier = @"category_row";

    GICategory *category = [self.bsiCategories objectAtIndex:indexPath.row];

    UITableViewCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:categoriesIdentifier];

    categoryCell.textLabel.text = category.name;

    return categoryCell;
}

#pragma mark - UITableViewDelegate Methods

@end
