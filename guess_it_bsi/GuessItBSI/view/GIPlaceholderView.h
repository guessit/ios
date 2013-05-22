//
//  GIPlaceholderView.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GILetterView.h"

@interface GIPlaceholderView : UIView

@property (nonatomic, strong) NSString *letter;
@property (nonatomic, weak) GILetterView *originalLetterView;

@end
