//
//  GILevel+Factory.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 02/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevel.h"

@interface GILevel (Factory)

+ (GILevel *)levelWithDictionary:(NSDictionary *)dictionary;

@end
