//
//  GILevel+PrettyDescription.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/15/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevel+PrettyDescription.h"

@implementation GILevel (PrettyDescription)

- (NSString *)prettyDescription {
    return [NSString stringWithFormat:@"Item: %@ <imageNamed:%@ answer:%@ category:%@ hints:%@>",
            self, self.imageName, self.answer, self.category, self.hints];
}

@end
