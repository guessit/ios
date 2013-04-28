//
//  GIInputView.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GIItem.h"

#define GI_INPUT_VIEW_HEIGHT 182.f
#define GI_KEYPAD_HEIGHT 88.f

@interface GIInputView : UIView <UIInputViewAudioFeedback>

@property (nonatomic, strong) GIItem *item;

@end
