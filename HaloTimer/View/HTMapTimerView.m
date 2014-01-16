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
    self.backgroundColor = [UIColor whiteColor];
    
    self.rocketTimerView = [HTWeaponTimerView timerViewForWeapon:@"Ro" tintColor:[UIColor orangeColor]];
    self.sniperTimerView = [HTWeaponTimerView timerViewForWeapon:@"Sh" tintColor:[UIColor grayColor]];
    self.shotgunTimerView = [HTWeaponTimerView timerViewForWeapon:@"S" tintColor:[UIColor purpleColor]];
    self.overshieldTimerView = [HTWeaponTimerView timerViewForWeapon:@"OS" tintColor:[UIColor redColor]];
    self.camoTimerView = [HTWeaponTimerView timerViewForWeapon:@"AC" tintColor:[UIColor blueColor]];
    
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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[rocket]-20-|" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rocket(180)]-[sniper(180)]-[shotgun(180)]-[overshield(180)]-[camo(180)]|" options:NSLayoutFormatAlignAllRight metrics:nil views:views]];
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