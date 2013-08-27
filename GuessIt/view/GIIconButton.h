//
//  GIIconButton.h
//  GuessIt
//
//  Created by Marlon Andrade on 08/21/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FAImageView.h"

@interface GIIconButton : UIButton

+ (instancetype)buttonWithIcon:(FAIcon)icon;

@property (nonatomic, assign) FAIcon icon;

@end