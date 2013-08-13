//
//  GIGame.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 02/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIUserInterface.h"
#import "GISound.h"

@interface GIGame : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDictionary *options;
@property (nonatomic, strong) GIUserInterface *interface;
@property (nonatomic, strong) GISound *sound;
@property (nonatomic, strong) NSArray *levels;
@property (nonatomic, strong) NSString *adMediationId;

@property (nonatomic, strong, readonly) NSArray *todoLevels;
@property (nonatomic, strong, readonly) NSArray *finishedLevels;


@end
