//
//  MRCDay.m
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
