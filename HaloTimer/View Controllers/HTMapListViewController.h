//
//  HTMapListViewController.h
//  HaloTimer
//
//  Created by Eric Muller on 1/13/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMap.h"

@class HTMapListViewController;

@protocol HTMapListDelegate <NSObject>

- (void)mapListViewController:(HTMapListViewController *)mapListViewController didSelectMap:(HTMap *)map;

@end

@interface HTMapListViewController : UITableViewController

@property (nonatomic, weak) id<HTMapListDelegate> delegate;

@end
