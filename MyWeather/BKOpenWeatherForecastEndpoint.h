//
//  BKOpenWeatherForecast.h
//  MyWeather
//
//  Created by Bill Kastanakis on 5/13/14.
//  Copyright (c) 2014 Bill Kastanakis. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ForecastEndpointCompletionHandler)(NSData *data, NSURLResponse *response, NSError *error);

@interface BKOpenWeatherForecastEndpoint : NSObject

+ (void)requestForecastForCity:(NSString *)city withCompletionHandler:(ForecastEndpointCompletionHandler)completionBlock;

@end
