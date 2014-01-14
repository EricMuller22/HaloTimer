//
//  HTMap.m
//  HaloTimer
//
//  Created by Eric Muller on 1/13/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import "HTMap.h"

@implementation HTMap

+ (instancetype)mapWithName:(NSString *)name
                     rocket:(NSInteger)rocket
                     sniper:(NSInteger)sniper
                    shotgun:(NSInteger)shotgun
                       camo:(NSInteger)camo
                 overshield:(NSInteger)overshield
{
    HTMap *map = [HTMap new];
    map.name = name;
    map.rocket = rocket;
    map.sniper = sniper;
    map.shotgun = shotgun;
    map.camo = camo;
    map.overshield = overshield;
    return map;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name: %@", self.name];
}

@end
