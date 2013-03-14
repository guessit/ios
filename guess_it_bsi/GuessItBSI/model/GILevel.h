//
//  GILevel.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 13/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GILevel : NSObject

@property (nonatomic, copy) NSString *name;

+ (instancetype)levelWithName:(NSString *)name;
- (id)initWithName:(NSString *)name;

@end
