//
//  MRCMonth.m
//
//  Created by mathew cruz on 6/18/14.
//  Copyright (c) 2014 Mathew Cruz. All rights reserved.
//

#import "MRCMonth.h"
#import "MRCDateRange.h"
#import "MRCDay.h"
#import "MRCWeek.h"

@interface MRCMonth ()
@property (nonatomic, strong) MRCDateRange *visableRange;
@property (nonatomic, strong) MRCDateRange *leadingRange;
@property (nonatomic, strong) MRCDateRange *trailingRange;
@property (nonatomic, assign, readwrite) NSUInteger numberOfWeeks;
@property (nonatomic, assign, readwrite) NSUInteger monthNumber;
@property (nonatomic, assign) NSUInteger dayRangeForBlockRange;
@property (nonatomic, strong) NSMutableArray *weekCache;
@end

@interface MRCDayGridSection : NSObject
@property (nonatomic, strong) MRCDay *day;
@property (nonatomic, assign) CGPoint location;
@end

@implementation MRCDayGridSection @end

@implementation MRCMonth

- (instancetype)initWithMonth:(NSInteger)month {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    components.month = month;
    return [[MRCMonth alloc] initWithDate:[[NSCalendar currentCalendar] dateFromComponents:components]];
}

- (instancetype)initWithDate:(NSDate *)date {
    self = [super initWithDate:date];
    _weekCache = [@[[NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null]] mutableCopy];
    NSUInteger componentValues = NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth;
    
    NSDateComponents *addingComponents = [NSDateComponents new];
    addingComponents.day = -1;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentValues fromDate:self.dateRange.startDate];
    
    _monthNumber = components.month;
    components.weekday = 1;
    
    NSDate *startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    _leadingRange = [[MRCDateRange alloc] initWithStartDate:startDate endDate:[[NSCalendar currentCalendar] dateByAddingComponents:addingComponents toDate:self.dateRange.startDate options:0]];
    
    components = [[NSCalendar currentCalendar] components:componentValues fromDate:self.dateRange.endDate];
    components.weekday = 7;
    
    NSDate *endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    addingComponents.day = 1;
    _trailingRange = [[MRCDateRange alloc] initWithStartDate:[[NSCalendar currentCalendar] dateByAddingComponents:addingComponents toDate:self.dateRange.endDate options:0] endDate:endDate];

    components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:startDate toDate:endDate options:0];
    _visableRange = [[MRCDateRange alloc] initWithStartDate:startDate endDate:endDate];
    _dayRangeForBlockRange = [components day] + 1;
    return self;
}

- (NSUInteger)numberOfWeeks {
    if (_numberOfWeeks) {
        return _numberOfWeeks;
    }
    _numberOfWeeks = [[NSCalendar currentCalendar] rangeOfUnit:NSWeekCalendarUnit inUnit:NSCalendarUnitMonth forDate:self.dateRange.startDate].length;
    return _numberOfWeeks;
}

- (MRCWeek *)week:(NSInteger)weekNumber {
    if (self.weekCache[weekNumber - 1] != [NSNull null]) {
        return self.weekCache[weekNumber - 1];
    }
    NSMutableArray *daysForWeek = [NSMutableArray new];
    
    if (!self.useBlockDates) {
        for (MRCDay *day in self) {
            if (day.components.weekOfMonth == weekNumber) {
                [daysForWeek addObject:day];
            }
        }
    }
    else
    {
        NSInteger count = [[[NSCalendar currentCalendar] weekdaySymbols] count];
        for (NSInteger index = 0; index < count; index++) {
            MRCDay *day = [self subelementForNumber:index + ((weekNumber - 1) * count) date:nil];
            [daysForWeek addObject:day];
        }
    }
    MRCWeek *week = [[MRCWeek alloc] initWithElements:daysForWeek];
    self.weekCache[weekNumber - 1] = week;
    return week;
}

- (NSArray *)nameSymbols {
    return [[NSCalendar currentCalendar] monthSymbols];
}

- (void)setUseBlockDates:(BOOL)useBlockDates {
    BOOL oldBlockDates = _useBlockDates;
    _useBlockDates = useBlockDates;
    if (_useBlockDates != oldBlockDates) {
        [self clearCache];
    }
}

- (NSUInteger)numberOfElements {
    if (_useBlockDates) {
        return self.dayRangeForBlockRange;
    }
    return [super numberOfElements];
}

- (MRCDateRange *)dateRange {
    if (self.isUsingBlockDates) {
        return self.visableRange;
    }
    return [super dateRange];
}

- (NSCalendarUnit)calendarUnit {
    return NSCalendarUnitMonth;
}

- (NSCalendarUnit)calendarSubUnit {
    return NSCalendarUnitDay;
}

- (NSString *)subComponentsKeyPath {
    return @"day";
}

- (NSString *)componentsKeyPath {
    return @"month";
}

- (Class)calendarSubUnitClass {
    return [MRCDay class];
}

@end
