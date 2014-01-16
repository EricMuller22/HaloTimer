//
//  HTWeaponTimerView.m
//  HaloTimer
//
//  Created by Eric Muller on 1/15/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import "HTWeaponTimerView.h"

@interface HTWeaponTimerView()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) UILabel *weaponLabel;

@end

@implementation HTWeaponTimerView

+ (instancetype)timerViewForWeapon:(NSString *)weapon tintColor:(UIColor *)tintColor
{
    HTWeaponTimerView *timerView = [[HTWeaponTimerView alloc] init];
    timerView.tintColor = tintColor;
    [timerView setWeapon:weapon];
    return timerView;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setupAndLayoutViews];
    }
    return self;
}

- (void)setupAndLayoutViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.timeLabel];
    
    self.weaponLabel = [[UILabel alloc] init];
    self.weaponLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.weaponLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.weaponLabel];
    
    NSDictionary *views = @{@"time": self.timeLabel, @"weapon": self.weaponLabel};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=40)-[weapon]-40-[time]-(>=40)-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=100)-[weapon]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
}

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    self.timeLabel.textColor = tintColor;
    self.weaponLabel.backgroundColor = tintColor;
}

- (void)countdown
{
    self.time = (self.time == 0) ? self.weaponTiming - 1 : self.time - 1;
}

- (void)setTime:(NSInteger)time
{
    _time = MAX(0, time);
    self.timeLabel.text = [NSString stringWithFormat:@"%d", _time];
    [self.timeLabel sizeToFit];
}

- (void)setWeapon:(NSString *)weaponInitials
{
    self.weaponLabel.text = weaponInitials;
    [self.weaponLabel sizeToFit];
}
        
- (void)setWeaponTiming:(NSInteger)weaponTiming
{
    _weaponTiming = weaponTiming;
    self.time = weaponTiming;
}

@end
