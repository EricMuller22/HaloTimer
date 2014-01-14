//
//  HTMapListDataSource.h
//  HaloTimer
//
//  Created by Eric Muller on 1/13/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMapListDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong, readonly) NSArray *maps;

@end
