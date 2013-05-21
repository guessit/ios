//
//  GIAnswerView.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GIAnswerView : UIView

@property (nonatomic, copy) NSString *answer;

- (BOOL)canAddLetter;
- (void)addLetter:(NSString *)letter;

@end
