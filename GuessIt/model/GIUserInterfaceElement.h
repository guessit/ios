//
//  GIUserInterfaceElement.h
//  GuessIt
//
//  Created by Marlon Andrade on 23/07/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GIUserInterfaceElement : NSObject

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *shadowColor;

@property (nonatomic, strong) UIColor *secondaryBackgroundColor;
@property (nonatomic, strong) UIColor *secondaryColor;
@property (nonatomic, strong) UIColor *secondaryTextColor;
@property (nonatomic, strong) UIColor *secondaryShadowColor;

@end
