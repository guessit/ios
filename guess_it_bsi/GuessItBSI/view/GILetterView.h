//
//  GILetterView.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GI_LETTER_SHADOW_COLOR [UIColor colorWithWhite:0.38f alpha:1.f]
#define GI_LETTER_TEXT_COLOR [UIColor colorWithWhite:0.88f alpha:1.f]

@interface GILetterView : UIView

@property (nonatomic, strong) NSString *letter;
@property (nonatomic, strong, readonly) UILabel *label;

@end
