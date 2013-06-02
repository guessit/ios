//
//  GINavigationController.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 02/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GINavigationController.h"

#import "GINavigationBar.h"

@interface GINavigationController () {
    GINavigationBar *__navigationBar;
}

@end

@implementation GINavigationController

- (UINavigationBar *)navigationBar {
    if (!__navigationBar) {
        __navigationBar = [GINavigationBar view];
    }

    return __navigationBar;
}

@end
