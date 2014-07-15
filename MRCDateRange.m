//
//  MRCDateRange.m
//
//  Created by mathew cruz on 6/18/14.
//  Copyright (c) 2014 Mathew Cruz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "MRCDateRange.h"

@interface MRCDateRange ()
@property (nonatomic, strong, readwrite) NSDate *startDate;
@property (nonatomic, strong, readwrite) NSDate *endDate;
@end

@implementation MRCDateRange

- (instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    self = [super init];
    _startDate = startDate;
    _endDate = endDate;
    return self;
}

+ (instancetype)dateRangeWithStartBeginningDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    return [[MRCDateRange alloc] initWithStartDate:startDate endDate:endDate];
}

+ (instancetype)dateRangeWithTodayForUnitRange:(NSCalendarUnit)calendarUnitRange {
    return [MRCDateRange dateRangeAroundDate:[NSDate date] forUnitRange:calendarUnitRange];
}

+ (instancetype)dateRangeAroundDate:(NSDate *)date forUnitRange:(NSCalendarUnit)calendarUnitRange {
    if (!date) {
        return nil;
    }
    NSDate *startDate = [MRCDateRange startDateForUnit:calendarUnitRange date:date];
    NSInteger intervalToEndDate = [MRCDateRange intervalForDate:startDate inUnit:calendarUnitRange];
    NSDate *endDate = [MRCDateRange dateByAddingUnit:calendarUnitRange with:intervalToEndDate forDate:startDate];
    endDate = [endDate dateByAddingTimeInterval:-60]; //This will contain the date range within the range specified.
    return [[MRCDateRange alloc] initWithStartDate:startDate endDate:endDate];
}

+ (NSDate *)startDateForUnit:(NSCalendarUnit)unit date:(NSDate *)date {
    NSDate *todayStartDate;
    [[NSCalendar currentCalendar] rangeOfUnit:unit startDate:&todayStartDate interval:nil forDate:date];
    return todayStartDate;
}

+ (NSInteger)intervalForDate:(NSDate *)date inUnit:(NSCalendarUnit)unit {
    NSCalendarUnit containingUnit = unit;
    NSCalendarUnit unitNeeded = unit;
    switch (unit) {
        case NSCalendarUnitWeekOfMonth:
            return [[[NSCalendar currentCalendar] weekdaySymbols] count];
            break;
        case NSCalendarUnitYear:
            unitNeeded = NSCalendarUnitMonth;
            break;
        default:
            containingUnit >>= 1;
            unitNeeded <<= 1;
            break;
    }
    return [[NSCalendar currentCalendar] rangeOfUnit:unitNeeded inUnit:unit forDate:date].length;
}

+ (NSDate *)dateByAddingUnit:(NSCalendarUnit)unit with:(NSInteger)value forDate:(NSDate *)date {
    NSDateComponents *components = [NSDateComponents new];
    switch (unit) {
        case NSCalendarUnitMinute:
            components.minute = value;
            break;
        case NSCalendarUnitHour:
            components.minute = value;
            break;
        case NSCalendarUnitDay:
            components.hour = value;
            break;
        case NSCalendarUnitMonth:
            components.day = value;
            break;
        case NSCalendarUnitWeekOfMonth:
            components.day = value;
            break;
        case NSCalendarUnitYear:
            components.month = value;
            break;
        default:
            break;
    }
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0];
}

@end
