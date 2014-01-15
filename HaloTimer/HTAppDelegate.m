//
//  HTAppDelegate.m
//  HaloTimer
//
//  Created by Eric Muller on 1/13/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import "HTAppDelegate.h"
#import "HTMapListViewController.h"

@implementation HTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // iOS 7 fanciness - big up Remote, Safari, and Vesper
    SEL clearBG = NSSelectorFromString(@"_setApplicationIsOpaque:");
    if ([[UIApplication sharedApplication] respondsToSelector:clearBG]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [[UIApplication sharedApplication] performSelector:clearBG withObject:NO];
#pragma clang diagnostic pop
        self.window.backgroundColor = [UIColor clearColor];
    }
    
    self.window.rootViewController = [HTMapListViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
