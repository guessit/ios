//
//  NSString+Search.m
//  GuessIt
//
//  Created by Marlon Andrade on 31/08/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "NSString+Search.h"

@implementation NSString (Search)

- (NSInteger)numberOfOccurrencesOfString:(NSString *)string {
    return [self componentsSeparatedByString:string].count - 1;
}

@end
