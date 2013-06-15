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
    return [UIFont fontWithName:@"AvenirNextCondensed-Medium" size:18.f];
}

+ (UIFont *)guessItActionFont {
    return [UIFont fontWithName:@"JotiOne-Regular" size:55.f];
}

+ (UIFont *)guessItTapToPlayFont {
    return [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20.f];
}

+ (UIFont *)guessItCategoryFont {
    return [UIFont fontWithName:@"AvenirNextCondensed-Bold" size:15.f];
}

@end
