//
//  NSObject+Analytics.m
//  GuessIt
//
//  Created by Marlon Andrade on 01/10/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "NSObject+Analytics.h"

@implementation NSObject (Analytics)

- (id<GAITracker>)tracker {
    return [[GAI sharedInstance] defaultTracker];
}

- (void)trackViewWithName:(NSString *)name {
    [self.tracker set:kGAIScreenName value:name];
    [self.tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (void)trackEventWithCategory:(NSString *)category
                        action:(NSString *)action
                         label:(NSString *)label
                         value:(NSNumber *)value {
    [self.tracker send:[[GAIDictionaryBuilder createEventWithCategory:category
                                                               action:action
                                                                label:label
                                                                value:value] build]];
}

- (void)trackSocialInteractionWithNetwork:(NSString *)network
                                   action:(NSString *)action
                                   target:(NSString *)target {
    [self.tracker send:[[GAIDictionaryBuilder createSocialWithNetwork:network
                                                               action:action
                                                               target:target] build]];
}

- (void)trackTransactionWithId:(NSString *)transactionId
                   affiliation:(NSString *)affiliation
                       revenue:(NSNumber *)revenue
                           tax:(NSNumber *)tax
                      shipping:(NSNumber *)shipping
                  currencyCode:(NSString *)currencyCode {
    [self.tracker send:[[GAIDictionaryBuilder createTransactionWithId:transactionId
                                                          affiliation:affiliation
                                                              revenue:revenue
                                                                  tax:tax
                                                             shipping:shipping
                                                         currencyCode:currencyCode] build]];
}

@end
