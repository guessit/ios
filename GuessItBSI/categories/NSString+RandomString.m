//
//  NSString+RandomString.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/24/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "NSString+RandomString.h"

#define GI_VOWELS @"aeiou"
#define GI_CONSONANTS @"bcdfghjklmnpqrstvwxyz"

@implementation NSString (RandomString)

+ (NSString *)randomVowel {
    return GI_VOWELS.randomCharacter;
}

+ (NSString *)randomConsonant {
    return GI_CONSONANTS.randomCharacter;
}

- (NSString *)randomCharacter {
    return [self substringWithRange:NSMakeRange(arc4random_uniform(self.length), 1)];
}

@end
