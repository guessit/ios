//
//  GISettingsViewController.m
//  GuessIt
//
//  Created by Marlon Andrade on 25/07/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GISettingsViewController.h"

#import "GIBarButton.h"
#import "GIDefinitions.h"
#import "GIConfiguration.h"
#import "GIIAPManager.h"
#import "GISettingsCell.h"
#import "GISettingsBuyCell.h"
#import "MALazykit.h"
#import "NSObject+Analytics.h"
#import "SVProgressHUD.h"
#import "UIColor+SAMAdditions.h"
#import "UIFont+GuessItFonts.h"
#import "UIView+CBFrameHelpers.h"

#import <StoreKit/StoreKit.h>

typedef enum {
    GISettingsSectionsMainOptions = 0,
    GISettingsSectionsBundleIAP,
    GISettingsSectionsDonationIAP,
    GI_SETTINGS_NUM_SECTIONS
} GISettingsSections;

typedef enum {
    GISettingsMainOptionsRowsReset = 0,
    GI_SETTINGS_MAIN_OPTIONS_NUM_ROWS
} GISettingsMainOptionsRows;

@interface GISettingsViewController () <UIAlertViewDelegate>

@property (nonatomic, strong, readonly) GIUserInterface *ui;
@property (nonatomic, strong, readonly) NSNumberFormatter *priceFormatter;

@property (nonatomic, strong) UIImageView *secondaryBackgroundImageView;

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

- (UIImageView *)secondaryBackgroundImageView {
    if (!_secondaryBackgroundImageView) {
        _secondaryBackgroundImageView = [UIImageView imageViewWithImageNamed:@"secondary_background"];
        _secondaryBackgroundImageView.contentMode = UIViewContentModeCenter;
    }
    return _secondaryBackgroundImageView;
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

    if (self.secondaryBackgroundImageView.image) {
        self.tableView.backgroundView = self.secondaryBackgroundImageView;
    }

    self.view.backgroundColor = self.ui.settings.secondaryBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.navigationController.navigationBar.tintColor = [UIColor redColor];

    GIBarButton *cancelButton = [GIBarButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0.f, 0.f, 80.f, 40.f);
    [cancelButton setTitleColor:self.ui.navigation.color forState:UIControlStateNormal];
    [cancelButton setTitle:NSLocalizedStringFromTable(@"cancel_button", @"general", nil)
                  forState:UIControlStateNormal];
    [cancelButton addTarget:self
                     action:@selector(_cancelTouched:)
           forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonWithCustomView:cancelButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self trackViewWithName:@"SettingsView"];

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
        if ([GIConfiguration sharedInstance].allProducts.count > 0) {
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
        case GISettingsSectionsBundleIAP:
            noRows = [GIConfiguration sharedInstance].bundleProducts.count;
            break;
        case GISettingsSectionsDonationIAP:
            noRows = [GIConfiguration sharedInstance].donationProducts.count;
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
            case GISettingsSectionsBundleIAP:
                cell = [GISettingsBuyCell cellWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                break;
            case GISettingsSectionsDonationIAP:
                cell = [GISettingsBuyCell cellWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                break;
        }
    }

    SKProduct *product = nil;
    UIImage *image = nil;

    if (indexPath.section == GISettingsSectionsBundleIAP) {
        product = [GIConfiguration sharedInstance].bundleProducts[indexPath.row];
    } else if (indexPath.section == GISettingsSectionsDonationIAP) {
        product = [GIConfiguration sharedInstance].donationProducts[indexPath.row];
        image = self.buyDeveloperImage[indexPath.row];
    }

    if (product) {
        self.priceFormatter.locale = product.priceLocale;

        GISettingsBuyCell *buyCell = (GISettingsBuyCell *)cell;

        buyCell.textLabel.text = product.localizedDescription;
        buyCell.imageView.image = image;
        buyCell.priceLabel.text = [self.priceFormatter stringFromNumber:product.price];
    } else {
        NSString *key = self.mainOptionsDescription[indexPath.row];
        cell.textLabel.text = NSLocalizedStringFromTable(key, @"settings", nil);
    }

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    switch (section) {
        case GISettingsSectionsMainOptions:
            title = NSLocalizedStringFromTable(@"settings", @"settings", nil);
            break;
        case GISettingsSectionsBundleIAP:
            title = NSLocalizedStringFromTable(@"play_more", @"settings", nil);
            break;
        case GISettingsSectionsDonationIAP:
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
    CGFloat height = 40.f;

    if ([self tableView:tableView numberOfRowsInSection:section] == 0) {
        height = 0.f;
    }

    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = 0.f;

    if (section == GISettingsSectionsDonationIAP) {
        height = 55.f;
    }

    return height;
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UILabel *label = nil;

    if (section == GISettingsSectionsDonationIAP) {
        label = [UILabel label];
        UIFont *headerFont = [UIFont guessItSettingsTitleFont];
        label.font = [headerFont fontWithSize:headerFont.pointSize - 5.f];
        label.backgroundColor = self.ui.settings.backgroundColor;
        label.textColor = self.ui.settings.textColor;
        label.shadowColor = self.ui.settings.shadowColor;
        label.shadowOffset = CGSizeMake(0.f, -1.f);
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2.f;

        label.text = NSLocalizedStringFromTable(@"remove_ads", @"settings", nil);
    }

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
        case GISettingsSectionsBundleIAP:
            product = [GIConfiguration sharedInstance].bundleProducts[indexPath.row];
            break;
        case GISettingsSectionsDonationIAP:
            product = [GIConfiguration sharedInstance].donationProducts[indexPath.row];
            break;
    }

    if (product) {
        [[GIIAPManager sharedInstance] purchaseProduct:product];
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [self trackEventWithCategory:@"game"
                              action:@"iap"
                               label:product.productIdentifier
                               value:nil];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex > 0) {
        [[GIConfiguration sharedInstance] resetProgress];
        [self.settingsDelegate didResetProgressWithSettingsViewController:self];
        [self trackEventWithCategory:@"game"
                              action:@"reset_progress"
                               label:nil
                               value:nil];
    }
}

@end
