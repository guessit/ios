//
//  GIIAPManager.m
//  GuessIt
//
//  Created by Marlon Andrade on 29/09/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIIAPManager.h"

#import "GIConfiguration.h"
#import "GIDefinitions.h"
#import "NSObject+Analytics.h"

@interface GIIAPManager () <SKProductsRequestDelegate>

@property (nonatomic, strong) NSSet *donationProductsIds;
@property (nonatomic, strong) NSSet *bundleProductsIds;

@property (nonatomic, copy) GIIAPFetchProducts donationFetchCallback;
@property (nonatomic, copy) GIIAPFetchProducts bundleFetchCallback;

@property (nonatomic, strong) SKRequest *donationRequest;
@property (nonatomic, strong) SKRequest *bundleRequest;

- (NSString *)_bundleFromProduct:(NSString *)productId;
- (void)_productPurchased:(NSString *)productId;
- (void)_productPurchaseFailed:(NSString *)productId;
- (void)_trackTransaction:(SKPaymentTransaction *)transaction;
- (GIIAPFetchProducts)_callbackForRequest:(SKRequest *)request;

@end

@implementation GIIAPManager

#pragma mark - Getter

- (NSSet *)donationProductsIds {
    if (!_donationProductsIds) {
        NSString *bundleId = [NSBundle mainBundle].bundleIdentifier.lowercaseString;
        bundleId = [bundleId stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
        NSMutableSet *identifiers = [NSMutableSet set];
        for (NSString *product in GI_IAP) {
            NSString *productId = [NSString stringWithFormat:@"%@.%@", bundleId, product];
            [identifiers addObject:productId];
        }

        _donationProductsIds = identifiers;
    }
    return _donationProductsIds;
}

#pragma mark - Public Methods

+ (GIIAPManager *)sharedInstance {
    static GIIAPManager *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[GIIAPManager alloc] init];
    });
    return __sharedInstance;
}

- (void)fetchDonationProductsWithBlock:(GIIAPFetchProducts)callback {
    self.donationFetchCallback = callback;

    self.donationRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:self.donationProductsIds];
    self.donationRequest.delegate = self;
    [self.donationRequest start];
}

- (void)fetchBundleProductsWithBlock:(GIIAPFetchProducts)callback {
    self.bundleFetchCallback = callback;

    NSSet *bundleIds = [NSSet setWithArray:[GIConfiguration sharedInstance].game.bundles];
    self.bundleRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:bundleIds];
    self.bundleRequest.delegate = self;
    [self.bundleRequest start];
}

- (void)purchaseProduct:(SKProduct *)product {
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma mark - Private Methods

- (NSString *)_bundleFromProduct:(NSString *)productId {
    NSString *bundle = nil;

    NSRange lastDot = [productId rangeOfString:@"." options:NSBackwardsSearch];
    if (lastDot.location != NSNotFound) {
        bundle = [productId substringFromIndex:lastDot.location + 1];
    }

    return bundle;
}

- (void)_productPurchased:(NSString *)productId {
    GIConfiguration *conf = [GIConfiguration sharedInstance];
    conf.showAds = NO;

    NSString *bundle = [self _bundleFromProduct:productId];
    if ([conf.game.bundles containsObject:bundle]) {
        [conf markBundleBought:bundle];
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:GIIAPManagerProductPurchasedNotification
                                                        object:productId];
}

- (void)_productPurchaseFailed:(NSString *)productId {
   [[NSNotificationCenter defaultCenter] postNotificationName:GIIAPManagerProductPurchaseFailedNotification
                                                       object:productId];
}

- (void)_trackTransaction:(SKPaymentTransaction *)transaction {
    SKProduct *purchasedProduct = nil;
    for (SKProduct *product in [GIConfiguration sharedInstance].allProducts) {
        if ([product.productIdentifier isEqualToString:transaction.payment.productIdentifier]) {
            purchasedProduct = product;
            break;
        }
    }

    [self trackTransactionWithId:transaction.transactionIdentifier
                     affiliation:@"Apple IAP"
                         revenue:purchasedProduct.price
                             tax:@(0)
                        shipping:@(0)
                    currencyCode:nil];
}

- (GIIAPFetchProducts)_callbackForRequest:(SKRequest *)request {
    GIIAPFetchProducts callback = self.donationFetchCallback;
    if (request == self.bundleRequest) {
        callback = self.bundleFetchCallback;
    }
    return callback;
}

#pragma mark - SKPaymentTransactionObserver Methods

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self _productPurchased:transaction.payment.productIdentifier];
                [self _trackTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self _productPurchased:transaction.originalTransaction.payment.productIdentifier];
                break;
            case SKPaymentTransactionStateFailed:
                [self _productPurchaseFailed:transaction.payment.productIdentifier];
            default:
                break;
        }

        if (transaction.transactionState != SKPaymentTransactionStatePurchasing) {
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        }
    }
}

#pragma mark - SKProductsRequestDelegate Methods

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *productsByPrice = [response.products sortedArrayUsingComparator:^NSComparisonResult(SKProduct *p1, SKProduct *p2) {
        return [p1.price compare:p2.price];
    }];

    GIIAPFetchProducts callback = [self _callbackForRequest:request];
    callback(productsByPrice);
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    GIIAPFetchProducts callback = [self _callbackForRequest:request];
    callback(nil);
}

@end
