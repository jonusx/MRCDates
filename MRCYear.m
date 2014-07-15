//
//  MRCYear.m
//
//  Created by mathew cruz on 6/18/14.
//  Copyright (c) 2014 Mathew Cruz. All rights reserved.
//

#import "MRCYear.h"
#import "MRCDateRange.h"
#import "MRCMonth.h"

@interface MRCYear ()
@end

@implementation MRCYear


+ (instancetype)yearFromYearNumber:(NSUInteger)year {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    components.year = year;
    return [[MRCYear alloc] initWithDate:[[NSCalendar currentCalendar] dateFromComponents:components]];
}

- (NSCalendarUnit)calendarUnit {
    return NSCalendarUnitYear;
}

- (NSCalendarUnit)calendarSubUnit {
    return NSCalendarUnitMonth;
}

- (NSString *)subComponentsKeyPath {
    return @"month";
}

- (Class)calendarSubUnitClass {
    return [MRCMonth class];
}

@end
