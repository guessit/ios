//
//  GIGlowButton.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 03/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GIGlowButton : UIButton

@property (nonatomic, strong) UIColor *glowColor;

- (void)glow;

@end
