//
//  NSString+RandomString.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/24/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RandomString)

+ (NSString *)randomVowel;
+ (NSString *)randomConsonant;
- (NSString *)randomCharacter;

@end
