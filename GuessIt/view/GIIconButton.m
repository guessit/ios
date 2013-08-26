//
//  GIIconButton.m
//  GuessIt
//
//  Created by Marlon Andrade on 08/21/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIIconButton.h"

#import "MALazykit.h"
#import "UIView+CBFrameHelpers.h"
#import "UIFont+FontAwesome.h"

@interface GIIconButton ()

@property (nonatomic, strong) FAImageView *imageButton;

- (void)_initialize;

@end

@implementation GIIconButton

#pragma mark - Getter

- (FAImageView *)imageButton {
    if (!_imageButton) {
        _imageButton = [FAImageView view];
        _imageButton.image = nil;
    }
    return _imageButton;
}

- (FAIcon)icon {
    return self.imageButton.defaultIcon;
}

#pragma mark - Setter

- (void)setIcon:(FAIcon)icon {
    self.imageButton.defaultIcon = icon;
}

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
    [self addSubview:self.imageButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.imageButton.frame = CGRectMake(10.f, 10.f, self.height - 20.f, self.height - 20.f);
    self.imageButton.defaultView.font = [UIFont iconicFontOfSize:self.imageButton.bounds.size.height];
    self.imageButton.defaultView.textColor = [UIColor whiteColor];
    self.imageButton.defaultView.backgroundColor = self.backgroundColor;
    self.imageButton.defaultView.shadowColor = [UIColor colorWithWhite:0.6f alpha:1.f];
    self.imageButton.defaultView.shadowOffset = CGSizeMake(0.f, -1.f);
}

@end
