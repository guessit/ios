//
//  GIDataSource.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 01/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIDataSource.h"

#import "GILevel.h"
#import "GILevel+Factory.h"

@interface GIDataSource ()

@property (nonatomic, strong, readwrite) NSArray *levels;

- (void)_initialize;

@end

@implementation GIDataSource

#pragma mark - NSObject Methods

- (id)init {
    self = [super init];
    if (self) {
        [self _initialize];
    }
    return self;
}

#pragma mark - Public Interface

+ (instancetype)dataSource {
    static GIDataSource *__dataSource;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __dataSource = [[GIDataSource alloc] init];
    });
    return __dataSource;
}

#pragma mark - Private Interface

- (void)_initialize {
    self.levels = @[
        [GILevel bancoDados],
        [GILevel frameworks],
        [GILevel ides],
        [GILevel linguagensProgramacao],
        [GILevel ferramentas]
    ];

    #warning TODO: BROWSER - chrome, ie, firefox, safari, opera, etc
    #warning TODO: SISTEMAS OPERACIONAIS - windows, ubuntu, osx, ios, android, etc
    #warning TODO: MARCAS - apple, google, microsoft, hp, cisco, etc
    #warning TODO: PERSONALIDADES - steve jobs, bill gates, etc
}

@end
