//
//  GILevelBackView.m
//  GuessIt
//
//  Created by Marlon Andrade on 13/10/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevelBackView.h"

#import "GIConfiguration.h"
#import "GIIconButton.h"
#import "MALazykit.h"
#import "UIView+CBFrameHelpers.h"

@interface GILevelBackView ()

@property (nonatomic, strong) GIIconButton *closeButton;
@property (nonatomic, strong) UIImageView *imageView;

- (id)initWithDelegate:(id<GILevelBackViewDelegate>)delegate;
- (void)_initialize;
- (void)_closeTouched:(id)sender;
- (void)_backTapped:(UITapGestureRecognizer *)recognizer;

@end

@implementation GILevelBackView

#pragma mark - Getter

- (GIIconButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [GIIconButton buttonWithIcon:FAIconRemove];
        _closeButton.frame = CGRectMake(0.f, 0.f, 44.f, 44.f);
        [_closeButton addTarget:self
                         action:@selector(_closeTouched:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        NSString *imageName = NSLocalizedString(@"back_view", nil);
        _imageView = [UIImageView imageViewWithImageNamed:imageName];
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeCenter;

        UIGestureRecognizer *tapGesture = [UITapGestureRecognizer gestureRecognizerWithTarget:self
                                                                                       action:@selector(_backTapped:)];
        [_imageView addGestureRecognizer:tapGesture];
    }
    return _imageView;
}

#pragma mark - UIView Methods

- (id)initWithDelegate:(id<GILevelBackViewDelegate>)delegate {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.delegate = delegate;
        [self _initialize];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.imageView.frame = self.bounds;

    self.closeButton.x = self.width - self.closeButton.width + 10.f;
    self.closeButton.y = -10.f;
}

#pragma mark - Public Interface

+ (instancetype)levelBackViewWithDelegate:(id<GILevelBackViewDelegate>)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

#pragma mark - Private Interface

- (void)_initialize {
    GIUserInterface *interface = [GIConfiguration sharedInstance].game.interface;
    self.backgroundColor = interface.image.backgroundColor;

    [self addSubview:self.imageView];
    [self addSubview:self.closeButton];
}

- (void)_closeTouched:(id)sender {
    [self.delegate levelBackViewDidClose:self];
}

- (void)_backTapped:(UITapGestureRecognizer *)recognizer {
    NSURL *url = [NSURL URLWithString:self.currentLevel.url];
    [[UIApplication sharedApplication] openURL:url];
    [self.delegate levelBackViewFinished:self];
}

@end
