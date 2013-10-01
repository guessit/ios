//
//  UIFont+GuessItFonts.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 21/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "UIFont+GuessItFonts.h"

@implementation UIFont (GuessItFonts)

+ (UIFont *)lobsterWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Lobster" size:size];
}

+ (UIFont *)questionMarkWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"JotiOne-Regular" size:size];
}

+ (UIFont *)guessItNormalFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AvenirNextCondensed-Medium" size:size];
}

+ (UIFont *)guessItDemiBoldFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:size];
}

+ (UIFont *)guessItBoldFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AvenirNextCondensed-Bold" size:size];
}

+ (UIFont *)guessItHeavyFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AvenirNextCondensed-Heavy" size:size];
}

+ (UIFont *)guessItTitleFont {
    return [self lobsterWithSize:70.f];
}

+ (UIFont *)guessItNavigationTitleFont {
    return [self lobsterWithSize:26.f];
}

+ (UIFont *)guessItBackButtonFont {
    return [UIFont fontWithName:@"EuphemiaUCAS" size:22.f];
}

+ (UIFont *)guessItBarButtonFont {
    return [self questionMarkWithSize:30.f];
}

+ (UIFont *)guessItKeypadLetterFont {
    return [self guessItNormalFontWithSize:18.f];
}

+ (UIFont *)guessItActionFont {
    return [self questionMarkWithSize:55.f];
}

+ (UIFont *)guessItTapToPlayFont {
    return [self guessItBoldFontWithSize:20.f];
}

+ (UIFont *)guessItCategoryFont {
    return [self guessItDemiBoldFontWithSize:15.f];
}

+ (UIFont *)guessItIconButtonFont {
    return [self guessItBoldFontWithSize:19.f];
}

+ (UIFont *)guessItSettingsTitleFont {
    return [self guessItNormalFontWithSize:18.f];
}

+ (UIFont *)guessItSettingsTextFont {
    return [self guessItDemiBoldFontWithSize:16.f];
}

+ (UIFont *)guessItCongratulationTitleFont {
    return [self lobsterWithSize:40.f];
}

+ (UIFont *)guessItCongratulationDescriptionFont {
    return [self guessItBoldFontWithSize:18.f];
}

+ (UIFont *)guessItCongratulationAnswerDescriptionFont {
    return [self guessItBoldFontWithSize:15.f];
}

+ (UIFont *)guessItCongratulationAnswerFont {
    return [self guessItBoldFontWithSize:35.f];
}

+ (UIFont *)guessItGameOverFont {
    return [self guessItHeavyFontWithSize:48.f];
}

+ (UIFont *)guessItGameOverCongratulationsFont {
    return [self lobsterWithSize:40.f];
}

+ (UIFont *)guessItGameOverDescriptionFont {
    return [self guessItBoldFontWithSize:18.f];
}

+ (UIFont *)guessItGameOverResetProgressFont {
    return [self guessItDemiBoldFontWithSize:17.f];
}

+ (UIFont *)guessItKnowOtherGamesLikedItFont {
    return [self guessItHeavyFontWithSize:40.f];
}

+ (UIFont *)guessItKnowOtherGamesTitleFont {
    return [self guessItBoldFontWithSize:26.f];
}

+ (UIFont *)guessItKnowOtherGamesDescription {
    return [self guessItDemiBoldFontWithSize:17.f];
}

+ (UIFont *)guessItKnowOtherGamesWebsiteFont {
    return [self guessItBoldFontWithSize:22.f];
}

+ (UIFont *)guessItCreditsFont {
    return  [self guessItHeavyFontWithSize:40.f];
}

+ (UIFont *)guessItCreditsRoleFont {
    return [self guessItNormalFontWithSize:12.f];
}

+ (UIFont *)guessItCreditsPersonFont {
    return [self guessItDemiBoldFontWithSize:15.f];
}

+ (UIFont *)guessItCreditsThankYouFont {
    return [self guessItDemiBoldFontWithSize:20.f];
}

@end
