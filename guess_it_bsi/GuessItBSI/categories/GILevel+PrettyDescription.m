//
//  GILevel+PrettyDescription.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 04/15/2013.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevel+PrettyDescription.h"

#import "GIItem.h"
#import "GIItem+PrettyDescription.h"

@implementation GILevel (PrettyDescription)

- (NSString *)prettyDescription {
    NSMutableArray *itemsDescription = [NSMutableArray arrayWithCapacity:self.items.count];
    [self.items enumerateObjectsUsingBlock:^(GIItem *item, NSUInteger idx, BOOL *stop) {
        [itemsDescription addObject:item.prettyDescription];
    }];

    NSMutableArray *finished = [NSMutableArray arrayWithCapacity:self.finishedItems.count];
    [self.finishedItems enumerateObjectsUsingBlock:^(GIItem *item, NSUInteger idx, BOOL *stop) {
        [finished addObject:item.prettyDescription];
    }];

    NSMutableArray *todo = [NSMutableArray arrayWithCapacity:self.todoItems.count];
    [self.todoItems enumerateObjectsUsingBlock:^(GIItem *item, NSUInteger idx, BOOL *stop) {
        [todo addObject:item.prettyDescription];
    }];

    return [NSString stringWithFormat:@"Level: %@ <name: %@, items: [%@], finished: [%@], todo: [%@]>",
            self, self.name, itemsDescription, finished, todo];
}

@end
