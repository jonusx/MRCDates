//
//  MRCMonth.h
//
//  Created by mathew cruz on 6/18/14.
//  Copyright (c) 2014 Mathew Cruz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRCDate.h"

@class MRCDay, MRCWeek;

@interface MRCMonth : MRCDate

@property (nonatomic, assign, readonly) NSUInteger numberOfWeeks;
@property (nonatomic, assign, getter = isUsingBlockDates) BOOL useBlockDates;
@property (nonatomic, assign, readonly) NSUInteger monthNumber;

- (instancetype)initWithMonth:(NSInteger)month;
- (instancetype)initWithDate:(NSDate *)date;
- (MRCWeek *)week:(NSInteger)weekNumber;

@end
