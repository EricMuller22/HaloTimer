//
//  HTTimerViewController.m
//  HaloTimer
//
//  Created by Eric Muller on 1/14/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import "HTTimerViewController.h"
#import "HTMapTimerView.h"
#import "HTMapInfoView.h"
#import "HTMapListViewController.h"
#import "HTMapListDataSource.h"

@interface HTTimerViewController () <UIPopoverControllerDelegate, HTMapListDelegate>

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) HTMapTimerView *timerView;
@property (strong, nonatomic) UIButton *timingButton;
@property (strong, nonatomic) HTMapInfoView *mapInfoView;

@property (strong, nonatomic) UIPopoverController *mapPopoverController;

@property (strong, nonatomic) HTMap *map;

@end

typedef NS_ENUM(NSInteger, HTTimerButtonStatus) {
    HTTimerButtonReadyToStart,
    HTTimerButtonReadyToReset
};

static const CGFloat HTTimerButtonRadius = 33.0;

@implementation HTTimerViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.alpha = 0.9f;
    
    self.timerView = [HTMapTimerView new];
    [self.view addSubview:self.timerView];
    
    self.timingButton = [UIButton new];
    self.timingButton.layer.cornerRadius = HTTimerButtonRadius;
    self.timingButton.clipsToBounds = YES;
    [self.timingButton addTarget:self action:@selector(timingButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timingButton];
    
    self.mapInfoView = [HTMapInfoView new];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentMapList)];
    [self.mapInfoView addGestureRecognizer:tap];
    [self.view addSubview:self.mapInfoView];
    
    [self setupAutoLayout];
}

- (void)setupAutoLayout
{
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
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[mapInfo(132)]-32-[timers]|" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
    
    // button
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timingButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:HTTimerButtonRadius * 2]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timingButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:HTTimerButtonRadius * 2]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timingButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:HTTimerButtonRadius / 4]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timingButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.mapInfoView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTimerButtonState:HTTimerButtonReadyToStart];
    self.map = [HTMapListDataSource maps][0];
}

#pragma mark - Rotation

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    if (self.mapPopoverController) {
        [self.mapPopoverController presentPopoverFromRect:self.mapInfoView.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

#pragma mark - Timing

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

- (void)setTimerButtonState:(HTTimerButtonStatus)status
{
    if (status == HTTimerButtonReadyToReset) {
        self.timingButton.backgroundColor = [UIColor grayColor];
    } else {
        self.timingButton.backgroundColor = [UIColor greenColor];
    }
}

#pragma mark - Map selection

- (void)setMap:(HTMap *)map
{
    [self.timerView setMap:map];
    [self.mapInfoView setMap:map];
    _map = map;
}

- (void)presentMapList
{
    HTMapListViewController *mapListViewController = [HTMapListViewController new];
    mapListViewController.mapDelegate = self;
    self.mapPopoverController = [[UIPopoverController alloc] initWithContentViewController:mapListViewController];
    self.mapPopoverController.delegate = self;
    self.mapPopoverController.popoverContentSize = CGSizeMake(320, 480);
    [self.mapPopoverController presentPopoverFromRect:self.mapInfoView.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)mapListViewController:(HTMapListViewController *)mapListViewController didSelectMap:(HTMap *)map
{
    [self setMap:map];
    [self.mapPopoverController dismissPopoverAnimated:YES];
    self.mapPopoverController = nil;
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.mapPopoverController = nil;
}

@end
