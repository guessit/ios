//
//  GIUserInterface+Factory.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 14/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIUserInterface+Factory.h"

#import <SSToolkit/SSCategories.h>

@implementation GIUserInterface (Factory)

+ (GIUserInterface *)userInterfaceWithDictionary:(NSDictionary *)dictionary {
    GIUserInterface *ui = [[GIUserInterface alloc] init];

    ui.backgroundColor = [UIColor colorWithHex:dictionary[@"background_color"]];
    ui.navigationBackgroundColor = [UIColor colorWithHex:dictionary[@"navigation_background_color"]];
    ui.titleColor = [UIColor colorWithHex:dictionary[@"title_color"]];
    ui.titleShadowColor = [UIColor colorWithHex:dictionary[@"title_shadow_color"]];
    ui.titleShineColor = [UIColor colorWithHex:dictionary[@"title_shine_color"]];
    ui.subtitleColor = [UIColor colorWithHex:dictionary[@"subtitle_color"]];
    ui.subtitleShadowColor = [UIColor colorWithHex:dictionary[@"subtitle_shadow_color"]];
    ui.congratulationColor = [UIColor colorWithHex:dictionary[@"congratulation_color"]];
    ui.congratulationShadowColor = [UIColor colorWithHex:dictionary[@"congratulation_shadow_color"]];
    ui.congratulationShineColor = [UIColor colorWithHex:dictionary[@"congratulation_shine_color"]];
    ui.answerBackgroundColor = [UIColor colorWithHex:dictionary[@"answer_background_color"]];
    ui.placeholderBackgroundColor = [UIColor colorWithHex:dictionary[@"placeholder_background_color"]];
    ui.categoryBackgroundColor = [UIColor colorWithHex:dictionary[@"category_background_color"]];
    ui.categoryTextColor = [UIColor colorWithHex:dictionary[@"category_text_color"]];
    ui.categoryShadowColor = [UIColor colorWithHex:dictionary[@"category_shadow_color"]];
    ui.imageBackgroundColor = [UIColor colorWithHex:dictionary[@"image_background_color"]];
    ui.frameColor = [UIColor colorWithHex:dictionary[@"frame_color"]];
    ui.keypadBackgroundColor = [UIColor colorWithHex:dictionary[@"keypad_background_color"]];
    ui.letterBackgroundColor = [UIColor colorWithHex:dictionary[@"letter_background_color"]];
    ui.letterTextColor = [UIColor colorWithHex:dictionary[@"letter_text_color"]];
    ui.letterShadowColor = [UIColor colorWithHex:dictionary[@"letter_shadow_color"]];
    ui.letterSelectedColor = [UIColor colorWithHex:dictionary[@"letter_selected_color"]];
    ui.letterSelectedTextColor = [UIColor colorWithHex:dictionary[@"letter_selected_text_color"]];
    ui.actionBackgroundColor = [UIColor colorWithHex:dictionary[@"action_background_color"]];
    ui.actionTextColor = [UIColor colorWithHex:dictionary[@"action_text_color"]];
    ui.actionShadowColor = [UIColor colorWithHex:dictionary[@"action_shadow_color"]];
    ui.actionSelectedColor = [UIColor colorWithHex:dictionary[@"action_selected_color"]];
    ui.actionSelectedTextColor = [UIColor colorWithHex:dictionary[@"action_selected_text_color"]];

    return ui;
}

@end
