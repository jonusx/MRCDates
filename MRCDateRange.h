//
//  MRCDateRange.h
//
//  Created by mathew cruz on 6/18/14.
//  Copyright (c) 2014 Mathew Cruz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCDateRange : NSObject

@property (nonatomic, strong, readonly) NSDate *startDate;
@property (nonatomic, strong, readonly) NSDate *endDate;

- (instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (instancetype)dateRangeWithStartBeginningDate:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (instancetype)dateRangeWithTodayForUnitRange:(NSCalendarUnit)calendarUnitRange;
+ (instancetype)dateRangeAroundDate:(NSDate *)date forUnitRange:(NSCalendarUnit)calendarUnitRange;

+ (NSDate *)startDateForUnit:(NSCalendarUnit)unit date:(NSDate *)date;
@end
