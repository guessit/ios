//
//  GISettingsViewController.m
//  GuessIt
//
//  Created by Marlon Andrade on 25/07/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GISettingsViewController.h"

#import "MALazykit.h"

typedef enum {
    GISettingsSectionsMainOptions = 0,
    GISettingsSectionsIAPOptions,
    GI_SETTINGS_NUM_SECTIONS
} GISettingsSections;

@interface GISettingsViewController ()

@property (nonatomic, strong) NSArray *mainOptionsDescription;
@property (nonatomic, strong) NSArray *iapDescription;

- (void)_cancelTouched:(id)sender;

@end

@implementation GISettingsViewController

#pragma mark - Getter

- (NSArray *)mainOptionsDescription {
    if (!_mainOptionsDescription) {
        _mainOptionsDescription = @[
            @"Easy mode",
            @"Reset"
        ];
    }
    return _mainOptionsDescription;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonWithSystemItem:UIBarButtonSystemItemCancel
                                                                           target:self
                                                                           action:@selector(_cancelTouched:)];
}

#pragma mark - Private Interface

- (void)_cancelTouched:(id)sender {
    [self.settingsDelegate didCancelSettingsViewController:self];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return GI_SETTINGS_NUM_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger noRows = 0;

    switch (section) {
        case GISettingsSectionsMainOptions:
            noRows = self.mainOptionsDescription.count;
            break;
        case GISettingsSectionsIAPOptions:
            noRows = self.iapDescription.count;
            break;
    }

    return noRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"settings-cell-%d", indexPath.section];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        cell = [UITableViewCell cellWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    NSString *description = nil;
    switch (indexPath.section) {
        case GISettingsSectionsMainOptions:
            description = self.mainOptionsDescription[indexPath.row];
            break;
        case GISettingsSectionsIAPOptions:
            description = self.iapDescription[indexPath.row];
            break;
    }

    cell.textLabel.text = description;
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44.f;

    if (indexPath.section == GISettingsSectionsIAPOptions) {
        height = 100.f;
    }

    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
