//
//  HTTimerViewController.m
//  HaloTimer
//
//  Created by Eric Muller on 1/14/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import "HTTimerViewController.h"
#import "HTMapTimerView.h"
#import "HTMapListDataSource.h"

@interface HTTimerViewController ()

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) HTMapTimerView *timerView;
@property (strong, nonatomic) UIButton *timingButton;

@property (strong, nonatomic) HTMap *map;

@end

@implementation HTTimerViewController

- (void)viewDidLoad
{
    self.timerView = [[HTMapTimerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) -40)];
    [self.view addSubview:self.timerView];
    
    self.timingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 40, CGRectGetWidth(self.view.frame), 40)];
    self.timingButton.backgroundColor = [UIColor greenColor];
    self.timingButton.titleLabel.text = @"Start";
    [self.timingButton addTarget:self action:@selector(timingButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timingButton];
}

- (void)timingButtonPressed
{
    if (self.timer) {
        // reset weapon timers
        [self.timer invalidate];
        self.timer = nil;
        [self.timerView setMap:self.map];
        
        // set button to ready to start
        [self.timingButton setBackgroundColor:[UIColor greenColor]];
    } else {
        // start counting down
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self.timerView selector:@selector(countdown) userInfo:nil repeats:YES];
        
        // set button to ready for reset
        self.timingButton.backgroundColor = [UIColor grayColor];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    HTMapListDataSource *dataSource = [HTMapListDataSource new];
    self.map = [dataSource maps][0];
}

- (void)setMap:(HTMap *)map
{
    [self.timerView setMap:map];
    _map = map;
}

@end
