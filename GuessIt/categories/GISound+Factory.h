//
//  GISound+Factory.h
//  GuessIt
//
//  Created by Marlon Andrade on 16/07/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GISound.h"

@interface GISound (Factory)

+ (GISound *)soundWithDictionary:(NSDictionary *)dictionary;

@end
