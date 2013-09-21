//
//  UIFont+GuessItFonts.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 21/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (GuessItFonts)

+ (UIFont *)lobsterWithSize:(CGFloat)size;
+ (UIFont *)questionMarkWithSize:(CGFloat)size;
+ (UIFont *)guessItNormalFontWithSize:(CGFloat)size;
+ (UIFont *)guessItDemiBoldFontWithSize:(CGFloat)size;
+ (UIFont *)guessItBoldFontWithSize:(CGFloat)size;
+ (UIFont *)guessItHeavyFontWithSize:(CGFloat)size;

+ (UIFont *)guessItTitleFont;
+ (UIFont *)guessItNavigationTitleFont;
+ (UIFont *)guessItBackButtonFont;
+ (UIFont *)guessItBarButtonFont;
+ (UIFont *)guessItKeypadLetterFont;
+ (UIFont *)guessItActionFont;
+ (UIFont *)guessItTapToPlayFont;
+ (UIFont *)guessItCategoryFont;

+ (UIFont *)guessItIconButtonFont;

+ (UIFont *)guessItSettingsTitleFont;
+ (UIFont *)guessItSettingsTextFont;

+ (UIFont *)guessItCongratulationTitleFont;
+ (UIFont *)guessItCongratulationDescriptionFont;
+ (UIFont *)guessItCongratulationAnswerDescriptionFont;
+ (UIFont *)guessItCongratulationAnswerFont;

+ (UIFont *)guessItGameOverCongratulationsFont;
+ (UIFont *)guessItGameOverDescriptionFont;
+ (UIFont *)guessItGameOverResetProgressFont;

+ (UIFont *)guessItKnowOtherGamesLikedItFont;
+ (UIFont *)guessItKnowOtherGamesTitleFont;
+ (UIFont *)guessItKnowOtherGamesDescription;
+ (UIFont *)guessItKnowOtherGamesWebsiteFont;

+ (UIFont *)guessItCreditsFont;
+ (UIFont *)guessItCreditsRoleFont;
+ (UIFont *)guessItCreditsPersonFont;
+ (UIFont *)guessItCreditsThankYouFont;

@end
