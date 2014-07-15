//
//  MRCDay.m
//
//  Created by mathew cruz on 6/18/14.
//  Copyright (c) 2014 Mathew Cruz. All rights reserved.
//

#import "MRCDay.h"

@interface MRCDay ()
@property (nonatomic, strong, readwrite) NSString *weekDayNameShort;
@property (nonatomic, strong) NSDateComponents *dayComponents;
@end

@implementation MRCDay

- (instancetype)initWithDate:(NSDate *)date {
    self = [super initWithDate:date];
    if (!self.dateRange) {
        self = nil;
    }
    _dayComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth|NSCalendarUnitDay|NSMonthCalendarUnit fromDate:self.dateRange.startDate];
    return self;
}

- (NSArray *)nameSymbols {
    return [[NSCalendar currentCalendar] weekdaySymbols];
}

- (NSString *)weekDayNameShort {
    if (_weekDayNameShort) {
        return _weekDayNameShort;
    }
    _weekDayNameShort = [[NSCalendar currentCalendar] shortWeekdaySymbols][self.dayComponents.weekday - 1]; //Weekday starts at 1
    return _weekDayNameShort;
}

- (BOOL)isInWeekend {
    if ([[NSCalendar currentCalendar] respondsToSelector:@selector(isDateInWeekend:)]) {
        return [[NSCalendar currentCalendar] isDateInWeekend:self.dateRange.startDate];
    }
    return self.components.weekday == 1 || self.components.weekday == 7;
}

- (NSUInteger)numberOfElements {
    return [[NSCalendar currentCalendar] rangeOfUnit:[self calendarSubUnit] inUnit:[self calendarUnit] forDate:self.dateRange.startDate].length + 1;
}

- (NSDateComponents *)components {
    return [self.dayComponents copy];
}

- (NSCalendarUnit)calendarUnit {
    return NSCalendarUnitDay;
}

- (NSCalendarUnit)calendarSubUnit {
    return NSCalendarUnitHour;
}

- (NSString *)subComponentsKeyPath {
    return @"hour";
}

- (NSString *)componentsKeyPath {
    return @"weekday";
}

- (Class)calendarSubUnitClass {
    return [NSDate class];
}

@end
