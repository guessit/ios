//
//  GILevel.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 30/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GIGuessingResultWrong,
    GIGuessingResultCorrect
} GIGuessingResult;

@interface GILevel : NSObject

@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *answer;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *url;

+ (instancetype)levelWithImageNamed:(NSString *)imageName
                             anwser:(NSString *)answer
                           category:(NSString *)category;
+ (instancetype)lastLevel;

- (GIGuessingResult)guessWithAnwser:(NSString *)guessingAnwser;
- (BOOL)isFinished;
- (BOOL)canFlip;

@end
