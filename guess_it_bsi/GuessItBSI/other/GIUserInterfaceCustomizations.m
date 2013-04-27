//
//  GIUserInterfaceCustomizations.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 26/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIUserInterfaceCustomizations.h"

#import "UIFont+GuessItFonts.h"

@interface GIUserInterfaceCustomizations()

@end

@implementation GIUserInterfaceCustomizations

#pragma mark - Public Interface

+ (instancetype)userInterfaceCustomizations {
    return [[self alloc] init];
}

- (void)customizeUserInterface {
    #warning TODO: verificar se há necessidade dessa classe de customizacao através de UIAppearance
}

#pragma mark - Private Interface

@end
