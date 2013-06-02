//
//  GIConfiguration.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 01/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIConfiguration.h"

#import "GIGame.h"
#import "GIGame+Factory.h"
#import "GILevel.h"

@interface GIConfiguration ()

@property (nonatomic, strong) NSDictionary *gameData;

- (void)_initialize;

@end

@implementation GIConfiguration

#pragma mark - Getter

- (NSArray *)levels {
    return @[];
}

#pragma mark - NSObject Methods

- (id)init {
    self = [super init];
    if (self) {
        [self _initialize];
    }
    return self;
}

#pragma mark - Public Interface

+ (instancetype)sharedInstance {
    static GIConfiguration *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[GIConfiguration alloc] init];
    });
    return __sharedInstance;
}

- (NSArray *)finishedLevelsName {
    return [[NSUserDefaults standardUserDefaults] arrayForKey:GI_FINISHED_LEVELS];
}

#pragma mark - Private Interface

- (void)_initialize {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"game" ofType:@"json"];
    NSInputStream *jsonFileStream = [NSInputStream inputStreamWithFileAtPath:jsonPath];
    [jsonFileStream open];

    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithStream:jsonFileStream
                                                           options:0
                                                             error:&error];
    [jsonFileStream close];

    if (error) {
        NSLog(@"Error: %@", error);
        NSLog(@"%@", error.localizedDescription);
    }

    if (json) {
        self.game = [GIGame gameWithDictionary:json];
    }
}

#warning TODO: BROWSER - chrome, ie, firefox, safari, opera, etc
#warning TODO: SISTEMAS OPERACIONAIS - windows, ubuntu, osx, ios, android, etc
#warning TODO: MARCAS - apple, google, microsoft, hp, cisco, etc
#warning TODO: PERSONALIDADES - steve jobs, bill gates, etc

@end
