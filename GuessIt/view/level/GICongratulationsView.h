//
//  GICongratulationsView.h
//  GuessIt
//
//  Created by Marlon Andrade on 16/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GILevel.h"
#import "GICongratulationsViewDelegate.h"

@interface GICongratulationsView : UIView

@property (nonatomic, weak) id<GICongratulationsViewDelegate> delegate;
@property (nonatomic, strong) GILevel *level;

@end
