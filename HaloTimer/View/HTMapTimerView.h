//
//  HTMapTimerView.h
//  HaloTimer
//
//  Created by Eric Muller on 1/15/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import "HTMap.h"
#import <UIKit/UIKit.h>

@interface HTMapTimerView : UIView

- (void)setMap:(HTMap *)map;
- (void)countdown;

@end
