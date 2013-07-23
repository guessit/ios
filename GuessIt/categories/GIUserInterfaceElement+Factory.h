//
//  GIUserInterfaceElement+Factory.h
//  GuessIt
//
//  Created by Marlon Andrade on 23/07/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIUserInterfaceElement.h"

@interface GIUserInterfaceElement (Factory)

+ (GIUserInterfaceElement *)elementWithDictionary:(NSDictionary *)dictionary;

@end
