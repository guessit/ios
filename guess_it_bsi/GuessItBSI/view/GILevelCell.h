//
//  GILevelCell.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 29/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GILevel.h"

@interface GILevelCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *progressLabel;

@property (nonatomic, strong) GILevel *level;

@end
