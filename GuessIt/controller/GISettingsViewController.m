//
//  GISettingsViewController.m
//  GuessIt
//
//  Created by Marlon Andrade on 25/07/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GISettingsViewController.h"

#import "GIDefinitions.h"
#import "GIConfiguration.h"
#import "GIIAPManager.h"
#import "GISettingsCell.h"
#import "GISettingsBuyCell.h"
#import "MALazykit.h"
#import "SVProgressHUD.h"
#import "UIColor+SSToolkitAdditions.h"
#import "UIFont+GuessItFonts.h"
#import "UIView+CBFrameHelpers.h"

#import <StoreKit/StoreKit.h>

typedef enum {
    GISettingsSectionsMainOptions = 0,
    GISettingsSectionsBuyDeveloper,
    GI_SETTINGS_NUM_SECTIONS
} GISettingsSections;

typedef enum {
    GISettingsMainOptionsRowsReset = 0,
    GI_SETTINGS_MAIN_OPTIONS_NUM_ROWS
} GISettingsMainOptionsRows;

@interface GISettingsViewController () <UIAlertViewDelegate>

@property (nonatomic, strong, readonly) GIUserInterface *ui;
@property (nonatomic, strong, readonly) NSNumberFormatter *priceFormatter;

@property (nonatomic, strong) NSArray *mainOptionsDescription;

@property (nonatomic, strong) NSArray *buyDeveloper;
@property (nonatomic, strong) NSArray *buyDeveloperImage;

@property (nonatomic, strong) UIAlertView *resetAlert;

- (void)_productsDidFinishLoading:(NSNotification *)notification;
- (void)_productPurchased:(NSNotification *)notification;
- (void)_productPurchaseFailed:(NSNotification *)notification;
- (void)_deselectTableViewSelectedRow;
- (void)_cancelTouched:(id)sender;
- (void)_resetProgress;

@end

@implementation GISettingsViewController

@synthesize priceFormatter = _priceFormatter;

#pragma mark - Getter

- (GIUserInterface *)ui {
    return [GIConfiguration sharedInstance].game.interface;
}

- (NSNumberFormatter *)priceFormatter {
    if (!_priceFormatter) {
        _priceFormatter = [[NSNumberFormatter alloc] init];
        _priceFormatter.formatterBehavior = NSNumberFormatterBehavior10_4;
        _priceFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    }
    return _priceFormatter;
}

- (NSArray *)mainOptionsDescription {
    if (!_mainOptionsDescription) {
        _mainOptionsDescription = @[
            @"reset"
        ];
    }
    return _mainOptionsDescription;
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];


    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_productsDidFinishLoading:)
                                                 name:GIProductsDidFinishLoadingNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_productPurchased:)
                                                 name:GIIAPManagerProductPurchasedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_productPurchaseFailed:)
                                                 name:GIIAPManagerProductPurchaseFailedNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [super viewDidDisappear:animated];
}

#pragma mark - Private Interface

- (void)_productsDidFinishLoading:(NSNotification *)notification {
    [self.tableView reloadData];
}

- (void)_productPurchased:(NSNotification *)notification {
    [self _deselectTableViewSelectedRow];
    [SVProgressHUD showSuccessWithStatus:NSLocalizedStringFromTable(@"thank_you", @"settings", nil)];
}

- (void)_productPurchaseFailed:(NSNotification *)notification {
    [self _deselectTableViewSelectedRow];
    [SVProgressHUD showErrorWithStatus:@"=("];
}

- (void)_deselectTableViewSelectedRow {
    if (self.tableView.indexPathForSelectedRow) {
        [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    }
}

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
    NSInteger noSections = 1;

    if ([SKPaymentQueue canMakePayments]) {
        if ([GIConfiguration sharedInstance].products.count > 0) {
            noSections = GI_SETTINGS_NUM_SECTIONS;
        } else {
            [[GIConfiguration sharedInstance] loadInAppPurchasesProducts];
        }
    }

    return noSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger noRows = 0;

    switch (section) {
        case GISettingsSectionsMainOptions:
            noRows = GI_SETTINGS_MAIN_OPTIONS_NUM_ROWS;
            break;
        case GISettingsSectionsBuyDeveloper:
            noRows = [GIConfiguration sharedInstance].products.count;
            break;
    }

    return noRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"settings-cell-%d", indexPath.section];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        switch (indexPath.section) {
            case GISettingsSectionsMainOptions:
                cell = [GISettingsCell cellWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                break;
            case GISettingsSectionsBuyDeveloper:
                cell = [GISettingsBuyCell cellWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                break;
        }
    }

    NSString *key = nil;
    UIImage *image = nil;
    SKProduct *product = nil;

    switch (indexPath.section) {
        case GISettingsSectionsMainOptions:
            key = self.mainOptionsDescription[indexPath.row];
            cell.textLabel.text = NSLocalizedStringFromTable(key, @"settings", nil);
            break;
        case GISettingsSectionsBuyDeveloper:
            product = [GIConfiguration sharedInstance].products[indexPath.row];
            self.priceFormatter.locale = product.priceLocale;

            cell.textLabel.text = product.localizedDescription;
            image = self.buyDeveloperImage[indexPath.row];

            GISettingsBuyCell *buyCell = (GISettingsBuyCell *)cell;
            buyCell.priceLabel.text = [self.priceFormatter stringFromNumber:product.price];
            break;
    }

    cell.imageView.image = image;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    switch (section) {
        case GISettingsSectionsMainOptions:
            title = NSLocalizedStringFromTable(@"settings", @"settings", nil);
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
    SKProduct *product = nil;

    switch (indexPath.section) {
        case GISettingsSectionsMainOptions:
            switch (indexPath.row) {
                case GISettingsMainOptionsRowsReset:
                    [self _resetProgress];
                    break;
            }
            break;
        case GISettingsSectionsBuyDeveloper:
            product = [GIConfiguration sharedInstance].products[indexPath.row];
            break;
    }

    if (product) {
        [[GIIAPManager sharedInstance] purchaseProduct:product];
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex > 0) {
        [[GIConfiguration sharedInstance] resetProgress];
        [self.settingsDelegate didResetProgressWithSettingsViewController:self];
    }
}

@end
