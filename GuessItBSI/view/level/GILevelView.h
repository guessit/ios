//
//  GILevelView.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 27/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GILevel.h"
#import "GILevelViewDelegate.h"

@interface GILevelView : UIView

@property (nonatomic, weak) id<GILevelViewDelegate> levelDelegate;
@property (nonatomic, strong) GILevel *level;

@end
