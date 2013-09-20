//
//  GIGameOverCreditsView.m
//  GuessIt
//
//  Created by Marlon Andrade on 16/09/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIGameOverCreditsView.h"

#import "GIConfiguration.h"
#import "GIUserInterfaceElement.h"

@interface GIGameOverCreditsView ()

@property (nonatomic, strong, readonly) GIUserInterfaceElement *ui;

@end

@implementation GIGameOverCreditsView

#pragma mark - Getter

- (GIUserInterfaceElement *)ui {
    return [GIConfiguration sharedInstance].game.interface.credits;
}

@end
