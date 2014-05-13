//
//  BKForecastTableViewCell.h
//  MyWeather
//
//  Created by Bill Kastanakis on 5/13/14.
//  Copyright (c) 2014 Bill Kastanakis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKForecastTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
