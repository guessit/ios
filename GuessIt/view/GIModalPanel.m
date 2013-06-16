//
//  GIModalPanel.m
//  GuessIt
//
//  Created by Marlon Andrade on 16/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIModalPanel.h"

#import "MALazykit.h"

@interface GIModalPanel ()

- (void)_initialize;

@end

@implementation GIModalPanel

#pragma mark - Overriden Methods

- (UIButton *)closeButton {
    return nil;
}

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
    self.margin = UIEdgeInsetsZero;
    self.padding = UIEdgeInsetsZero;
    self.borderWidth = 0.f;
    self.contentColor = [UIColor colorWithWhite:0.f alpha:0.5f];
    self.shouldBounce = NO;
    self.gestureRecognizers = @[
        [UITapGestureRecognizer gestureRecognizerWithTarget:self
                                                     action:@selector(closePressed:)]
    ];
}

@end
