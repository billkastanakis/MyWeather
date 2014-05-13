//
//  BKForecast.h
//  MyWeather
//
//  Created by Bill Kastanakis on 5/13/14.
//  Copyright (c) 2014 Bill Kastanakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKForecast : NSObject

@property (nonatomic, strong) NSString* description;
@property (assign) float temperature;
@property (nonatomic, strong) NSDate *date;

- (instancetype)initWithDate:(NSDate *)date temperature:(float)temperature andDescription:(NSString*)description;

@end
