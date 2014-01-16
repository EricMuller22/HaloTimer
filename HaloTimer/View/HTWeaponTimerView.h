//
//  HTWeaponTimerView.h
//  HaloTimer
//
//  Created by Eric Muller on 1/15/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTWeaponTimerView : UIView

@property (nonatomic, assign) NSInteger weaponTiming;

+ (instancetype)timerViewForWeapon:(NSString *)weapon tintColor:(UIColor *)tintColor;

- (void)countdown;

@end
