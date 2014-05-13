//
//  BKWeatherHelper.m
//  MyWeather
//
//  Created by Bill Kastanakis on 5/13/14.
//  Copyright (c) 2014 Bill Kastanakis. All rights reserved.
//

#import "BKWeatherHelper.h"
#import "BKOpenWeatherForecastEndpoint.h"
#import "BKForecast.h"

@implementation BKWeatherHelper

+ (void)requestForecastForCity:(NSString *)city withCompletionHandler:(WeatherHelperCompletionHandler)completionHandler {
    
    [BKOpenWeatherForecastEndpoint requestForecastForCity:@"Athens,Gr" withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!error) {
            if (httpResponse.statusCode == 200) {
                
                NSError *error;
                NSDictionary *forecastJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                
                NSArray *list = [forecastJSON valueForKey:@"list"];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
                
                NSMutableArray *forecastArray = [NSMutableArray array];
                
                for (NSDictionary *item in list) {
                    float temp = [[item valueForKeyPath:@"main.temp"] floatValue];
                    NSString *description = [[item valueForKeyPath:@"weather.description"] firstObject];
                    NSDate* date = [dateFormatter dateFromString:[item valueForKey:@"dt_txt"]];
                    
                    BKForecast *forecast = [[BKForecast alloc] initWithDate:date temperature:temp andDescription:description];
                    [forecastArray addObject:forecast];
                    
                }
                
                completionHandler(forecastArray, nil);
                
            } else {
                completionHandler(nil, error);
            }
            
        } else {
                completionHandler(nil, error);
        }
        
    }];
    
}

@end
