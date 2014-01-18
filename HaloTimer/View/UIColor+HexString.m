//
//  UIColor+HexString.m
//  HaloTimer
//
//  Created by Eric Muller on 1/17/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import "UIColor+HexString.h"

@implementation UIColor (HexString)

+ colorWithHexString:(NSString *)hexString
{
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor colorWithRGBHex:hexNum alpha:1.0];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:(alpha <= 1.0f && alpha >= 0.0f) ? alpha : 1.0f];
}

@end
