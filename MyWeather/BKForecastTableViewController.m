//
//  BKForecastTableViewController.m
//  MyWeather
//
//  Created by Bill Kastanakis on 5/13/14.
//  Copyright (c) 2014 Bill Kastanakis. All rights reserved.
//

#import "BKForecastTableViewController.h"
#import "BKWeatherHelper.h"
#import "BKForecast.h"
#import "BKForecastTableViewCell.h"
#import "BKForecastDetailsViewController.h"

@interface BKForecastTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) NSArray *forecastArray;
@end

@implementation BKForecastTableViewController


#pragma mark - Helpers

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

#pragma mark - View Lifecycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [BKWeatherHelper requestForecastForCity:@"Athens,Gr" withCompletionHandler:^(NSArray *forecastArray, NSError *error) {
        if (!error) {
            
            self.forecastArray = forecastArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            });
            
        } else {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"ForecastDetails"]) {
        
        BKForecastDetailsViewController *detailsController = [segue destinationViewController];
        BKForecast *forecast = [self.forecastArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        [detailsController setForecast:forecast];
        
    }
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableVie
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.forecastArray)
        return [self.forecastArray count];
    else
        return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.forecastArray) {
        
        BKForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastCell" forIndexPath:indexPath];
        
        BKForecast *forecast = [self.forecastArray objectAtIndex:indexPath.row];
        
        NSString *temperature = [NSString stringWithFormat:@"%.0fC", forecast.temperature];
        [cell.temperature setText:temperature];
        [cell.description setText:[forecast description]];
        
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"HH:mm"];
        [cell.time setText:[timeFormatter stringFromDate:forecast.date]];
        
        if ([self isToday:forecast.date]) {
            [cell.day setText:@"Today"];
        } else {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEEE"];
            [cell.day setText:[dateFormatter stringFromDate:forecast.date]];
        }
        
        return cell;
        
    } else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FetchingCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (self.forecastArray) {
        return 64.0f;
    } else {
        return 100.0f;
    }
}


@end
