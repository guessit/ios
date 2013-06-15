//
//  GIGame+Factory.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 02/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIGame.h"

@interface GIGame (Factory)

+ (GIGame *)gameWithDictionary:(NSDictionary *)dictionary;

@end
