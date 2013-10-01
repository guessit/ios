//
//  NSObject+Analytics.h
//  GuessIt
//
//  Created by Marlon Andrade on 01/10/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

@interface NSObject (Analytics)

@property (nonatomic, strong, readonly) id<GAITracker> tracker;

- (void)trackViewWithName:(NSString *)name;
- (void)trackEventWithCategory:(NSString *)category
                        action:(NSString *)action
                         label:(NSString *)label
                         value:(NSNumber *)value;
- (void)trackSocialInteractionWithNetwork:(NSString *)network
                                   action:(NSString *)action
                                   target:(NSString *)target;
- (void)trackTransactionWithId:(NSString *)transactionId
                   affiliation:(NSString *)affiliation
                       revenue:(NSNumber *)revenue
                           tax:(NSNumber *)tax
                      shipping:(NSNumber *)shipping
                  currencyCode:(NSString *)currencyCode;
@end
