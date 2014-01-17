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
    HTWeaponTimerView *timerView = [HTWeaponTimerView new];
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
    self.backgroundColor = [UIColor clearColor];
    
    UIFont *labelFont = [UIFont fontWithName:@"Lato" size:28.0];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.timeLabel.font = labelFont;
    [self addSubview:self.timeLabel];
    
    self.weaponLabel = [UILabel new];
    self.weaponLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.weaponLabel.font = labelFont;
    [self addSubview:self.weaponLabel];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:0.5 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.weaponLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:0.5 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.weaponLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:0.5 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:0]];
}

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    self.timeLabel.textColor = tintColor;
    self.weaponLabel.textColor = tintColor;
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
