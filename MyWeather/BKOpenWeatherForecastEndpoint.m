//
//  BKOpenWeatherForecast.m
//  MyWeather
//
//  Created by Bill Kastanakis on 5/13/14.
//  Copyright (c) 2014 Bill Kastanakis. All rights reserved.
//

#import "BKOpenWeatherForecastEndpoint.h"

@implementation BKOpenWeatherForecastEndpoint

+ (void)requestForecastForCity:(NSString *)city withCompletionHandler:(ForecastEndpointCompletionHandler)completionBlock {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast?q=%@&units=metric", city]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:completionBlock] resume];
    
}

@end
