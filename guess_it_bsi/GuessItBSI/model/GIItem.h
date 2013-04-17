//
//  GIItem.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 30/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GIItemGuessingResultWrong,
    GIItemGuessingResultCorrect
} GIItemGuessingResult;

@interface GIItem : NSObject

@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *answer;
@property (nonatomic, strong) NSArray *hints;

+ (NSArray *)finishedItems;
+ (instancetype)itemWithImageNamed:(NSString *)imageName
                            anwser:(NSString *)answer
                             hints:(NSArray *)hints;

- (GIItemGuessingResult)guessWithAnwser:(NSString *)guessingAnwser;
- (BOOL)isFinished;

@end
