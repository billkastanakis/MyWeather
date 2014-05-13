//
//  BKMainViewController.m
//  MyWeather
//
//  Created by Bill Kastanakis on 5/13/14.
//  Copyright (c) 2014 Bill Kastanakis. All rights reserved.
//

#import "BKMainViewController.h"

@interface BKMainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *athensButton;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backdropImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backdropImageHeightConstraint;

@end

@implementation BKMainViewController

#pragma mark - View Animations

- (void)pullCoverBackAnimation {
    
    [self.coverImageView setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.coverImageView setTransform:CGAffineTransformMakeScale(0.8, 0.8)];
        [self.coverImageView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.0 delay:0.0 options:0 animations:^{
            [self.coverImageView setAlpha:0.0];
        } completion:^(BOOL finished) {
            
            [self.athensButton setNeedsUpdateConstraints];
            
            [UIView animateWithDuration:0.2 delay:0 options:0 animations:^{
                [self.athensButton setAlpha:1.0];
            } completion:nil];
            
            [UIView animateWithDuration:0.6 delay:0.0 usingSpringWithDamping:.24 initialSpringVelocity:.6 options:0 animations:^{
                [self.athensButton setTransform:CGAffineTransformMakeTranslation(0, 20)];
                [self.athensButton layoutIfNeeded];
            } completion:nil];
            
        }];
    }];
    
}


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!isiPhone5) {
        [self.coverImageView setImage:[UIImage imageNamed:@"Cover960"]];
        [self.backdropImageView setImage:[UIImage imageNamed:@"Logo960"]];
        [self.coverImageHeightConstraint setConstant:480.0];
        [self.backdropImageHeightConstraint setConstant:480.0];
    }
    
    [_athensButton setAlpha:0.0];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self pullCoverBackAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}


@end
