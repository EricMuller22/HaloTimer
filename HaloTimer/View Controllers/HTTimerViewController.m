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

typedef NS_ENUM(NSInteger, HTTimerButtonStatus) {
    HTTimerButtonReadyToStart,
    HTTimerButtonReadyToReset
};

@implementation HTTimerViewController

- (void)viewDidLoad
{
    self.timerView = [[HTMapTimerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) -40)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.timerView];
    
    self.timingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 40, CGRectGetWidth(self.view.frame), 40)];
    self.timingButton.backgroundColor = [UIColor greenColor];
    self.timingButton.titleLabel.text = @"Start";
    [self.timingButton addTarget:self action:@selector(timingButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timingButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTimerButtonState:HTTimerButtonReadyToStart];
    HTMapListDataSource *dataSource = [HTMapListDataSource new];
    self.map = [dataSource maps][0];
}

- (void)timingButtonPressed
{
    if (self.timer) {
        [self resetTimer];
        [self setTimerButtonState:HTTimerButtonReadyToStart];
    } else {
        // start counting down
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self.timerView selector:@selector(countdown) userInfo:nil repeats:YES];
        [self setTimerButtonState:HTTimerButtonReadyToReset];
    }
}

- (void)resetTimer
{
    [self.timer invalidate];
    self.timer = nil;
    [self.timerView setMap:self.map];
}

- (void)setMap:(HTMap *)map
{
    [self.timerView setMap:map];
    _map = map;
}

- (void)setTimerButtonState:(HTTimerButtonStatus)status
{
    if (status == HTTimerButtonReadyToReset) {
        self.timingButton.backgroundColor = [UIColor grayColor];
    } else {
        self.timingButton.backgroundColor = [UIColor greenColor];
    }
}

@end
