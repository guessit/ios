//
//  GIGameOverView.m
//  GuessIt
//
//  Created by Marlon Andrade on 05/09/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIGameOverView.h"
#import "MALazykit.h"
#import "UIView+CBFrameHelpers.h"

@interface GIGameOverView ()

@property (nonatomic, strong) UIView *congratulationsView;
@property (nonatomic, strong) UIView *creditsView;
@property (nonatomic, strong) UIView *otherGamesView;

- (void)_initialize;

@end

@implementation GIGameOverView

#pragma mark - Getter

- (UIView *)congratulationsView {
    if (!_congratulationsView) {
        _congratulationsView = [UIView viewWithFrame:CGRectMake(0.f, 0.f, 320.f, 400.f)];
        _congratulationsView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _congratulationsView.backgroundColor = [UIColor magentaColor];
    }
    return _congratulationsView;
}

- (UIView *)creditsView {
    if (!_creditsView) {
        _creditsView = [UIView viewWithFrame:CGRectMake(0.f, 400.f, 320.f, 400.f)];
        _creditsView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _creditsView.backgroundColor = [UIColor redColor];
    }
    return _creditsView;
}

- (UIView *)otherGamesView {
    if (!_otherGamesView) {
        _otherGamesView = [UIView viewWithFrame:CGRectMake(0.f, 800.f, 320.f, 400.f)];
        _otherGamesView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _otherGamesView.backgroundColor = [UIColor brownColor];
    }
    return _otherGamesView;
}

#pragma mark - UIView Methods

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}

#pragma mark - Private Interface

- (void)_initialize {
    self.contentSize = CGSizeMake(320.f, 1200.f);

    [self addSubview:self.congratulationsView];
    [self addSubview:self.creditsView];
    [self addSubview:self.otherGamesView];
}

@end
