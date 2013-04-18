//
//  GILevelsViewController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 26/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevelsViewController.h"

#import "GIItem.h"
#import "GIItemViewController.h"
#import "GILevel.h"
#import "GILevel+Factory.h"
#import "GILevelCell.h"
#import "GIUserInterfaceCustomizations.h"

@interface GILevelsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *bsiLevels;

@end

@implementation GILevelsViewController

#pragma mark - Getter

- (NSArray *)bsiLevels {
    if (!_bsiLevels) {
        _bsiLevels = @[
            [GILevel bancoDados],
            [GILevel frameworks],
            [GILevel ides],
            [GILevel linguagensProgramacao],
            [GILevel ferramentas]
        ];

        #warning TODO: BROWSER
        #warning TODO: SISTEMAS OPERACIONAIS

    }
    return _bsiLevels;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = GI_BACKGROUND_MAIN_COLOR;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSLog(@"Index paths: %@", self.tableView.indexPathsForSelectedRows);
    [self.tableView reloadRowsAtIndexPaths:self.tableView.indexPathsForSelectedRows
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GIItemViewController *itemViewController = segue.destinationViewController;
    itemViewController.level = self.bsiLevels[self.tableView.indexPathForSelectedRow.row];
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
