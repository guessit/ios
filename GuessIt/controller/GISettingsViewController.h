//
//  GISettingsViewController.h
//  GuessIt
//
//  Created by Marlon Andrade on 25/07/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GISettingsDelegate;

@interface GISettingsViewController : UITableViewController

@property (nonatomic, weak) id<GISettingsDelegate> settingsDelegate;

@end

@protocol GISettingsDelegate <NSObject>

- (void)didCancelSettingsViewController:(GISettingsViewController *)settingsViewController;

@end
