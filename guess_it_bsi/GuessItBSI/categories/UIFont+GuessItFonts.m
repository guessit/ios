//
//  UIFont+GuessItFonts.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 21/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "UIFont+GuessItFonts.h"

@implementation UIFont (GuessItFonts)

+ (UIFont *)guessItTitleFont {
    return [UIFont fontWithName:@"Lobster" size:70.f];
}

+ (UIFont *)guessItNavigationTitleFont {
    return [UIFont fontWithName:@"Lobster" size:26.f];
}

+ (UIFont *)guessItKeypadLetterFont {
    return [UIFont fontWithName:@"GillSans" size:18.f];
}

@end
