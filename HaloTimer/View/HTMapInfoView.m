//
//  HTMapInfoView.m
//  HaloTimer
//
//  Created by Eric Muller on 1/17/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import "HTMapInfoView.h"
#import "UIColor+HexString.h"

@interface HTMapInfoView()

@property (nonatomic, strong) UIImageView *screenshotView;
@property (nonatomic, strong) UILabel *mapNameLabel;

@end

static const CGFloat HTScreenshotRadius = 66.0;

@implementation HTMapInfoView

- (id)init
{
    self = [super init];
    if (self) {
        [self setupAndLayoutViews];
    }
    return self;
}

- (void)setupAndLayoutViews
{
    self.backgroundColor = [UIColor clearColor];
    
    self.mapNameLabel = [UILabel new];
    self.mapNameLabel.font = [UIFont fontWithName:@"Lato" size:28.0];
    self.mapNameLabel.textColor = [UIColor colorWithHexString:@"#2C3E50"];
    [self addSubview:self.mapNameLabel];
    
    self.screenshotView = [UIImageView new];
    self.screenshotView.layer.cornerRadius = HTScreenshotRadius;
    self.screenshotView.contentMode = UIViewContentModeScaleAspectFill;
    self.screenshotView.clipsToBounds = YES;
    [self addSubview:self.screenshotView];
    
    self.mapNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.screenshotView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"name": self.mapNameLabel,
                            @"screenshot": self.screenshotView};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[screenshot]-12-[name]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.mapNameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:HTScreenshotRadius / 3]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.screenshotView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.screenshotView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:HTScreenshotRadius * 2]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.screenshotView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:HTScreenshotRadius * 2]];

}

- (void)setMap:(HTMap *)map
{
    self.mapNameLabel.text = map.name;
    [self.mapNameLabel sizeToFit];
    [self.screenshotView setImage:map.screenshot];
}

@end
