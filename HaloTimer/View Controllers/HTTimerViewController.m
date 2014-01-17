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
@property (strong, nonatomic) UIView *mapInfoView;

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
    
    self.timerView = [[HTMapTimerView alloc] init];
    [self.view addSubview:self.timerView];
    
    self.timingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
    self.timingButton.layer.cornerRadius = 44;
    self.timingButton.clipsToBounds = YES;
    [self.timingButton addTarget:self action:@selector(timingButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timingButton];
    
    self.mapInfoView = [[UIView alloc] init];
    self.mapInfoView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.mapInfoView];
    
    self.timerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.timingButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.mapInfoView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"timers": self.timerView,
                            @"button": self.timingButton,
                            @"mapInfo": self.mapInfoView,
                            @"view": self.view};
    // timers
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[timers]|" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
    // map info
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.mapInfoView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[timers][mapInfo(132)]|" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
    
    // button
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timingButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:88]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timingButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:88]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timingButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timingButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.mapInfoView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
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
