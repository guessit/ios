//
//  GIUserInterfaceElement+Factory.m
//  GuessIt
//
//  Created by Marlon Andrade on 23/07/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIUserInterfaceElement+Factory.h"

#import <SSToolkit/SSCategories.h>

@implementation GIUserInterfaceElement (Factory)

+ (GIUserInterfaceElement *)elementWithDictionary:(NSDictionary *)dictionary {
    static NSArray *__properties = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __properties = @[
            @"background_color",
            @"color",
            @"text_color",
            @"shadow_color",
            @"secondary_color",
            @"secondary_background_color",
            @"secondary_text_color",
            @"secondary_shadow_color",
        ];
    });

    GIUserInterfaceElement *element = [[GIUserInterfaceElement alloc] init];
    [__properties enumerateObjectsUsingBlock:^(NSString *property, NSUInteger idx, BOOL *stop) {
        NSString *camel = [[property capitalizedString] stringByReplacingOccurrencesOfString:@"_"
                                                                                  withString:@""];
        SEL setter = NSSelectorFromString([NSString stringWithFormat:@"set%@:", camel]);
        UIColor *color = [UIColor colorWithHex:dictionary[property]];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [element performSelector:setter withObject:color];
#pragma clang diagnostic pop
    }];

    return element;
}

@end
