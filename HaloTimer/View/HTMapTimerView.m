//
//  HTMapTimerView.m
//  HaloTimer
//
//  Created by Eric Muller on 1/15/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import "HTMapTimerView.h"
#import "HTWeaponTimerView.h"

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
    
    self.rocketTimerView = [HTWeaponTimerView timerViewForWeapon:@"Rocket" tintColor:[UIColor orangeColor]];
    self.sniperTimerView = [HTWeaponTimerView timerViewForWeapon:@"Shotgun" tintColor:[UIColor grayColor]];
    self.shotgunTimerView = [HTWeaponTimerView timerViewForWeapon:@"Sniper" tintColor:[UIColor purpleColor]];
    self.overshieldTimerView = [HTWeaponTimerView timerViewForWeapon:@"Overshield" tintColor:[UIColor redColor]];
    self.camoTimerView = [HTWeaponTimerView timerViewForWeapon:@"Active Camo" tintColor:[UIColor blueColor]];
    
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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rocket][sniper(==rocket)][shotgun(==rocket)][overshield(==rocket)][camo(==rocket)]|" options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight metrics:nil views:views]];
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
