//
//  GILevel.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 26/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GILevel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *guessingItems;

+ (instancetype)levelWithName:(NSString *)name;
- (id)initWithName:(NSString *)name;

@end
