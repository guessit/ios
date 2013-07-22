//
//  GIHelpView.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 11/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIHelpView.h"

@interface GIHelpView ()

- (void)_initialize;

@end

@implementation GIHelpView

#pragma mark - UIView Methods

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}

#pragma mark - Private Interface

- (void)_initialize {
    self.backgroundColor = [UIColor magentaColor];
}


@end
