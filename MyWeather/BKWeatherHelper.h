//
//  BKWeatherHelper.h
//  MyWeather
//
//  Created by Bill Kastanakis on 5/13/14.
//  Copyright (c) 2014 Bill Kastanakis. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WeatherHelperCompletionHandler)(NSArray *forecastArray, NSError *error);

@interface BKWeatherHelper : NSObject

+ (void)requestForecastForCity:(NSString *)city withCompletionHandler:(WeatherHelperCompletionHandler)completionHandler;

@end
