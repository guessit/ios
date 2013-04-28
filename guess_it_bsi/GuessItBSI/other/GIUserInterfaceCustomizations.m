//
//  GIUserInterfaceCustomizations.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 26/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIUserInterfaceCustomizations.h"

#import "GIKeypadLetterView.h"
#import "UIFont+GuessItFonts.h"

@interface GIUserInterfaceCustomizations()

- (void)_customizeLetterViews;

@end

@implementation GIUserInterfaceCustomizations

#pragma mark - Public Interface

+ (instancetype)userInterfaceCustomizations {
    return [[self alloc] init];
}

- (void)customizeUserInterface {
    [self _customizeLetterViews];
}

#pragma mark - Private Interface

- (void)_customizeLetterViews {
    [[GIKeypadLetterView appearance] setBackgroundColor:GI_KEYPAD_LETTER_COLOR];
}

@end
