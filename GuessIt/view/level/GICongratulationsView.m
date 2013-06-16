//
//  GICongratulationsView.m
//  GuessIt
//
//  Created by Marlon Andrade on 16/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GICongratulationsView.h"

@interface GICongratulationsView ()

- (void)_initialize;

@end

@implementation GICongratulationsView

#pragma mark - UIView Methods

- (id)init {
    self = [super init];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}

#pragma mark - Private Methods

- (void)_initialize {
    self.backgroundColor = [UIColor magentaColor];
}

@end
