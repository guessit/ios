//
//  GICategory.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 13/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GICategory : NSObject

@property (nonatomic, copy) NSString *name;

+ (instancetype)categoryWithName:(NSString *)name;
- (id)initWithName:(NSString *)name;

@end