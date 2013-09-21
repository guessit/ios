//
//  GIGameOverView.m
//  GuessIt
//
//  Created by Marlon Andrade on 05/09/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIGameOverView.h"

#import "GIGameOverCongratulationsView.h"
#import "GIGameOverCreditsView.h"
#import "GIGameOverOtherGamesView.h"
#import "MALazykit.h"
#import "UIView+CBFrameHelpers.h"

@interface GIGameOverView ()

@property (nonatomic, strong) GIGameOverCongratulationsView *congratulationsView;
@property (nonatomic, strong) GIGameOverCreditsView *creditsView;
@property (nonatomic, strong) GIGameOverOtherGamesView *otherGamesView;

- (void)_initialize;

@end

@implementation GIGameOverView

#pragma mark - Getter

- (GIGameOverCongratulationsView *)congratulationsView {
    if (!_congratulationsView) {
        CGRect frame = CGRectMake(0.f, 0.f, self.width, 300.f);
        _congratulationsView = [GIGameOverCongratulationsView viewWithFrame:frame];
        _congratulationsView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return _congratulationsView;
}

- (GIGameOverCreditsView *)creditsView {
    if (!_creditsView) {
        CGRect frame = CGRectMake(0.f, self.congratulationsView.maxY, self.width, 400.f);
        _creditsView = [GIGameOverCreditsView viewWithFrame:frame];
        _creditsView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return _creditsView;
}

- (GIGameOverOtherGamesView *)otherGamesView {
    if (!_otherGamesView) {
        CGRect frame = CGRectMake(0.f, self.creditsView.maxY, self.width, 400.f);
        _otherGamesView = [GIGameOverOtherGamesView viewWithFrame:frame];
        _otherGamesView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
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
    CGFloat height = (self.congratulationsView.height +
                      self.creditsView.height +
                      self.otherGamesView.height);
    self.contentSize = CGSizeMake(self.width, height);

    [self addSubview:self.congratulationsView];
    [self addSubview:self.creditsView];
    [self addSubview:self.otherGamesView];
}

@end
