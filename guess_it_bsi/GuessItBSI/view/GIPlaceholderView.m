//
//  GIPlaceholderView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIPlaceholderView.h"

#import <QuartzCore/QuartzCore.h>

@interface GIPlaceholderView ()

- (void)_initialize;

@end

@implementation GIPlaceholderView

#pragma mark - UIView Methods

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initialize];
    }
    return self;
}

#pragma mark - Private Interface

- (void)_initialize {
    self.backgroundColor = GI_ANSWER_PLACEHOLDER_COLOR;
    self.layer.cornerRadius = 3.f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1.f, 1.f);
    self.layer.shadowOpacity = 0.05f;
}

@end
