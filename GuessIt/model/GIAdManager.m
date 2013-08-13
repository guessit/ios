//
//  GIAdManager.m
//  GuessIt
//
//  Created by Marlon Andrade on 08/05/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIAdManager.h"

#import "GIConfiguration.h"
#import "GADInterstitial.h"

#define GI_AD_RETRY_DELAY 30

typedef enum {
    GIAdRequestStatusNotRequested = 0,
    GIAdRequestStatusLoading,
    GIAdRequestStatusFailed
} GIAdRequestStatus;

@interface GIAdManager () <GADInterstitialDelegate>

@property (nonatomic, strong) GADInterstitial *adMobInterstitial;
@property (nonatomic, assign) GIAdRequestStatus adMobRequestStatus;

- (void)_initialize;

- (GADInterstitial *)_adMobInterstitial;
- (GADRequest *)_adMobRequest;
- (void)_loadAdMobRequest;

@end

@implementation GIAdManager

#pragma mark - Getter

- (GADInterstitial *)adMobInterstitial {
    if (!_adMobInterstitial) {
        _adMobInterstitial = [self _adMobInterstitial];
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

- (void)loadAds {
    if (!self.adMobInterstitial.isReady &&
        self.adMobRequestStatus != GIAdRequestStatusLoading) {
        [self _loadAdMobRequest];
    }
}

- (void)presentAdFromViewController:(UIViewController *)viewController {
    if (self.adMobInterstitial.isReady) {
        [self.adMobInterstitial presentFromRootViewController:viewController];
    }
}

#pragma mark - Private Interface

- (void)_initialize {
    self.adMobInterstitial = [self _adMobInterstitial];
    [self loadAds];
}

- (GADInterstitial *)_adMobInterstitial {
    self.adMobRequestStatus = GIAdRequestStatusNotRequested;

    GADInterstitial *interstitial = [[GADInterstitial alloc] init];
    interstitial.adUnitID = [GIConfiguration sharedInstance].game.adMediationId;
    interstitial.delegate = self;

    return interstitial;
}

- (GADRequest *)_adMobRequest {
    GADRequest *request = [GADRequest request];
    request.testDevices = @[GAD_SIMULATOR_ID];
    request.testing = YES;

    return request;
}

- (void)_loadAdMobRequest {
    NSLog(@"Loading AdMob Request");
    GADRequest *request = [self _adMobRequest];
    [self.adMobInterstitial loadRequest:request];
    self.adMobRequestStatus = GIAdRequestStatusLoading;
}

#pragma mark - GADInterstitialDelegate Methods

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"AdMob didFailToReceiveAdWithError: %@", error);
    self.adMobRequestStatus = GIAdRequestStatusFailed;
    [self performSelector:@selector(_loadAdMobRequest) withObject:nil afterDelay:GI_AD_RETRY_DELAY];
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    self.adMobInterstitial = [self _adMobInterstitial];
    [self _loadAdMobRequest];
}

@end
