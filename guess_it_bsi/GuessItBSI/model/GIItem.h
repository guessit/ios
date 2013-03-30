//
//  GIItem.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 30/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GIItem : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *answer;
@property (nonatomic, strong) NSArray *hints;

@end
