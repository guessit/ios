//
//  GIKeypadView.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/24/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GIKeypadViewDelegate.h"

@interface GIKeypadView : UIView 

@property (nonatomic, weak) id<GIKeypadViewDelegate> delegate;
@property (nonatomic, copy) NSString *correctAnswer;

- (void)addLetterView:(GILetterView *)letterView;

@end
