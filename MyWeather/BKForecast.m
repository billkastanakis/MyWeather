//
//  BKForecast.m
//  MyWeather
//
//  Created by Bill Kastanakis on 5/13/14.
//  Copyright (c) 2014 Bill Kastanakis. All rights reserved.
//

#import "BKForecast.h"

@implementation BKForecast

- (instancetype)initWithDate:(NSDate *)date temperature:(float)temperature andDescription:(NSString*)description
{
    self = [super init];
    if (self) {
        self.date = date;
        self.temperature = temperature;
        self.description = description;
    }
    return self;
}

@end
