//
//  HTMap.h
//  HaloTimer
//
//  Created by Eric Muller on 1/13/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMap : NSObject

+ (instancetype)mapWithName:(NSString *)name
                     rocket:(NSInteger)rocket
                     sniper:(NSInteger)sniper
                    shotgun:(NSInteger)shotgun
                       camo:(NSInteger)camo
                 overshield:(NSInteger)overshield;

// Map info
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *screenshot;

// Weapon timings
@property (nonatomic, assign) NSInteger rocket;
@property (nonatomic, assign) NSInteger sniper;
@property (nonatomic, assign) NSInteger shotgun;
@property (nonatomic, assign) NSInteger camo;
@property (nonatomic, assign) NSInteger overshield;

@end
