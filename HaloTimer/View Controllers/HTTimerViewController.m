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
    
    self.timerView = [[HTMapTimerView alloc] init];
    [self.view addSubview:self.timerView];
    
    self.timingButton = [[UIButton alloc] init];
    [self.timingButton addTarget:self action:@selector(timingButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timingButton];
    
    self.timerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.timingButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"timers": self.timerView,
                            @"button": self.timingButton,
                            @"view": self.view};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[timers]|" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button(==view)]|" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[timers][button(40)]|" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
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
