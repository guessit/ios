//
//  GIInputView.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GIItem.h"

@interface GIInputView : UIView <UIInputViewAudioFeedback>

@property (nonatomic, strong) GIItem *item;

@end
