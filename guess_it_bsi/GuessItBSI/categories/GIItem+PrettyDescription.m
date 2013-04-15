//
//  GIItem+PrettyDescription.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/15/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIItem+PrettyDescription.h"

@implementation GIItem (PrettyDescription)

- (NSString *)prettyDescription {
    return [NSString stringWithFormat:@"Item: %@ <imageNamed:%@ answer:%@ hints:%@>",
            self, self.imageName, self.answer, self.hints];
}

@end
