//
//  GIDefinitions.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/17/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#pragma mark - NSNotification

extern NSString * const GICurrentLevelDidChangeNotification;

#pragma mark - NSUserDefaults Keys

#define GI_CURRENT_LEVEL @"GuessItCurrentLevel"
#define GI_FINISHED_LEVELS @"GuessItFinishedLevels"

#pragma mark - Background Colors

#define GI_BACKGROUND_MAIN_COLOR [UIColor colorWithWhite:0.200 alpha:1.000]
#define GI_BACKGROUND_MAIN_DARKER_COLOR [UIColor colorWithWhite:0.170 alpha:1.000]
#define GI_BACKGROUND_MAIN_DARKEST_COLOR [UIColor colorWithWhite:0.100 alpha:1.000]
#define GI_BACKGROUND_MAIN_LIGHTER_COLOR [UIColor colorWithWhite:0.230 alpha:1.000]
#define GI_BACKGROUND_MAIN_LIGHTEST_COLOR [UIColor colorWithWhite:0.300 alpha:1.000]

#pragma mark - Title

#define GI_TITLE_COLOR [UIColor colorWithRed:1.000 green:0.800 blue:0.000 alpha:1.000]
#define GI_TITLE_SHINE_COLOR [UIColor colorWithRed:0.980 green:0.984 blue:0.843 alpha:1.000]
#define GI_TITLE_SHADOW_COLOR [UIColor blackColor]
#define GI_TITLE_SHADOW_OFFSET CGSizeMake(0.f, -1.f)

#pragma mark - Tap To Play

#define GI_TAP_TO_PLAY_COLOR [UIColor whiteColor]
#define GI_TAP_TO_PLAY_FONT [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20.f];
#define GI_TAP_TO_PLAY_SHADOW_COLOR [UIColor colorWithWhite:0.4f alpha:1.f];
#define GI_TAP_TO_PLAY_SHADOW_OFFSET CGSizeMake(0.f, -1.f);

#pragma mark - Font Color

#define GI_FONT_MAIN_COLOR [UIColor colorWithWhite:0.65f alpha:1.f]

#pragma mark - Input View

#define GI_INPUT_VIEW_HEIGHT 150.f

#pragma mark - Keypad

#define GI_KEYPAD_HEIGHT 88.f
#define GI_KEYPAD_NO_ROWS 2
#define GI_KEYPAD_NO_COLUMNS 7
#define GI_KEYPAD_PADDING 2.f
#define GI_KEYPAD_ACTION_WIDTH 50.f

#pragma mark - Letters

#define GI_LETTER_COLOR GI_BACKGROUND_MAIN_COLOR
#define GI_LETTER_SHADOW_COLOR [UIColor colorWithWhite:0.38f alpha:1.f]
#define GI_LETTER_TEXT_COLOR [UIColor colorWithWhite:0.88f alpha:1.f]
#define GI_LETTER_ZOOMED_SCALE 1.15f
#define GI_LETTER_MINIMIZED_SCALE 0.3f
#define GI_LETTER_ZOOMED_COLOR [UIColor colorWithWhite:0.25 alpha:1.f]
#define GI_LETTER_ZOOMED_TEXT_COLOR [UIColor colorWithWhite:0.95 alpha:1.f]

#pragma mark - Action

#define GI_ACTION_COLOR GI_BACKGROUND_MAIN_COLOR
#define GI_ACTION_TEXT_COLOR [UIColor colorWithWhite:0.8f alpha:1.f]
#define GI_ACTION_SHADOW_COLOR [UIColor blackColor]
#define GI_ACTION_SELECTED_TEXT_COLOR [UIColor whiteColor]
#define GI_ACTION_SHINE_COLOR GI_TITLE_COLOR

#pragma mark - Answer Letter Placeholder

#define GI_ANSWER_PLACEHOLDER_COLOR [UIColor colorWithWhite:0.2 alpha:1.f]
#define GI_ANSWER_PLACEHOLDER_MAX_WIDTH 40.f
#define GI_ANSWER_PLACEHOLDER_MAX_HEIGHT 45.f
#define GI_ANSWER_PLACEHOLDER_PADDING 2.f
#define GI_ANSWER_PLACEHOLDER_SPACE_WIDTH 8.f
