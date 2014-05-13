//
//  BKForecastDetailsViewController.m
//  MyWeather
//
//  Created by Bill Kastanakis on 5/13/14.
//  Copyright (c) 2014 Bill Kastanakis. All rights reserved.
//

#import "BKForecastDetailsViewController.h"

@interface BKForecastDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation BKForecastDetailsViewController

- (BOOL)isToday:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDate *today = [calendar dateFromComponents:components];
    components = [calendar components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:date];
    NSDate *otherDate = [calendar dateFromComponents:components];
    
    if([today isEqualToDate:otherDate]) {
        return YES;
    } else {
        return NO;
    }
    
}

- (void)animateCloseButton {
    
    [self.closeButton setNeedsUpdateConstraints];

    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:.3 initialSpringVelocity:.3 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [self.closeButton setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
        [self.closeButton layoutIfNeeded];
    } completion:nil];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.closeButton setTransform:CGAffineTransformMakeScale(0.95, 0.95)];
    
    [self.descriptionLabel setText:[self.forecast description]];
    
    NSString *temperature = [NSString stringWithFormat:@"%.0fC", [self.forecast temperature]];
    [self.temperatureLabel setText:temperature];
    
    if ([self isToday:self.forecast.date]) {
        
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"HH:mm"];
        
        NSString *date = [NSString stringWithFormat:@"Today at %@", [timeFormatter stringFromDate:[self.forecast date]]];
        [self.dateLabel setText:date];
        
    } else {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE dd MMMM, HH:mm"];
        [self.dateLabel setText:[dateFormatter stringFromDate:[self.forecast date]]];
        
    }

}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self animateCloseButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)closeTapped:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}



@end
