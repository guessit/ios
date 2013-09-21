//
//  GIGameOverView.h
//  GuessIt
//
//  Created by Marlon Andrade on 05/09/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GIGameOverViewDelegate.h"

@interface GIGameOverView : UIScrollView <GIGameOverViewDelegate>

@property (nonatomic, weak) id<GIGameOverViewDelegate> gameOverDelegate;

@end
