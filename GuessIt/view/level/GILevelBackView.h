//
//  GILevelBackView.h
//  GuessIt
//
//  Created by Marlon Andrade on 13/10/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GILevel.h"
#import "GILevelBackView.h"
#import "GILevelBackViewDelegate.h"

@interface GILevelBackView : UIView

@property (nonatomic, weak) id<GILevelBackViewDelegate> delegate;

@property (nonatomic, strong) GILevel *currentLevel;

+ (instancetype)levelBackViewWithDelegate:(id<GILevelBackViewDelegate>)delegate;

@end
