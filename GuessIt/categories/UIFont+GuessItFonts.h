//
//  UIFont+GuessItFonts.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 21/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (GuessItFonts)

+ (UIFont *)guessItTitleFont;
+ (UIFont *)guessItNavigationTitleFont;
+ (UIFont *)guessItBackButtonFont;
+ (UIFont *)guessItBarButtonFont;
+ (UIFont *)guessItKeypadLetterFont;
+ (UIFont *)guessItActionFont;
+ (UIFont *)guessItTapToPlayFont;
+ (UIFont *)guessItCategoryFont;

+ (UIFont *)guessItCongratulationTitleFont;
+ (UIFont *)guessItCongratulationDescriptionFont;
+ (UIFont *)guessItCongratulationAnswerDescriptionFont;
+ (UIFont *)guessItCongratulationAnswerFont;

@end
