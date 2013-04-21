//
//  GIItemViewController.h
//  GuessItBSI
//
//  Created by Marlon Andrade on 30/03/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIViewController.h"

#import "GILevel.h"

@interface GIItemViewController : GIViewController

@property (nonatomic, strong) GILevel *level;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
