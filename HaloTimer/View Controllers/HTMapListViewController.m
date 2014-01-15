//
//  HTMapListViewController.m
//  HaloTimer
//
//  Created by Eric Muller on 1/13/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import "HTMapListViewController.h"
#import "HTMapListDataSource.h"

@interface HTMapListViewController () <UITableViewDelegate>

@property (nonatomic, strong) id<UITableViewDataSource> dataSource;

@end

static const CGFloat HTMapListCellHeight = 64.0;

@implementation HTMapListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.alpha = 0.85f;
    self.dataSource = [HTMapListDataSource new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[[UITableViewCell class] description]];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HTMapListCellHeight;
}

@end
