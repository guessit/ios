//
//  GILetterView.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GILetterView : UIView

@property (nonatomic, strong) NSString *letter;

- (void)reset;

- (void)zoomIn;
- (void)zoomOut;

- (void)minimize;
- (void)restore;

@end
