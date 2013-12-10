//
//  GIIAPManager.h
//  GuessIt
//
//  Created by Marlon Andrade on 29/09/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

typedef void (^GIIAPFetchProducts)(NSArray *products);

@interface GIIAPManager : NSObject <SKPaymentTransactionObserver>

+ (GIIAPManager *)sharedInstance;
- (void)fetchDonationProductsWithBlock:(GIIAPFetchProducts)callback;
- (void)fetchBundleProductsWithBlock:(GIIAPFetchProducts)callback;
- (void)purchaseProduct:(SKProduct *)product;

@end
