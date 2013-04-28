//
//  GIKeypadLetterView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/24/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIKeypadLetterView.h"

#import "GIUserInterfaceCustomizations.h"
#import "UIFont+GuessItFonts.h"

#define GI_KEYPAD_LETTER_ZOOMED_SCALE 1.15f
#define GI_KEYPAD_LETTER_ZOOMED_COLOR [UIColor colorWithWhite:0.25 alpha:1.f]
#define GI_KEYPAD_LETTER_ZOOMED_TEXT_COLOR [UIColor colorWithWhite:0.95 alpha:1.f]

@implementation GIKeypadLetterView

#pragma mark - Public Interface

- (void)zoomIn {
    [UIView animateWithDuration:0.2f animations:^{
        self.transform = CGAffineTransformMakeScale(GI_KEYPAD_LETTER_ZOOMED_SCALE, GI_KEYPAD_LETTER_ZOOMED_SCALE);
        self.backgroundColor = GI_KEYPAD_LETTER_ZOOMED_COLOR;
        self.label.textColor = GI_KEYPAD_LETTER_ZOOMED_TEXT_COLOR;
    }];
}

- (void)zoomOut {
    [UIView animateWithDuration:0.2f animations:^{
        self.transform = CGAffineTransformIdentity;
        self.backgroundColor = GI_KEYPAD_LETTER_COLOR;
        self.label.textColor = GI_LETTER_TEXT_COLOR;
    }];
}

@end
