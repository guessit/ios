//
//  GIItem.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 30/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIItem.h"

@interface GIItem()

- (id)initWithImageNamed:(NSString *)imageName
                  answer:(NSString *)answer
                   hints:(NSArray *)hints;

@end

@implementation GIItem

#pragma mark - Public Interface

+ (instancetype)itemWithImageNamed:(NSString *)imageName
                            anwser:(NSString *)answer
                             hints:(NSArray *)hints {
    return [[self alloc] initWithImageNamed:imageName
                                     answer:answer
                                      hints:hints];
}

#pragma mark - Private Interface

- (id)initWithImageNamed:(NSString *)imageName
                  answer:(NSString *)answer
                   hints:(NSArray *)hints {
    self = [super init];
    if (self) {
        self.imageName = imageName;
        self.answer = answer;
        self.hints = hints;
    }
    return self;
}

@end
