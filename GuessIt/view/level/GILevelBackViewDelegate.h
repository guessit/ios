//
//  GILevelBackViewDelegate.h
//  GuessIt
//
//  Created by Marlon Andrade on 13/10/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GILevelBackView;

@protocol GILevelBackViewDelegate <NSObject>

- (void)levelBackViewDidClose:(GILevelBackView *)levelBackView;
- (void)levelBackViewFinished:(GILevelBackView *)levelBackView;

@end
