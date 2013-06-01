//
//  GIDataSource.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 01/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GIDataSource : NSObject

@property (nonatomic, strong, readonly) NSArray *levels;

+ (instancetype)dataSource;

@end
