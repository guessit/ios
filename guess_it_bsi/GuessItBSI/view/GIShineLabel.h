//
//  GIShineLabel.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 21/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GIShineLabel : UILabel

@property (nonatomic, strong) UIColor *shineColor;

- (void)flash;

@end
