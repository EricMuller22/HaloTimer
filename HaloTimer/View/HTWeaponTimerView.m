//
//  HTWeaponTimerView.m
//  HaloTimer
//
//  Created by Eric Muller on 1/15/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import "HTWeaponTimerView.h"
#import "UIColor+HexString.h"

@interface HTWeaponTimerView()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) UILabel *weaponLabel;
@property (nonatomic, strong) UIView *weaponSpawnIndicator;

@end

@implementation HTWeaponTimerView

+ (instancetype)timerViewForWeapon:(NSString *)weapon displayColor:(UIColor *)displayColor
{
    HTWeaponTimerView *timerView = [HTWeaponTimerView new];
    timerView.displayColor = displayColor;
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
    
    self.weaponSpawnIndicator = [UIView new];
    self.weaponSpawnIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    self.weaponSpawnIndicator.backgroundColor = [UIColor clearColor];
    self.weaponSpawnIndicator.layer.borderWidth = 4.0;
    self.weaponSpawnIndicator.alpha = 0.0;
    [self addSubview:self.weaponSpawnIndicator];
    
    // time label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:0.5 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:0]];
    
    // weapon label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.weaponLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:0.5 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.weaponLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:0.5 constant:0]];
    
    // spawn indicator
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.weaponSpawnIndicator attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.66 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.weaponSpawnIndicator attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.weaponSpawnIndicator attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.weaponSpawnIndicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.timeLabel attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.weaponSpawnIndicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.timeLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

- (void)setDisplayColor:(UIColor *)displayColor
{
    _displayColor = displayColor;
    [self updateColoring:_displayColor];
}

- (void)updateColoring:(UIColor *)color
{
    self.timeLabel.textColor = color;
    self.weaponLabel.textColor = color;
    self.weaponSpawnIndicator.layer.borderColor = color.CGColor;
}

- (void)countdown
{
    self.time = (self.time == 0) ? self.weaponTiming - 1 : self.time - 1;
    if (self.time == 9) {
        [self finalCountdown];
    }
}

// I couldn't help it - in related news, I may be sleep deprived
- (void)finalCountdown
{
    [UIView animateWithDuration:9.9 animations:^{
        self.weaponSpawnIndicator.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.weaponSpawnIndicator.alpha = 0.0;
    }];
}

- (void)cancelCountdown
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.weaponSpawnIndicator.alpha = 0.0;
    [UIView commitAnimations];
}

- (void)setTime:(NSInteger)time
{
    _time = MAX(0, time);
    self.timeLabel.text = [NSString stringWithFormat:@"%ld", (long)_time];
    [self.timeLabel sizeToFit];
}

- (void)setWeapon:(NSString *)weaponInitials
{
    self.weaponLabel.text = weaponInitials;
    [self.weaponLabel sizeToFit];
}
        
- (void)setWeaponTiming:(NSInteger)weaponTiming
{
    if (!weaponTiming) {
        [self updateColoring:[UIColor colorWithHexString:@"#BDC3C7"]];
    } else {
        [self updateColoring:self.displayColor];
    }
    [self cancelCountdown];
    _weaponTiming = weaponTiming;
    self.time = weaponTiming;
}

@end
