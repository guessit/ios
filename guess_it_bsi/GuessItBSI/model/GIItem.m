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
- (void)_markItemGuessedCorrectly;

@end

@implementation GIItem

#pragma mark - Public Interface

+ (NSArray *)finishedItems {
    return [[NSUserDefaults standardUserDefaults] arrayForKey:GI_FINISHED_ITEMS];
}

+ (instancetype)itemWithImageNamed:(NSString *)imageName
                            anwser:(NSString *)answer
                             hints:(NSArray *)hints {
    return [[self alloc] initWithImageNamed:imageName
                                     answer:answer
                                      hints:hints];
}

- (GIItemGuessingResult)guessWithAnwser:(NSString *)guessingAnwser {
    GIItemGuessingResult guessingResult = GIItemGuessingResultWrong;

    BOOL isCorrect = [guessingAnwser compare:self.answer options:NSCaseInsensitiveSearch] == NSOrderedSame;
    if (isCorrect) {
        guessingResult = GIItemGuessingResultCorrect;
        [self _markItemGuessedCorrectly];
    }

    return guessingResult;
}

- (BOOL)isFinished {
    return [[GIItem finishedItems] containsObject:self.imageName];
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

- (void)_markItemGuessedCorrectly {
    NSMutableArray *correctItems = [NSMutableArray arrayWithArray:[GIItem finishedItems]];
    [correctItems addObject:self.imageName];

    [[NSUserDefaults standardUserDefaults] setObject:correctItems forKey:GI_FINISHED_ITEMS];
}

@end
