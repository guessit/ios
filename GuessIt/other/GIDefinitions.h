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

#define GI_CATEGORY_HEIGHT 28.f
#define GI_INPUT_HEIGHT 150.f

#define GI_ANSWER_PLACEHOLDER_MAX_WIDTH 40.f
#define GI_ANSWER_PLACEHOLDER_MAX_HEIGHT 45.f
#define GI_ANSWER_PLACEHOLDER_PADDING 2.f
#define GI_ANSWER_PLACEHOLDER_SPACE_WIDTH 6.f

#define GI_KEYPAD_HEIGHT 88.f
#define GI_KEYPAD_NO_ROWS 2
#define GI_KEYPAD_NO_COLUMNS 7
#define GI_KEYPAD_PADDING 2.f
#define GI_KEYPAD_ACTION_WIDTH 50.f

#define GI_LETTER_ZOOMED_SCALE 1.15f
#define GI_LETTER_MINIMIZED_SCALE 0.3f