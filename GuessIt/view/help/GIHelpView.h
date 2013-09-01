//
//  GIHelpView.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 11/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GIHelpViewDelegate.h"

@interface GIHelpView : UIView

@property (nonatomic, weak) id<GIHelpViewDelegate> delegate;

- (void)adjustEnabledButtons;

@end
