//
//  UIImage+FromColor.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 28/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "UIImage+FromColor.h"

@implementation UIImage (FromColor)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect pixelRect = CGRectMake(0.f, 0.f, 1.f, 1.f);

    UIGraphicsBeginImageContext(pixelRect.size);

    [color setFill];
    UIRectFill(pixelRect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;
}

@end
