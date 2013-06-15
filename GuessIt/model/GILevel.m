//
//  GILevel.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 30/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevel.h"

#import "GIConfiguration.h"
#import "GIDefinitions.h"

@interface GILevel()

@property (nonatomic, strong, readwrite) UIImage *image;

- (id)initWithImageNamed:(NSString *)imageName
                  answer:(NSString *)answer
                category:(NSString *)category
                   hints:(NSArray *)hints;
- (void)_markFinished;

@end

@implementation GILevel

#pragma mark - Getter

- (UIImage *)image {
    if (!_image) {
        _image = [UIImage imageNamed:self.imageName];
    }
    return _image;
}

#pragma mark - Public Interface

+ (instancetype)levelWithImageNamed:(NSString *)imageName
                             anwser:(NSString *)answer
                           category:(NSString *)category
                              hints:(NSArray *)hints {
    return [[self alloc] initWithImageNamed:imageName
                                     answer:answer
                                   category:category
                                      hints:hints];
}

- (GIGuessingResult)guessWithAnwser:(NSString *)guessingAnwser {
    GIGuessingResult guessingResult = GIGuessingResultWrong;

    BOOL isCorrect = [guessingAnwser compare:self.answer options:NSCaseInsensitiveSearch] == NSOrderedSame;
    if (isCorrect) {
        guessingResult = GIGuessingResultCorrect;
        [self _markFinished];
    }

    return guessingResult;
}

- (BOOL)isFinished {
    return [[GIConfiguration sharedInstance].finishedLevelsName containsObject:self.imageName];
}

#pragma mark - Private Interface

- (id)initWithImageNamed:(NSString *)imageName
                  answer:(NSString *)answer
                category:(NSString *)category
                   hints:(NSArray *)hints {
    self = [super init];
    if (self) {
        self.imageName = imageName;
        self.answer = answer;
        self.category = category;
        self.hints = hints;
    }
    return self;
}

- (void)_markFinished {
    NSArray *finishedLevels = [GIConfiguration sharedInstance].finishedLevelsName;
    NSMutableArray *correctItems = [NSMutableArray arrayWithArray:finishedLevels];
    [correctItems addObject:self.imageName];

    [[NSUserDefaults standardUserDefaults] setObject:correctItems forKey:GI_FINISHED_LEVELS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
