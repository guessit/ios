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
    return [NSString stringWithFormat:@"Level: %@ <name: %@, items: %@, finished: %@, todo: %@>",
            self, self.name, self.items, self.finishedItems, self.todoItems];
}

@end
