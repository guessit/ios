//
//  GISettingsViewController.m
//  GuessIt
//
//  Created by Marlon Andrade on 25/07/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GISettingsViewController.h"

#import "GIConfiguration.h"
#import "MALazykit.h"
#import "UIFont+GuessItFonts.h"
#import "UIView+CBFrameHelpers.h"

typedef enum {
    GISettingsSectionsMainOptions = 0,
    GISettingsSectionsUnlockEasyMode,
    GISettingsSectionsBuyDeveloper,
    GI_SETTINGS_NUM_SECTIONS
} GISettingsSections;

typedef enum {
    GISettingsMainOptionsRowsEasyMode = 0,
    GISettingsMainOptionsRowsReset,
    GI_SETTINGS_MAIN_OPTIONS_NUM_ROWS
} GISettingsMainOptionsRows;

typedef enum {
    GISettingsBuyDeveloperRowsCoffee = 0,
    GISettingsBuyDeveloperRowsSandwich,
    GISettingsBuyDeveloperRowsDinner,
    GISettingsBuyDeveloperRowsClothes,
    GISettingsBuyDeveloperRowsGift,
    GI_SETTINGS_BUY_DEVELOPER_NUM_ROWS
} GISettingsBuyDeveloperRows;

@interface GISettingsViewController () <UIAlertViewDelegate>

@property (nonatomic, strong, readonly) GIUserInterface *ui;

@property (nonatomic, strong) NSArray *mainOptionsDescription;
@property (nonatomic, strong) NSArray *struggle;
@property (nonatomic, strong) NSArray *buyDeveloper;

@property (nonatomic, strong) NSArray *struggleImage;
@property (nonatomic, strong) NSArray *buyDeveloperImage;

@property (nonatomic, strong) UIAlertView *resetAlert;

- (void)_cancelTouched:(id)sender;
- (void)_resetProgress;

@end

@implementation GISettingsViewController

#pragma mark - Getter

- (GIUserInterface *)ui {
    return [GIConfiguration sharedInstance].game.interface;
}

- (NSArray *)mainOptionsDescription {
    if (!_mainOptionsDescription) {
        _mainOptionsDescription = @[
            @"easy_mode",
            @"reset"
        ];
    }
    return _mainOptionsDescription;
}

- (NSArray *)struggle {
    if (!_struggle) {
        _struggle = @[
            @"unlock_easy_mode"
        ];
    }
    return _struggle;
}

- (NSArray *)buyDeveloper {
    if (!_buyDeveloper) {
        _buyDeveloper = @[
            @"buy_coffee",
            @"buy_sandwich",
            @"buy_dinner",
            @"buy_clothes",
            @"buy_gift"
        ];
    }
    return _buyDeveloper;
}

- (NSArray *)struggleImage {
    if (!_struggleImage) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.struggle.count];
        for (NSString *struggle in self.struggle) {
            NSString *imageName = [NSString stringWithFormat:@"icon_%@", struggle];
            [array addObject:[UIImage imageNamed:imageName]];
        }
        _struggleImage = array;
    }
    return _struggleImage;
}

- (NSArray *)buyDeveloperImage {
    if (!_buyDeveloperImage) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.buyDeveloper.count];
        for (NSString *buyDeveloper in self.buyDeveloper) {
            NSString *imageName = [NSString stringWithFormat:@"icon_%@", buyDeveloper];
            [array addObject:[UIImage imageNamed:imageName]];
        }
        _buyDeveloperImage = array;
    }
    return _buyDeveloperImage;
}

- (UIAlertView *)resetAlert {
    if (!_resetAlert) {
        NSString *resetTitle = NSLocalizedStringFromTable(@"reset_title", @"settings", nil);
        NSString *resetText = NSLocalizedStringFromTable(@"reset_text", @"settings", nil);
        NSString *cancelButton = NSLocalizedStringFromTable(@"cancel_button", @"general", nil);
        NSString *confirmButton = NSLocalizedStringFromTable(@"confirm_button", @"general", nil);

        _resetAlert = [[UIAlertView alloc] initWithTitle:resetTitle
                                                 message:resetText
                                                delegate:self
                                       cancelButtonTitle:cancelButton
                                       otherButtonTitles:confirmButton, nil];
    }
    return _resetAlert;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = self.ui.settings.secondaryBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0.f, 0.f, 70.f, 40.f);
    [cancelButton setTitleColor:self.ui.navigation.color forState:UIControlStateNormal];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self
                     action:@selector(_cancelTouched:)
           forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonWithCustomView:cancelButton];
}

#pragma mark - Private Interface

- (void)_cancelTouched:(id)sender {
    [self.settingsDelegate didCancelSettingsViewController:self];
}

- (void)_resetProgress {
    if (!self.resetAlert.visible) {
        [self.resetAlert show];
    }
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
        case GISettingsSectionsUnlockEasyMode:
            noRows = self.struggle.count;
            break;
        case GISettingsSectionsBuyDeveloper:
            noRows = self.buyDeveloper.count;
            break;
    }

    return noRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"settings-cell-%d", indexPath.section];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        cell = [UITableViewCell cellWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = self.ui.settings.secondaryBackgroundColor;
        cell.textLabel.font = [UIFont guessItSettingsTextFont];
        cell.textLabel.textColor = self.ui.settings.secondaryTextColor;
        cell.textLabel.shadowColor = self.ui.settings.secondaryShadowColor;
        cell.textLabel.shadowOffset = CGSizeMake(0.f, -1.f);
        cell.textLabel.numberOfLines = 2.f;
    }

    NSString *key = nil;
    UIImage *image = nil;
    switch (indexPath.section) {
        case GISettingsSectionsMainOptions:
            key = self.mainOptionsDescription[indexPath.row];
            break;
        case GISettingsSectionsUnlockEasyMode:
            key = self.struggle[indexPath.row];
            image = self.struggleImage[indexPath.row];
            break;
        case GISettingsSectionsBuyDeveloper:
            key = self.buyDeveloper[indexPath.row];
            image = self.buyDeveloperImage[indexPath.row];
            break;
    }

    cell.textLabel.text = NSLocalizedStringFromTable(key, @"settings", nil);
    cell.imageView.image = image;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    switch (section) {
        case GISettingsSectionsMainOptions:
        title = NSLocalizedStringFromTable(@"settings", @"settings", nil);
        break;

        case GISettingsSectionsUnlockEasyMode:
        title = NSLocalizedStringFromTable(@"struggle", @"settings", nil);
        break;

        case GISettingsSectionsBuyDeveloper:
        title = NSLocalizedStringFromTable(@"liked_the_game", @"settings", nil);
        break;
    }

    return title;
}

#pragma mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44.f;

    if (indexPath.section != GISettingsSectionsMainOptions) {
        height = 80.f;
    }

    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [UILabel label];
    label.font = [UIFont guessItSettingsTitleFont];
    label.backgroundColor = self.ui.settings.backgroundColor;
    label.textColor = self.ui.settings.textColor;
    label.shadowColor = self.ui.settings.shadowColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.shadowOffset = CGSizeMake(0.f, -1.f);

    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    label.text = title;

    return label;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case GISettingsSectionsMainOptions:
            switch (indexPath.row) {
                case GISettingsMainOptionsRowsEasyMode:
                    break;
                case GISettingsMainOptionsRowsReset:
                    [self _resetProgress];
                    break;
            }
            break;
        case GISettingsSectionsUnlockEasyMode:
            #warning TODO: buy unlock easy mode
            break;
        case GISettingsSectionsBuyDeveloper:
            switch (indexPath.row) {
                case GISettingsBuyDeveloperRowsCoffee:
                    #warning TODO: buy coffee
                    break;
                case GISettingsBuyDeveloperRowsSandwich:
                    #warning TODO: buy sandwich
                    break;
                case GISettingsBuyDeveloperRowsDinner:
                    #warning TODO: buy dinner
                    break;
                case GISettingsBuyDeveloperRowsClothes:
                    #warning TODO: buy clothes
                    break;
                case GISettingsBuyDeveloperRowsGift:
                    #warning TODO: buy gift
                    break;
            }
            break;
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex > 0) {
        [[GIConfiguration sharedInstance] resetProgress];
        [self.settingsDelegate didResetProgressWithSettingsViewController:self];
    }
}

@end
