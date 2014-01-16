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
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.alpha = 0.9f;
    
    self.timerView = [[HTMapTimerView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.timerView];
    
    self.timingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 40, CGRectGetWidth(self.view.frame), 40)];
    [self.timingButton addTarget:self action:@selector(timingButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timingButton];
    
//    NSDictionary *views = @{@"timers": self.timerView,
//                            @"button": self.timingButton};
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[timers][button(buttonHeight)]|" options:NSLayoutFormatAlignAllRight metrics:@{@"buttonHeight": @(40)} views:views]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
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
