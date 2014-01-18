//
//  HTMapTimerView.m
//  HaloTimer
//
//  Created by Eric Muller on 1/15/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import "HTMapTimerView.h"
#import "HTWeaponTimerView.h"
#import <UIColor+HTMLColors.h>

@interface HTMapTimerView()

@property (nonatomic, strong) HTWeaponTimerView *rocketTimerView;
@property (nonatomic, strong) HTWeaponTimerView *sniperTimerView;
@property (nonatomic, strong) HTWeaponTimerView *shotgunTimerView;
@property (nonatomic, strong) HTWeaponTimerView *overshieldTimerView;
@property (nonatomic, strong) HTWeaponTimerView *camoTimerView;

@end

@implementation HTMapTimerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupAndLayoutViews];
    }
    return self;
}

- (void)setupAndLayoutViews
{
    self.backgroundColor = [UIColor clearColor];
    
    self.rocketTimerView = [HTWeaponTimerView timerViewForWeapon:@"Rocket" displayColor:[UIColor colorWithHexString:@"#D35400"]];
    self.shotgunTimerView = [HTWeaponTimerView timerViewForWeapon:@"Shotgun" displayColor:[UIColor colorWithHexString:@"#27AE60"]];
    self.sniperTimerView = [HTWeaponTimerView timerViewForWeapon:@"Sniper" displayColor:[UIColor colorWithHexString:@"#8E44AD"]];
    self.overshieldTimerView = [HTWeaponTimerView timerViewForWeapon:@"Overshield" displayColor:[UIColor colorWithHexString:@"#C0392B"]];
    self.camoTimerView = [HTWeaponTimerView timerViewForWeapon:@"Active Camo" displayColor:[UIColor colorWithHexString:@"#2980B9"]];
    
    [self addSubview:self.rocketTimerView];
    [self addSubview:self.sniperTimerView];
    [self addSubview:self.shotgunTimerView];
    [self addSubview:self.overshieldTimerView];
    [self addSubview:self.camoTimerView];
    
    for (UIView *view in self.subviews) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    NSDictionary *views = @{@"rocket": self.rocketTimerView,
                            @"sniper": self.sniperTimerView,
                            @"shotgun": self.shotgunTimerView,
                            @"overshield": self.overshieldTimerView,
                            @"camo": self.camoTimerView};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[rocket]|" options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight metrics:nil views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.rocketTimerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.2 constant:0]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[overshield(==rocket)][camo(==rocket)][rocket][sniper(==rocket)][shotgun(==rocket)]|" options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight metrics:nil views:views]];
}

- (void)setMap:(HTMap *)map
{
    [self.rocketTimerView setWeaponTiming:map.rocket];
    [self.sniperTimerView setWeaponTiming:map.sniper];
    [self.shotgunTimerView setWeaponTiming:map.shotgun];
    [self.overshieldTimerView setWeaponTiming:map.overshield];
    [self.camoTimerView setWeaponTiming:map.camo];
}

- (void)countdown
{
    for (HTMapTimerView *timerView in self.subviews) {
        [timerView countdown];
    }
}

@end
