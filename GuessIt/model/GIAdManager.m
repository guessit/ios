//
//  GIAdManager.m
//  GuessIt
//
//  Created by Marlon Andrade on 08/05/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIAdManager.h"

#import "GADInterstitial.h"

#define GI_AD_MOB_INTERSTITIAL_ID @"a151feb890436f7"

@interface GIAdManager ()

@property (nonatomic, strong) GADInterstitial *adMobInterstitial;

- (void)_initialize;

@end

@implementation GIAdManager

#pragma mark - Getter

- (BOOL)hasAdToShow {
    return YES;
}

- (GADInterstitial *)adMobInterstitial {
    if (!_adMobInterstitial) {
        _adMobInterstitial = [[GADInterstitial alloc] init];
        _adMobInterstitial.adUnitID = GI_AD_MOB_INTERSTITIAL_ID;

        GADRequest *request = [GADRequest request];
        request.testDevices = @[GAD_SIMULATOR_ID];
        request.testing = YES;

        [_adMobInterstitial loadRequest:request];

    }
    return _adMobInterstitial;
}

#pragma mark - NSObject Methods

- (id)init {
    self = [super init];
    if (self) {
        [self _initialize];
    }
    return self;
}

#pragma mark - Public Methods

+ (GIAdManager *)sharedInstance {
    static GIAdManager *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[GIAdManager alloc] init];
    });
    return __sharedInstance;
}

- (void)presentAdFromViewController:(UIViewController *)viewController {
    if (self.adMobInterstitial.isReady) {
        [self.adMobInterstitial presentFromRootViewController:viewController];
        self.adMobInterstitial = nil;
        #warning TODO: recarregar  nova interstitial
    }
}

#pragma mark - Private Interface

- (void)_initialize {
    NSLog(@"AdMob: %@", self.adMobInterstitial);
}

@end
