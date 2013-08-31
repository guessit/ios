//
//  GILetterView.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GICompletionBlock)(BOOL finished);

@interface GILetterView : UIView

@property (nonatomic, strong) NSString *letter;
@property (nonatomic, assign) CGRect oldFrame;

- (void)reset;

- (void)zoomIn;
- (void)zoomInWithCompletion:(GICompletionBlock)completion;
- (void)zoomOut;
- (void)zoomOutWithCompletion:(GICompletionBlock)completion;

- (void)minimize;
- (void)minimizeWithCompletion:(GICompletionBlock)completion;
- (void)restore;
- (void)restoreWithCompletion:(GICompletionBlock)completion;

@end
