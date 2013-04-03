//
//  GILevel+Factory.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 02/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevel.h"

@interface GILevel (Factory)

+ (GILevel *)bancoDados;
+ (GILevel *)frameworks;
+ (GILevel *)ides;
+ (GILevel *)linguagensProgramacao;
+ (GILevel *)ferramentas;

@end
