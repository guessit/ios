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

@property (nonatomic, strong) NSSet *productsIds;
@property (nonatomic, copy) GIIAPFetchProducts fetchProductsCallback;

- (void)_productPurchased:(NSString *)productId;
- (void)_productPurchaseFailed:(NSString *)productId;
- (void)_trackTransaction:(SKPaymentTransaction *)transaction;

@end

@implementation GIIAPManager

#pragma mark - Getter

- (NSSet *)productsIds {
    if (!_productsIds) {
        NSString *bundleId = [NSBundle mainBundle].bundleIdentifier.lowercaseString;
        bundleId = [bundleId stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
        NSMutableSet *identifiers = [NSMutableSet set];
        for (NSString *product in GI_IAP) {
            NSString *productId = [NSString stringWithFormat:@"%@.%@", bundleId, product];
            [identifiers addObject:productId];
        }
        _productsIds = identifiers;
    }
    return _productsIds;
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

- (void)fetchProductsWithBlock:(GIIAPFetchProducts)callback {
    self.fetchProductsCallback = callback;
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:self.productsIds];
    request.delegate = self;
    [request start];
}

- (void)purchaseProduct:(SKProduct *)product {
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma mark - Private Methods

- (void)_productPurchased:(NSString *)productId {
    [GIConfiguration sharedInstance].showAds = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:GIIAPManagerProductPurchasedNotification
                                                        object:productId];
}

- (void)_productPurchaseFailed:(NSString *)productId {
   [[NSNotificationCenter defaultCenter] postNotificationName:GIIAPManagerProductPurchaseFailedNotification
                                                       object:productId];
}

- (void)_trackTransaction:(SKPaymentTransaction *)transaction {
    SKProduct *purchasedProduct = nil;
    for (SKProduct *product in [GIConfiguration sharedInstance].products) {
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

    self.fetchProductsCallback(productsByPrice);
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    self.fetchProductsCallback(nil);
}

@end
