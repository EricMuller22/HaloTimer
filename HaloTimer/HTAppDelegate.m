//
//  HTAppDelegate.m
//  HaloTimer
//
//  Created by Eric Muller on 1/13/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import "HTAppDelegate.h"
#import "HTMapListDataSource.h"

@implementation HTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    HTMapListDataSource *dataSourceTest = [[HTMapListDataSource alloc] init];
    NSLog(@"%@", dataSourceTest.maps);
    [self.window makeKeyAndVisible];
    return YES;
}

@end
