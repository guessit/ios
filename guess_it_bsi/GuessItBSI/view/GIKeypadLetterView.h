//
//  GIKeypadLetterView.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/24/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GILetterView.h"

#define GI_KEYPAD_LETTER_COLOR GI_BACKGROUND_MAIN_COLOR

@interface GIKeypadLetterView : GILetterView

- (void)zoomIn;
- (void)zoomOut;

@end
