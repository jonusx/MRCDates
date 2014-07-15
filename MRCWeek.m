//
//  MRCWeek.m
//
//  Created by mathew cruz on 6/18/14.
//  Copyright (c) 2014 Mathew Cruz. All rights reserved.
//

#import "MRCWeek.h"
#import "MRCDateRange.h"
#import "MRCDay.h"

@interface MRCWeek ()
@end

@implementation MRCWeek

- (NSCalendarUnit)calendarUnit {
    return NSCalendarUnitWeekOfMonth;
}

- (NSCalendarUnit)calendarSubUnit {
    return NSCalendarUnitWeekday;
}

- (NSString *)subComponentsKeyPath {
    return @"weekday";
}

- (Class)calendarSubUnitClass {
    return [MRCDay class];
}

@end
